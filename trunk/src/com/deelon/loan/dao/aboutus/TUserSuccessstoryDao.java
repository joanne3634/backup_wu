package com.deelon.loan.dao.aboutus;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository; 

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.aboutus.TUserSuccessstory;

@Repository
public class TUserSuccessstoryDao extends BaseDao<TUserSuccessstory> {

	public Class getEntityClass() {
		return TUserSuccessstory.class;
	}
	public long save(TUserSuccessstory tUserSuccessstory) {
		insert("add", tUserSuccessstory);
		return tUserSuccessstory.getSuccessstoryId();
	}

	public void updateUserSuccesstory(TUserSuccessstory tUserSuccessstory) {
		update("update", tUserSuccessstory);
	}

	public List<TUserSuccessstory> getAll() {
		return getBySqlKey("getAll");
	}
}
