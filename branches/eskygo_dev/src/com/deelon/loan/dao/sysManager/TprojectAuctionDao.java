/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import org.springframework.stereotype.Repository;
import com.deelon.core.db.BaseDao;

import com.deelon.loan.model.sysManager.TprojectAuction;


@Repository
public class TprojectAuctionDao extends  BaseDao<TprojectAuction>{
	
	public Class getEntityClass()
	 {
	     return TprojectAuction.class;
	 }

}
