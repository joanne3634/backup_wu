package com.deelon.loan.service.sysManager;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.sysManager.TemailinformationDao;
import com.deelon.loan.model.sysManager.Temailinformation;


@ Service
public class TemailinformationService extends BaseService<Temailinformation>{
	
	@ Resource
	private TemailinformationDao temailinformationDao;
	
	protected IEntityDao<Temailinformation, Long> getEntityDao()
	{
		return this.temailinformationDao;
	}

}