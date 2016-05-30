/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.sysManager;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.sysManager.TinfotemplatDao;
import com.deelon.loan.model.sysManager.Tinfotemplat;

@ Service
public class TinfotemplatService extends BaseService<Tinfotemplat>{
	
	@ Resource
	private TinfotemplatDao tinfotemplatDao;
	
	protected IEntityDao<Tinfotemplat, Long> getEntityDao()
	{
		return this.tinfotemplatDao;
	}

}