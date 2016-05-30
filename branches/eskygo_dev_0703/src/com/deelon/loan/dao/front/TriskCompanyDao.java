/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.front;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TriskCompany;


@Repository
public class TriskCompanyDao extends  BaseDao<TriskCompany>{
	
	public Class getEntityClass()
	 {
	     return TriskCompany.class;
	 }
	
	/**
	 * 查找默认担保机构
	 * @return
	 */
	public TriskCompany getDefaultRiskcom(){
		return getUnique("getDefaultRiskcom", "");
	}
	
	public int updateDefault(TriskCompany triskCompany){
		return update("updateRcDefault", triskCompany);
	}
}
