/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.front;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TProjectAccept;


@Repository
public class TprojectAcceptDao extends  BaseDao<TProjectAccept>{
	
	public Class getEntityClass()
	 {
	     return TProjectAccept.class;
	 }
	
	

}
