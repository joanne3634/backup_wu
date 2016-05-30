package com.deelon.crowdfunding.dao.backstage;

import com.deelon.core.db.BaseDao;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.model.backstage.TuserApplyLeader;
import org.springframework.stereotype.Repository;

import java.util.List;
/**
 * Powered By [MyLiao]
 * 申请领投资格审核DAO
 */
@Repository
public class TuserApplyLeaderDao extends BaseDao<TuserApplyLeader>{
	
	public Class<TuserApplyLeader> getEntityClass(){
	     return TuserApplyLeader.class;
	}
	
	/**
	 * 查询所有申请领投资格信息
	 * @param queryFilter
	 * @return
	 */
	public List<TuserApplyLeader> getApplyLeaderInfo(QueryFilter queryFilter){
		return getBySqlKey("getApplyLeaderInfo", queryFilter);
	}
	
	/**
	 * 查询领投人信息
	 * @param leaderId
	 * @return
	 */
	public TuserApplyLeader getLeaderInfoDetail(long leaderId){
		return getUnique("getLeaderInfoDetail", leaderId);
	}
	
	/**
	 * 查询正在审核中的领投人信息，审核通过：1，未通过：2
	 * @author xul
	 * @param user
	 */
	public List<TuserApplyLeader> getListByPojo(TuserApplyLeader user){
		return getBySqlKey("getListByPojo", user);
	}
}
