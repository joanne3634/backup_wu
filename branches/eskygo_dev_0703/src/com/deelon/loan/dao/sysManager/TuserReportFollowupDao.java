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
import com.deelon.loan.model.aboutus.TUserMessage;
import com.deelon.loan.model.sysManager.TuserReportFollowup;


@Repository
public class TuserReportFollowupDao extends  BaseDao<TuserReportFollowup>{
	
	public Class getEntityClass()
	 {
	     return TuserReportFollowup.class;
	 }
	public List<TuserReportFollowup> getByReportId(long ReportId){
		Map params = new HashMap();  
		params.put("Report_id", ReportId); 
		List<TuserReportFollowup> tuserMessage =getBySqlKey("getByReportId",params);
		return tuserMessage;
	}
}
