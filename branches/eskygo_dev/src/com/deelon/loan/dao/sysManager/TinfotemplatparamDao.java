/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import org.springframework.stereotype.Repository;
import com.deelon.core.db.BaseDao;

import com.deelon.loan.model.sysManager.Tinfotemplatparam;


@Repository
public class TinfotemplatparamDao extends  BaseDao<Tinfotemplatparam>{
	
	public Class getEntityClass()
	 {
	     return Tinfotemplatparam.class;
	 }

}
