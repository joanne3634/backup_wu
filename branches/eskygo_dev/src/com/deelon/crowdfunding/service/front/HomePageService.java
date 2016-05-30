package com.deelon.crowdfunding.service.front;

import com.deelon.core.util.AppUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.common.constants.WuyouchouErrorCode;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectNews;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.backstage.TprojectNewsService;
import com.deelon.loan.dao.backstage.TSettingsDao;
import com.deelon.loan.model.backstage.TSettings;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 众筹项目首页展示信息处理接口类
 * @author Administrator
 *
 */
@ Service
public class HomePageService {

	protected Logger logger = LoggerFactory.getLogger(HomePageService.class);
	@Resource
	private TcprojectService tcprojectService;
	@Resource
	private TprojectNewsService tprojectNewsService;
	@Resource
	private TSettingsDao tSettingsDao;
	/**
	 * 首页为获取最新项目，推荐项目，成功项目提供数据接口
	 * @param pstaus 
	 * @param pisRecommomend
	 * @return
	 */
	public List<Tcproject> getTcprojectsByStatus(String pstaus, String pisRecommomend,int limitCount){
		QueryFilter queryFilter=new QueryFilter();
		queryFilter.addFilter("pstateId", pstaus);//项目当前状态
		queryFilter.addFilter("pisRecommended", pisRecommomend);//项目是否为审核推荐项目
		queryFilter.addFilter("limitCount",limitCount);
		List<Tcproject> list = tcprojectService.getAll(queryFilter);
		return list;
	}

	/**
	 * 查询预热期项目
	 * @param limitCount 查询记录上限
	 * @return
	 */
	public List<Tcproject> getWarmUpProjects(int limitCount){
		QueryFilter queryFilter=new QueryFilter();
		queryFilter.addFilter("limitCount",limitCount);
		List<Tcproject> list = tcprojectService.getWarmUpProject(queryFilter);
		String minAmount = null;
	try {

//		logger.info((String)AppUtil.getServletContext().getAttribute("INVESTOR_MIN_PERCENT"));
		minAmount= (String)AppUtil.getServletContext().getAttribute("INVESTOR_MIN_PERCENT");
		if(null==minAmount){
			logger.warn("未获取到最小投资比例");
			throw new RuntimeException("未获取到最小投资比例");
			}
		if (null != list && !list.isEmpty()) {
			for (Tcproject project : list) {
				int lastDays = daysBetween(project.getPopenDate(),new Date());
				project.setLastDays(lastDays < 0 ? 0 : lastDays);
				project.setSingleMinAmount(project.getPfinancingAmount().
						multiply(new BigDecimal(minAmount)).divide(new BigDecimal(1000000), 0, RoundingMode.UP));
			}
			}
		}
		catch (Exception e){
			logger.error("获取setting配置异常",e);
		}
		return list;
	}
	/**
	 * 首页获取成功案例（状态为 4 5 6）
	 * @return
	 */
	public List<Tcproject> getSuccessTcProjects(){
		List<Tcproject> list = tcprojectService.getSuccessTcProjects();
		return list;
	}

	/**
	 * 首页为获取热门数据供数据接口
	 * @param limitCount 页面展示的项目数量
	 * @return
	 */
	public List<Tcproject> getTcprojectsByViewHot(int limitCount){
		List<Tcproject> list = new ArrayList<Tcproject>();
		try {
			TSettings tSettingst = tSettingsDao.getTSettingsBySetCode("INVESTOR_MIN_PERCENT");
			QueryFilter filter =new QueryFilter();
			filter.addFilter("limitCount",limitCount);
			list = tcprojectService.getAllHotProjects(filter);
			if (list != null && list.size() > 0) {
				for (Tcproject tc : list) {
					String cityName = tc.getPcityIname();
					//如果是直辖市区划，则只显示一级
					if ("市辖区".equals(cityName) || "县".equals(cityName)) {
						tc.setPcityIname("");
					}
					int lastDays = daysBetween(new Date(), tc.getPopenDate());
					/**
					 * 处理剩余天数显示负数的问题【负数显示为0】
					 */
					int lastDaysView = tc.getPopenDays() - lastDays;
					if (lastDaysView < 0) {
						lastDaysView = 0;
					}
					tc.setLastDays(lastDaysView);
					tc.setSingleMinAmount(tc.getPfinancingAmount().multiply(new BigDecimal(tSettingst.getSetValue())).divide(new BigDecimal(1000000), 0, RoundingMode.UP));
				}
			}

		}catch (Exception e){
			logger.error("project detail error:errorCode = "+ WuyouchouErrorCode.PRJ_HOME_PAGE_ERROR.getErrorCode(),e);

		}
		return list;
	}
	/** 
     * 计算两个日期之间相差的天数 
     * @param date1 
     * @param date2 
     * @return 
     */  
    public static int daysBetween(Date date1,Date date2)  
    {  
        Calendar cal = Calendar.getInstance();  
        cal.setTime(date1);
		long time1 = cal.getTimeInMillis();
        cal.setTime(date2);  
        long time2 = cal.getTimeInMillis();       
        long between_days=(time1-time2)/(1000*3600*24);  
          
       return Integer.parseInt(String.valueOf(between_days));         
    }  
	/**
	 * 查询项目动态
	 * @return
	 */
	public List<TcprojectNews> getTcprojectNewsByTypeId(){
		QueryFilter filter = new QueryFilter();
		filter.addFilter("pntypeId", "1");//TcprojectNews。pntypeId 为1时，即查询项目的动态
		filter.addFilter("isDel", "0");//TcprojectNews。isDel 为0时，即查询项目动态记录未被删除
		List<TcprojectNews>  list = tprojectNewsService.getAllByTypeId(filter);
		return list;
	}

}