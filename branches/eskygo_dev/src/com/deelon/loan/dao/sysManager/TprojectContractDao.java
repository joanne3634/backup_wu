/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TProjectContract;


@Repository
public class TprojectContractDao extends  BaseDao<TProjectContract>{
	
	public Class getEntityClass()
	 {
	     return TProjectContract.class;
	 }
	
	
	public List<TProjectContract> getAllContarct(QueryFilter queryFilter){
		return getBySqlKey("getAllContarct", queryFilter);
	}

}
