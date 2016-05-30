/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */


package com.deelon.loan.service.sysManager;

import java.util.List;

import javax.annotation.Resource;




import org.springframework.stereotype.Service;

import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.sysManager.TUserMobileChangeDao;
import com.deelon.loan.model.sysManager.TUserMobileChange;

@ Service
public class TUserMobileChangeService extends BaseService<TUserMobileChange>{
	
	@ Resource
	private TUserMobileChangeDao tUserModelChangeDao;
	
	protected IEntityDao<TUserMobileChange, Long> getEntityDao()
	{
		return this.tUserModelChangeDao;
	}
}