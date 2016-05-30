/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.service.backstage;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.dao.backstage.TcprojectDao;
import com.deelon.crowdfunding.dao.backstage.TcprojectInvestDao;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;

@ Service
public class TcprojectInvestService extends BaseService<TcprojectInvest>{
	
	@ Resource
	private TcprojectInvestDao tcprojectInvestDao;
	
	@ Resource
	private TcprojectDao tcprojectDao;
	
	protected IEntityDao<TcprojectInvest, Long> getEntityDao()
	{
		return this.tcprojectInvestDao;
	}
	
	/**
	 * 1.查询投资人的 所有投标项目(userId)
	 * 2.查询投资的其中一条投资项目(projectId,userId)
	 * 3.查询项目下的投资人(projectid)
	 * @param projectId 可为空
	 * @param userId 可为空
	 * @param ispay 是否放款,1.已放款,0,未放款
	 * @param isCancel 是否取消投标,1.已取消,0,未取消
	 * @param piisLeader 是否为领投人 1.是,0.否
	 * @param
	 * @param
	 * @return
	 */
	//
	public List<TcprojectInvest> getInvestforPro(Map<String,Object> map,PageBean pb){
		return tcprojectInvestDao.getInvestforPro(map,pb);
	}
	
	//暂时用于解决反悔记录查不出的bug，待重构时与getInvestforPro方法合并
	public List<TcprojectInvest> getPullBackRecords(Map<String,Object> map,PageBean pb){
		return tcprojectInvestDao.getPullBackRecords(map,pb);
	}
	
	/**
	 * 查询用户的投资详情
	 * @param map
	 * @param pb
	 * @return
	 */
	public List<TcprojectInvest> getUserInvestList(Map<String,Object> map,PageBean pb){
		return tcprojectInvestDao.getUserInvestList(map,pb);
		
	}
	
	/**
	 * 查询用户的总的投资记录
	 * @param userId
	 * @return
	 */
	public TcprojectInvest getUserInvestSum(long userId){
		return tcprojectInvestDao.getUserInvestSum(userId);
	}
	
	/**
	 * 1.查询投资人的 所有投标项目(userId)
	 * 2.查询投资的其中一条投资项目(projectId,userId)
	 * 3.查询项目下的投资人(projectid)
	 * @param projectId 可为空
	 * @param userId 可为空
	 * @param ispay 是否放款,1.已放款,0,未放款
	 * @param isCancel 是否取消投标,1.已取消,0,未取消
	 * @param piisLeader 是否为领投人 1.是,0.否
	 * @param
	 * @param
	 * @return
	 */
	//
	public List<TcprojectInvest> getInvestforPro(QueryFilter queryFilter){
		return tcprojectInvestDao.getInvestforPro(queryFilter);
	}

	
	public List<TcprojectInvest> getInvestforProBymap(Map<String,Object> map){
		return tcprojectInvestDao.getInvestforProBymap(map);
	}
	
	/**
	 * 插入数据
	 * @param tcprojectInvest
	 */
	public void addInvest(TcprojectInvest tcprojectInvest){
		tcprojectInvestDao.addInvest(tcprojectInvest);
	}
	
	/**
	 * 1.查询全部领投项目
	 */
	public List<TcprojectInvest> getLeadInvestforPro(Long projectId){
		
		return tcprojectInvestDao.getLeadInvestforPro(projectId);
	}
	
	
	
	/*
	 * 更新项目的类型
	 */
	public void update(TcprojectInvest entity){
		tcprojectInvestDao.update(entity);
	}
	
	/*
	 * 根据用户id和工程id查询记录
	 */
	public List<TcprojectInvest> getTcprojectInvest(Long projectId,Long userId){
		QueryFilter filter = new QueryFilter();
		filter.addFilter("projectId", projectId);
		filter.addFilter("userId", userId);
		List<TcprojectInvest> tcprojectInvests = tcprojectInvestDao.getBySqlKeyAll(filter, TcprojectInvest.class, "getTcprojectInvest");
		return tcprojectInvests;
	}
	
	/*
	 * 取消领投
	 */
	public void cancleLed(TcprojectInvest tcprojectInvest){
		tcprojectInvestDao.update(tcprojectInvest);
	}
	/*
	 * 取消跟投
	 */
	public void cancleVote(TcprojectInvest tcprojectInvest){
		tcprojectInvestDao.update(tcprojectInvest);
	}

	public List<TcprojectInvest> getInvestDetailById(String investId) {
		// TODO Auto-generated method stub
		return tcprojectInvestDao.getInvestDetailById(investId);
	}

	public Long getleadCountCr(Long projectId) {
		// TODO Auto-generated method stub
		return tcprojectInvestDao.getleadCountCr(projectId);
	}
	public List<TcprojectInvest> getTprojectInvestByProId(Long projectId) {
		// TODO Auto-generated method stub
		return tcprojectInvestDao.getTprojectInvestByProId(projectId);
	}
	
	
	//查询最小估值
	public TcprojectInvest getMinValueByProId(long proId){
		return tcprojectInvestDao.getMinValueByProId(proId);
	}
}