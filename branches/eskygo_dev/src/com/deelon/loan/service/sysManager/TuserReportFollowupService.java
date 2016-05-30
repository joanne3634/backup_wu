/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.sysManager;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.sysManager.TuserReportFollowupDao;
import com.deelon.loan.model.sysManager.TuserReportFollowup;

@ Service
public class TuserReportFollowupService extends BaseService<TuserReportFollowup>{
	
	@ Resource
	private TuserReportFollowupDao tuserReportFollowupDao;
	
	protected IEntityDao<TuserReportFollowup, Long> getEntityDao()
	{
		return this.tuserReportFollowupDao;
	}
	public List<TuserReportFollowup> getByReportId(long ReportId)
	{
		return this.tuserReportFollowupDao.getByReportId(ReportId);
	}

}