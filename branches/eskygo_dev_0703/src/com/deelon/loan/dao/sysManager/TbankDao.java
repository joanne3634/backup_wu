package com.deelon.loan.dao.sysManager;



import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.sysManager.Tbank;



@Repository
public class TbankDao extends  BaseDao<Tbank>{
	
	public Class getEntityClass()
	 {
	     return Tbank.class;
	 }

	public List getAllOther(QueryFilter queryFilter) {
		// TODO Auto-generated method stub
		return getBySqlKey("getAllOther",queryFilter);
	}
	
	public List<Tbank> getAllByWhere(Map<String,Object> map) {
		return getBySqlKey("getAll",map);
	}

}
