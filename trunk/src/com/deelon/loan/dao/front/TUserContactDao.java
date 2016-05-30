package com.deelon.loan.dao.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TUserContact;

@Repository
public class TUserContactDao extends BaseDao<TUserContact> {

	@Override
	public Class<TUserContact> getEntityClass() {
		return TUserContact.class;
	}

	public void addUserContact(TUserContact userContact) {
		insert("insertUserContact", userContact);
	}
	
	public void updateUserContact(TUserContact userContact){
		update("updateUserContact",userContact);
	}
	
	public List<TUserContact> getUserContactByColumn(String columnName,Object columnValue){
		Map<String, Object> column = new HashMap<String, Object>();
		column.put("columnName", columnName);
		column.put("columnValue", columnValue);
		return getBySqlKey("getUserContactByColumn", column);
	}
	
	public void updateUserContactByUserId(TUserContact userContact){
		update("updateUserContactByUserId",userContact);
	}

	public TUserContact queryTUserContactByuserId(String userId) {
		return getUnique("queryEntityByUserId", userId);
	}

}
