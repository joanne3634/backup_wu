/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.BeanUtils;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.model.backstage.Tcproject;


@Repository
public class TcprojectDao extends  BaseDao<Tcproject>{
	
	public Class getEntityClass()
	 {
	     return Tcproject.class;
	 }
	


	
	/**
	 * 查询待审核的项目
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getToAuditPro(QueryFilter queryFilter){
		return getBySqlKey("getToAuditPro", queryFilter);
	}
	
	/**
	 * 查询所有满标的项目
	 * @param queryFilter
	 * @return
	 * @throws Exception
	 */
	public List<Tcproject> getAllFullTender(QueryFilter queryFilter) throws Exception{
		return getBySqlKey("getAllFullTender", queryFilter);
	}
	/**
	 * 有创业者名字,照片 的项目
	 * @param proId
	 * @return
	 */
	public Tcproject getTcprojectById(long proId){
		return getUnique("getTcprojectById", proId);
	}
	
	/**
	 * 查询满标的项目或符合满标条件的项目
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getFullTenderForPro(QueryFilter queryFilter){
		 return getBySqlKey("getFullTenderForPro", queryFilter);
	}
	
	/**
	 * 查询过期的项目
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getExpiredForPro(QueryFilter queryFilter){
		 return getBySqlKey("getExpiredForPro", queryFilter);
	}
	
	/**
	 * 查询招标中的项目
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getInvitationforPro(QueryFilter queryFilter){
		return getBySqlKey("getInvitationforPro", queryFilter);
	}
	
	/**
	 * 根据条件查询项目
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getAllProByWhere(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getAllProByWhere", map,pb);
	}
	
	/**
	 * 根据条件查询项目
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getAllHotProjects(){
		return getBySqlKey("getAllHotProjects");
	}

	/**
	 * 查询成功案例（状态为4，5，6）
	 * @return
	 */
	public List<Tcproject> getSuccessTcProjects(){
		return getBySqlKey("getSuccessTcProjects");
	}

	
	/**
	 * 查询有项目的城市
	 * @return
	 */
	public List<Tcproject> getProOfCitys(){
		return getBySqlKey("getProOfCitys");
	}
	/**
	 * 查询领投人数量
	 * @return
	 */
	public Long getProLeadCount(Long projectId){
		return (Long)getOne("projectLeadCount",projectId);
	}
	/**
	 * 查询跟投人数量
	 * @return
	 */
	public Long getProFollowCount(Long projectId){
		return (Long)getOne("projectFollowCount",projectId);
	}
	/**
	 * 查询创业者项目
	 * @return
	 */
	public List<Tcproject> getProjectCr(QueryFilter filter){
		return getBySqlKey("getProjectCr",filter);
	}
	
	/**
	 * 查询用户创建的所有项目
	 * @return
	 */
	public List<Tcproject> getProjectByUserId(Long userId){
		return getBySqlKey("getProjectByUserId", userId);
	}




	public List<Tcproject> getAllSendMoney(QueryFilter qf) {
		return getBySqlKey("getAllSendMoney",qf);
	}
	
}
