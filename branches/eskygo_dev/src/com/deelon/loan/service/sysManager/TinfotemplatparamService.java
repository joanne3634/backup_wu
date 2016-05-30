/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.sysManager;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.sysManager.TinfotemplatparamDao;
import com.deelon.loan.model.sysManager.Tinfotemplatparam;

@ Service
public class TinfotemplatparamService extends BaseService<Tinfotemplatparam>{
	
	@ Resource
	private TinfotemplatparamDao tinfotemplatparamDao;
	
	protected IEntityDao<Tinfotemplatparam, Long> getEntityDao()
	{
		return this.tinfotemplatparamDao;
	}

}