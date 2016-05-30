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
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.aboutus.TUserMessage;
import com.deelon.loan.model.sysManager.TuserReport;


@Repository
public class TuserReportDao extends  BaseDao<TuserReport>{
	
	public Class getEntityClass()
	 {
	     return TuserReport.class;
	 }
	
	
	/**
	 * 查询用户举报记录,
	 * @param queryFilter
	 * @return
	 */
	public List<TuserReport> getUserReportList(QueryFilter queryFilter){
		return getBySqlKey("getUserReportList", queryFilter);
	}
	public List<TuserReport> getUserId(int userid){
		Map params = new HashMap();  
		params.put("creator", userid); 
		List<TuserReport> tuserReport =getBySqlKey("getUserId",params);
		return tuserReport;
	}
}
