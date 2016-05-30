/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */

package com.deelon.cmsform.dao.site;

import org.springframework.stereotype.Repository;
import com.deelon.core.db.BaseDao;

import com.deelon.cmsform.model.site.CmsSiteConfig;


@Repository
public class CmsSiteConfigDao extends  BaseDao<CmsSiteConfig>{
	
	public Class getEntityClass()
	 {
	     return CmsSiteConfig.class;
	 }

}
