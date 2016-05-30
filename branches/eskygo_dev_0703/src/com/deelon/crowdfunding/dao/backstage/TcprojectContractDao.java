/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import org.springframework.stereotype.Repository;
import com.deelon.core.db.BaseDao;

import com.deelon.crowdfunding.model.backstage.TcprojectContract;


@Repository
public class TcprojectContractDao extends  BaseDao<TcprojectContract>{
	
	public Class getEntityClass()
	 {
	     return TcprojectContract.class;
	 }

}
