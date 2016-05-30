/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.front;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.DateFormatUtil;
import com.deelon.core.util.DateUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.front.TProjectInvestDao;
import com.deelon.loan.model.front.TProjectInvest;

@ Service
public class TprojectInvestService extends BaseService<TProjectInvest>{
	
	@ Resource
	private TProjectInvestDao tprojectInvestDao;
	
	protected IEntityDao<TProjectInvest, Long> getEntityDao()
	{
		return this.tprojectInvestDao;
	}
	/**
	 * 保存投资记录，代码生成主键
	 * 
	 * 
	 */
	public void saveTProjectInvest(TProjectInvest projectInvest){
		tprojectInvestDao.saveTProjectInvest(projectInvest);
	}
	
	/**
	 * 
	 * @param userId 投资人id
	 * @param plTypeId 投标类型,自动还是手动
	 * @return
	 */
	public List<TProjectInvest> getTProjectInvestByUserId(QueryFilter queryFilter){
		return tprojectInvestDao.getTProjectInvestByUserId(queryFilter);
	}
	
	/**
	 * 获取用户的理财统计
	 * @param userId
	 * @return
	 */
	public TProjectInvest getCountInfo(Long userId){
		return tprojectInvestDao.getCountInfo(userId);
	}
	
	
	/**
	 * 获取用户 等待收款的记录
	 * @return
	 */
	public List<TProjectInvest> getWaitingForthePayMent(Map<String,Object> map,PageBean pb){
		return tprojectInvestDao.getWaitingForthePayMent(map,pb);
	}

	/**
	 * 获取用户正在收款的记录
	 * @return
	 */
	public List<TProjectInvest> getRePayMenetList(Map<String,Object> map,PageBean pb){
		return tprojectInvestDao.getRePayMenetList(map,pb);
	}
	
	/**
	 * 获取用户已收款完成的记录
	 * @return
	 */
	public List<TProjectInvest> getPayOffList(Map<String,Object> map,PageBean pb){
		return tprojectInvestDao.getPayOffList(map,pb);
	}
	
	/**
	 * 根据用户id和项目id查询一条记录
	 * @param proId 
	 * @param userId
	 * @return
	 */
	public TProjectInvest getTProjectInvestByUserIdAndProId(long proId,long userId){
		return tprojectInvestDao.getTProjectInvestByUserIdAndProId(proId,userId);
	}
	
	/**
	 * 通过项目id查询记录
	 * @param project
	 * @return
	 */
	public List<TProjectInvest> getTprojectInvestByProId(Long projectid,PageBean pb){
		return tprojectInvestDao.getTprojectInvestByProId(projectid,pb);
	}
	/**
	 * 查询用户可用来进行债权转让的投资记录
	 * @param investId 用来判断申请的记录是否存在有转让的记录存在
	 * @param applyName
	 * @param pname
	 * @param userId
	 * @param pb
	 * @return
	 */
	public List<TProjectInvest> getmyCanTransfers(Long investId,String applyName, String pname, Long userId, PageBean pb) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("applyName", applyName);
		map.put("pname", pname);
		map.put("userId", userId);
		map.put("investId", investId);
		return tprojectInvestDao.getBySqlKey("getProjectInvestsByCnd", map,pb);
	}
	/**
	 * 获取用户转让中的债权
	 * @param piTransferStateId 0未转让，1转让中，2转让成功，3转让失败，4撤回
	 * @param applyName
	 * @param pname
	 * @param userId
	 * @param pb
	 * @return
	 */
	public Object getmyTransferings(String piTransferStateId, String applyName, String pname, Long userId,Long nInvestorId, PageBean pb) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("applyName", applyName);
		map.put("pname", pname);
		map.put("userId", userId);
		map.put("nInvestorId", nInvestorId);
		if("over".equals(piTransferStateId)){//如果传来的参数是over，则表示需要查询截止目前为止转让债权结束的记录
			map.put("closeDate", DateUtil.parseDate(DateFormatUtil.format(new Date(), "yyyy-MM-dd")+" 23:59:59"));
		}else{
			map.put("piTransferStateId", piTransferStateId);
		}
		return tprojectInvestDao.getBySqlKey("getProjectInvestTransfering", map,pb);
	}
	/**
	 * 获取用户的投标次数
	 * @param userId   

	 */
	public long getProjectInvestCount(long userId) {

		return (Long) tprojectInvestDao.getOne("count", userId);
	}

}