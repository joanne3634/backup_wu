package com.deelon.loan.dao.front;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TuserLoginlog;




@Repository
public class TuserLoginlogDao extends  BaseDao<TuserLoginlog>{
	
	public Class getEntityClass()
	 {
	     return TuserLoginlog.class;
	 }

}
