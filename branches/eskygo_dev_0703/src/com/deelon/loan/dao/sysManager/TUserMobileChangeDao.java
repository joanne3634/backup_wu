/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */

package com.deelon.loan.dao.sysManager;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.core.db.BaseDao;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.sysManager.TUserMobileChange;
import com.deelon.platform.model.bus.BusQueryRule;


@Repository
public class TUserMobileChangeDao extends  BaseDao<TUserMobileChange>{
	
	public Class getEntityClass()
	 {
	     return TUserMobileChange.class;
	 }
}
