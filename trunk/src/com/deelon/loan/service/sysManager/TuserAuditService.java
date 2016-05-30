package com.deelon.loan.service.sysManager;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.crowdfunding.model.backstage.TcuserAudit;
import com.deelon.loan.dao.sysManager.TuserAuditDao;



@ Service
public class TuserAuditService extends BaseService<TcuserAudit>{
	
	@ Resource
	private TuserAuditDao tuserAuditDao;
	
	protected IEntityDao<TcuserAudit, Long> getEntityDao()
	{
		return this.tuserAuditDao;
	}

}