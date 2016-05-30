/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */


package com.deelon.cmsform.service.site;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.cmsform.dao.site.CmsSiteConfigDao;
import com.deelon.cmsform.model.site.CmsSiteConfig;

@ Service
public class CmsSiteConfigService extends BaseService<CmsSiteConfig>{
	
	@ Resource
	private CmsSiteConfigDao cmsSiteConfigDao;
	
	protected IEntityDao<CmsSiteConfig, Long> getEntityDao()
	{
		return this.cmsSiteConfigDao;
	}

}