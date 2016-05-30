package com.deelon.loan.service.front;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.front.TuserLoginlogDao;
import com.deelon.loan.model.front.TuserLoginlog;

@ Service
public class TuserLoginlogService extends BaseService<TuserLoginlog>{
	
	@ Resource
	private TuserLoginlogDao tuserLoginlogDao;
	
	protected IEntityDao<TuserLoginlog, Long> getEntityDao()
	{
		return this.tuserLoginlogDao;
	}

}