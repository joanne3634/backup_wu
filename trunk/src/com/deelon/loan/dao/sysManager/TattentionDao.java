/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;



import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TAttention;


@Repository
public class TattentionDao extends BaseDao<TAttention> {

	public Class<TAttention> getEntityClass() {
		return TAttention.class;
	}

	/*public List<TProject> getAllProtWaitingAudit(QueryFilter queryFilter) {
		return getBySqlKey("getAllWaitingAudit", queryFilter);
	}*/

	/*public TProject getProjectById(long projectId) {
		return getUnique("getProjectById", projectId);
	}*/

	public int saveTattention(TAttention attention) {
		return insert("saveTAttention", attention);
	}
	
	public TAttention selectTattention(Map map) {
		List<TAttention> list=getBySqlKey("getTAttentionByProjectIdAndUserId", map);
		if(list!=null&&list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	//	return getBySqlKey("getTAttentionByProjectIdAndUserId", map).get(0);
	}
	

}
