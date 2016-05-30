/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;


@Repository
public class TcprojectInvestDao extends  BaseDao<TcprojectInvest>{
	
	public Class getEntityClass()
	 {
	     return TcprojectInvest.class;
	 }
	
	/**
	 * 1.查询投资人的 所有投标项目(userId)
	 * 2.查询投资的其中一条投资项目(projectId,userId)
	 * 3.查询项目下的投资人(projectid)
	 * @param projectId 可为空
	 * @param userId 可为空
	 * @return
	 */
	public List<TcprojectInvest> getInvestforPro(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getInvestforPro", map,pb);
	}
	
	public List<TcprojectInvest> getPullBackRecords(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getPullBackRecords", map,pb);
	}
	/**
	 * 1.查询投资人的 所有投标项目(userId)
	 * 2.查询投资的其中一条投资项目(projectId,userId)
	 * 3.查询项目下的投资人(projectid)
	 * @param projectId 可为空
	 * @param userId 可为空
	 * @return
	 */
	public List<TcprojectInvest> getInvestforPro(QueryFilter queryFilter){
		return getBySqlKey("getInvestforPro",queryFilter);
	}
	public List<TcprojectInvest> getInvestforProBymap(Map<String,Object> map){
		return getBySqlKey("getInvestforPro", map);
	}
	/**
	 * 1.查询全部领投项目
	 */
	public List<TcprojectInvest> getLeadInvestforPro(Long projectId){
		
		return getBySqlKey("getLeadInvestforPro", projectId);
	}
	
	/**
	 * 插入数据
	 * @param tcprojectInvest
	 */
	public void addInvest(TcprojectInvest tcprojectInvest){
		 update("addInvest", tcprojectInvest);
	}

	public List<TcprojectInvest> getInvestDetailById(String investId) {
		// TODO Auto-generated method stub
		return getBySqlKey("getInvestDetailById", investId);
	}

	public Long getleadCountCr(Long projectId) {
		// TODO Auto-generated method stub
		return (Long)getOne("getleadCountCr",projectId);
	}
	public List<TcprojectInvest> getTprojectInvestByProId(Long projectId) {
		// TODO Auto-generated method stub
		return getBySqlKey("getTprojectInvestByProId", projectId);
	}
	
	/**
	 * //查询最小估值
	 * @param proId
	 * @return
	 */
	public TcprojectInvest getMinValueByProId(long proId){
		return getUnique("getMinValueByProId", proId);
	}
	
	/**
	 * 查询用户的投资详情
	 * @param map
	 * @param pb
	 * @return
	 */
	public List<TcprojectInvest> getUserInvestList(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getUserInvestList",map,pb);
		
	}
	
	/**
	 * 查询用户的总的投资记录
	 * @param userId
	 * @return
	 */
	public TcprojectInvest getUserInvestSum(long userId){
		return  getUnique("getUserInvestSum", userId);
	}

}
