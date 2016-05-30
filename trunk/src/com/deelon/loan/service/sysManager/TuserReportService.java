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
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TuserReportDao;
import com.deelon.loan.model.sysManager.TuserReport;

@ Service
public class TuserReportService extends BaseService<TuserReport>{
	
	@ Resource
	private TuserReportDao tuserReportDao;
	
	protected IEntityDao<TuserReport, Long> getEntityDao()
	{
		return this.tuserReportDao;
	}
	
	/**
	 * 查询用户举报记录,
	 * @param queryFilter
	 * @return
	 */
	public List<TuserReport> getUserReportList(QueryFilter queryFilter){
		return tuserReportDao.getUserReportList(queryFilter);
	}
	public List<TuserReport> getUserId(int userid){
		return tuserReportDao.getUserId(userid);
	}
}