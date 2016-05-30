package com.deelon.loan.dao.sysManager;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.sysManager.Tsmsinformation;




@Repository
public class TsmsinformationDao extends  BaseDao<Tsmsinformation>{
	
	public Class<Tsmsinformation> getEntityClass()
	 {
	     return Tsmsinformation.class;
	 }
	/**
	 * 根据查询条件获得待发送的短信
	 * @param queryFilter
	 * @return
	 */
	public List<Tsmsinformation> getSmsInfo(QueryFilter queryFilter){
		return getBySqlKey("getSmsInfo", queryFilter);
	}
}
