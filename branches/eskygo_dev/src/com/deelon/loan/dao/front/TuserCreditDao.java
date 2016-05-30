/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.front;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TuserCredit;


@Repository
public class TuserCreditDao extends  BaseDao<TuserCredit>{
	
	public Class getEntityClass()
	 {
	     return TuserCredit.class;
	 }

	public void saveTuserCredit(TuserCredit tuserCredit){
		update("add", tuserCredit);
	}
}
