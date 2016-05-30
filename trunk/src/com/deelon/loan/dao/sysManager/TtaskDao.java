/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TTask;
import com.deelon.loan.model.front.TUserFunds;


@Repository
public class TtaskDao extends  BaseDao<TTask>{
	
	public Class getEntityClass()
	 {
	     return TTask.class;
	 }
	
	public List<TTask> getTaskByGroupId(Long groupID,long userId){
		Map map = new HashMap();
		//map.put("userId", userId);
		map.put("groupID", groupID);
		
		return (List<TTask>) getBySqlKey("getTaskByGroupId", map);
	}
	//
//	public void saveOrUpdateTUserFunds(TUserFunds tu){
//		if(tu.getFundsId()!=0){
//			
//			update("update", tu);
//			
//		}else{
//			update("add", tu);
//		}
//	}


}
