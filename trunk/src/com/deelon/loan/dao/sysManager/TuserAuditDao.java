package com.deelon.loan.dao.sysManager;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.crowdfunding.model.backstage.TcuserAudit;

@Repository
public class TuserAuditDao extends  BaseDao<TcuserAudit>{
	
	public Class getEntityClass()
	 {
	     return TcuserAudit.class;
	 }

}