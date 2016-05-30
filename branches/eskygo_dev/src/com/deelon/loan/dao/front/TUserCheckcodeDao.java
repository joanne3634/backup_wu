package com.deelon.loan.dao.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TUserCheckcode;

@Repository
public class TUserCheckcodeDao extends BaseDao<TUserCheckcode>{

	@Override
	public Class<TUserCheckcode> getEntityClass() {
		return TUserCheckcode.class;
	}
	
	public void saveUserCheckcode(TUserCheckcode tUserCheckcode){
		insert("insertUserCheckcode", tUserCheckcode);
	}
	
	public TUserCheckcode getUserCheckcodeByUserIdDesc(long userId){
		List<TUserCheckcode> userCheckcodes = getBySqlKey("getUserCheckcodeByUserIdDesc", userId);
		if(userCheckcodes == null || userCheckcodes.size() ==0){
			return null;
		}
		return userCheckcodes.get(0);
	}
	public TUserCheckcode getUserCheckcodeByUserIdAndCode(long userId,String code){
		Map map = new HashMap();
		map.put("code", code);
		map.put("userId", userId);
		
		return getBySqlKey("getUserCheckcodeByUserIdAndCode", map).get(0);
	}

	
	
	
	public void updateUserCheckcode(TUserCheckcode tUserCheckcode){
		update("updateUserCheckcode", tUserCheckcode);
	}

}
