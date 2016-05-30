package com.deelon.loan.service.sysManager;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.sysManager.TsmsinformationDao;
import com.deelon.loan.model.sysManager.Tsmsinformation;


@ Service
public class TsmsinformationService extends BaseService<Tsmsinformation>{
	
	@ Resource
	private TsmsinformationDao tsmsinformationDao;
	
	protected IEntityDao<Tsmsinformation, Long> getEntityDao()
	{
		return this.tsmsinformationDao;
	}
	
	

}