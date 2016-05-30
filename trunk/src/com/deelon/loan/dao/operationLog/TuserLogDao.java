/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.operationLog;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.TuserLog;


@Repository
public class TuserLogDao extends  BaseDao<TuserLog>{
	
	public Class getEntityClass()
	 {
	     return TuserLog.class;
	 }

}
