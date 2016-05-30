package com.deelon.loan.dao.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TUserCompany;

@Repository
public class TUserCompanyDao extends BaseDao<TUserCompany> {

	@Override
	public Class<TUserCompany> getEntityClass() {
		return TUserCompany.class;
	}
	
	public void saveUserCompany(TUserCompany userCompany){
		insert("insertUserCompany", userCompany);
	}
	
	public void updateUserCompanyByUserId(TUserCompany userCompany){
		update("updateUserCompanyByUserId", userCompany);
	}

	public List<TUserCompany> getUserCompanyByColumn(String columnName, Object columnValue){
		Map<String, Object> column = new HashMap<String, Object>();
		column.put("columnName", columnName);
		column.put("columnValue", columnValue);
		return getBySqlKey("getUserCompanyByColumn", column);
	}

	public TUserCompany queryTUserCompanyByuserId(String userId) {
		return getUnique("queryEntityByUserId", userId);
	}
}
