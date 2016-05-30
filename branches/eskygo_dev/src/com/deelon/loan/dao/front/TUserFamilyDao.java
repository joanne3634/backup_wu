package com.deelon.loan.dao.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TUserFamily;

@Repository
public class TUserFamilyDao extends BaseDao<TUserFamily> {

	@Override
	public Class<TUserFamily> getEntityClass() {
		return TUserFamily.class;
	}

	public void addUserFamily(TUserFamily userFamily) {
		insert("insertUserFamily", userFamily);
	}

	public void updateUserFamilyByUserId(TUserFamily userFamily) {
		update("updateUserFamilyByUserId", userFamily);
	}
	
	public List<TUserFamily> getUserFamilyByColumn(String columnName, Object columnValue){
		Map<String, Object> column = new HashMap<String, Object>();
		column.put("columnName", columnName);
		column.put("columnValue", columnValue);
		return getBySqlKey("getUserFamilyByColumn", column);
	}

	public TUserFamily queryTUserFamilyByuserId(String userId) {
		return getUnique("queryEntityByUserId", userId);
	}
}
