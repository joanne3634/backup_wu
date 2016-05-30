/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.front;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TProjectRisk;


@Repository
public class TprojectRiskDao extends  BaseDao<TProjectRisk>{
	
	public Class getEntityClass()
	 {
	     return TProjectRisk.class;
	 }
	
	public int saveOrUpdateTProjectRisk(TProjectRisk tprojectRisk){
		if(tprojectRisk.getRiskId()!=0){
			return update("update", tprojectRisk);
		}else{
			return update("add", tprojectRisk);
		}
	}
	
	public List<TProjectRisk> getAllDataOfUser(QueryFilter queryFilter){
		try {
			List<TProjectRisk> list=getBySqlKey("getAll",queryFilter);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

	public List<TProjectRisk> getAllData(TProjectRisk tprojectRisk){
		return getBySqlKey("getAll", tprojectRisk);
	}
	
	/**
	 * 查询记录 by 贷款项目id
	 * @param proId
	 * @return
	 */
	public TProjectRisk getTProjectRiskByProId(long proId){
		return getUnique("getTProjectRiskByProId", proId);
	}
	/**
	 * 查询记录 by 贷款项目id  以项目风险表为主表
	 * @param proId
	 * @return
	 */
	public TProjectRisk getTprojectRiskInfoByProjectId(long proId){
		return getUnique("getTprojectRiskInfoByProjectId", proId);
	}
	
}
