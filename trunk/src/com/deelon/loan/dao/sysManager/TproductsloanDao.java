/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.productsloan.Tproductsloan;


@Repository
public class TproductsloanDao extends  BaseDao<Tproductsloan>{
	
	public Class getEntityClass()
	 {
	     return Tproductsloan.class;
	 }

}
