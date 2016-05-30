/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import org.springframework.stereotype.Repository;
import com.deelon.core.db.BaseDao;

import com.deelon.crowdfunding.model.backstage.TcprojectPayplan;


@Repository
public class TcprojectPayplanDao extends  BaseDao<TcprojectPayplan>{
	
	public Class getEntityClass()
	 {
	     return TcprojectPayplan.class;
	 }

}
