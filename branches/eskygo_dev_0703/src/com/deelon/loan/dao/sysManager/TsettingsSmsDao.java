package com.deelon.loan.dao.sysManager;



import java.util.List;

import org.springframework.stereotype.Repository;


import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.sysManager.TsettingsSms;



@Repository
public class TsettingsSmsDao extends  BaseDao<TsettingsSms>{
	
	public Class getEntityClass()
	 {
	     return TsettingsSms.class;
	 }
	
	public List<TsettingsSms> getFirstOne(){
		return (List<TsettingsSms>)getBySqlKey("getFirstOne");
	}

}
