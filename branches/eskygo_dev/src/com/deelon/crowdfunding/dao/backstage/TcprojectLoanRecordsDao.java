/*
 * Powered By [Allen]
 * Since 2013 - 2015
 */

package com.deelon.crowdfunding.dao.backstage;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.crowdfunding.model.backstage.TcprojectLoanRecords;


@Repository
public class TcprojectLoanRecordsDao extends  BaseDao<TcprojectLoanRecords>{
	
	public Class getEntityClass()
	 {
	     return TcprojectLoanRecords.class;
	 }

}
