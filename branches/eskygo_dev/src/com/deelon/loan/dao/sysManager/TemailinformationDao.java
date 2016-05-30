package com.deelon.loan.dao.sysManager;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.sysManager.Temailinformation;




@Repository
public class TemailinformationDao extends  BaseDao<Temailinformation>{
	
	public Class getEntityClass()
	 {
	     return Temailinformation.class;
	 }

}
