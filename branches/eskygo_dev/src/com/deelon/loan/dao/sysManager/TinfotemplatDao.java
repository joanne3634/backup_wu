/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import org.springframework.stereotype.Repository;
import com.deelon.core.db.BaseDao;

import com.deelon.loan.model.sysManager.Tinfotemplat;


@Repository
public class TinfotemplatDao extends  BaseDao<Tinfotemplat>{
	
	public Class getEntityClass()
	 {
	     return Tinfotemplat.class;
	 }

}
