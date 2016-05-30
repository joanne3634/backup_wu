package com.deelon.loan.service.front;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.page.PageBean;
import com.deelon.loan.dao.front.TProjectInvestDao;
import com.deelon.loan.dao.sysManager.TprojectDao;
import com.deelon.loan.dao.sysManager.TsetHomepageDao;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.sysManager.TSetHomepage;
@ Service
public class HomeIndexPageService {
	@Resource
	private TprojectDao tprojectDao;
	@Resource
	private TsetHomepageDao homePageDao;
	@Resource
	private TProjectInvestDao projectInvestDao;
	/**
	 * 获取首页投资列表展现数据
	 * @param count 首页展现数据记录数
	 * @return List<TProject>
	 */
	public Map<String,List<TProject>> getIndexPageprojects(int count){
		Map<String,List<TProject>> indexList = new HashMap<String,List<TProject>> ();
		Map<String, Object> map = new HashMap<String, Object>();
		//map.put("status", "4");
		PageBean pb=new  PageBean(1, 10);
		List<TProject> inglist = tprojectDao.getAllLoanByWhere(map,pb);//统一调用投标列表的接口
		indexList.put("1",inglist);
		if(inglist.size()<count){
			map.put("status", "6");
			inglist = tprojectDao.getBySqlKey("getProjectByCnd", map);
			indexList.put("2",inglist);
			
			map.put("status", "1");
			inglist = tprojectDao.getBySqlKey("getProjectByCnd", map);
			indexList.put("3",inglist);
		}
		return indexList;
	}
	/**
	 * 获取首页投资统计数据
	 * @return List<TProject>
	 */
	public Map<String, Object> getProjectsSum(){
		TProject  tp = tprojectDao.getUnique("getProjectsSum", null);
		HashMap<String, Object> result = new HashMap<String, Object>();
		if(null!=tp){
			result.put("realLoanSum", tp.getSumLoan());
			result.put("realInterestSum", tp.getPsumInterest());
		}else{
			result.put("realLoanSum", "0.000");
			result.put("realInterestSum", "0.000");
		}
		return result;
	}
	/**
	 * 获取首页投资最新数据数据
	 * @return List<TProject>
	 */
	public List<TProjectInvest> getProjectsLatelyInvest(){
		List<TProjectInvest>  result = projectInvestDao.getBySqlKey("getProjectsLatelyInvest");
		return result;
	}
	/**
	 * 获取首页今日投资最高的前几名记录
	 * @return List<TProject>
	 */
	public List<TProjectInvest> getProjectsLatelySumInvest(){
		List<TProjectInvest>  result = projectInvestDao.getBySqlKey("getProjectsLatelySumInvest");
		return result;
	}
	/**
	 * 获取首页投资排行榜数据
	 * @return List<TProject>
	 */
	public List<Map<String, String>> getProjectsInvestDesc(){
		List<Map<String, String>>  tps = tprojectDao.getListBySqlKey("getProjectsInvestDesc", null);
		return tps;
	}
	/**
	 * 根据T_set_homepage表的code_num首页展示编码值获取首页展现模块的对象，用于判断是否显示模块
	 * TSetHomepage属性值isVisiable值为1则表示显示，为0则表示不显示。其他显示参数仅供参考，以首页设计模块展现为准
	 * 返回值可能为空，如果为空则检查传入的code参数与T_set_homepage表中的code_num值是否有一致的记录
	 * @param code
	 * @return TSetHomepage
	 */
	public TSetHomepage getHomePageMoudleByCode(String code){
		
		List<TSetHomepage> list = homePageDao.getAll();
		for(TSetHomepage pageMoudle:list){
			if(pageMoudle.getCode_num().equals(code)){
				return pageMoudle;
			}
		}
		return null;
	}
	
}
