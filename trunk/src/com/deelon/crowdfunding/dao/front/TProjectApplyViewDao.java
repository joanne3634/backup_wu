/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.front;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TBankcard;
import com.deelon.loan.model.front.TProjectApplyView;
import com.deelon.loan.model.front.TUserSafe;


@Repository
public class TProjectApplyViewDao extends  BaseDao<TProjectApplyView>{
	
	public Class getEntityClass()
	 {
	     return TProjectApplyView.class;
	 }
	
	public List<TProjectApplyView> getTProjectApplyViewList(Long projectId){
		return getBySqlKey("getListByProjectId", projectId);
	}
	//public List<TProjectApplyView> getTProjectApplyViewUserList(Long projectId){
	//	return getBySqlKey("getApplyViewUserList", projectId);
	//}
	public Long queryPavAgreeViewCount(Long projectId){
		return (Long)getOne("countPavAgree", projectId);
	}
	
	public void saveTProjectApplyView(TProjectApplyView tProjectApplyView){
			
			//update("update", tbankcard);
			update("add", tProjectApplyView);
	}
	
	public void updateTProjectApplyView(TProjectApplyView tProjectApplyView){
		
		//update("update", tbankcard);
		update("update", tProjectApplyView);
}
	

}
