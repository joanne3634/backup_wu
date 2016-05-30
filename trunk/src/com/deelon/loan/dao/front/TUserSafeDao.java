package com.deelon.loan.dao.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TUserSafe;

/**
 * 用户安全数据库操作
 * @author deelon.hejian
 *
 */
@Repository
public class TUserSafeDao extends BaseDao<TUserSafe> {

	@Override
	public Class<TUserSafe> getEntityClass() {
		return TUserSafe.class;
	}
//	
//	public int updateSafe(TUserSafe tUserSafe){
//		return update("updateUserSafe", tUserSafe);
//	};

	public void saveUserSafe(TUserSafe userSafe) {
		insert("insertUserSafe", userSafe);
	}
	
	public List<TUserSafe> getUserSafeByColumn(String columnName, Object columnValue){
		Map<String, Object> column = new HashMap<String, Object>();
		column.put("columnName", columnName);
		column.put("columnValue", columnValue);
		return getBySqlKey("getUserSafeByColumn",column);
	}
	
	public void updateUserSafeByUserId(TUserSafe userSafe){
		update("updateUserSafeByUserId", userSafe);
	}
	
	public void getUserSafe(String conString,String comVlue){
		
	}
	
	public TUserSafe queryTUserSafeByEmail(String emailAdd){
		return (TUserSafe)getOne("queryEntityByEmail", emailAdd);
	}
	
	public TUserSafe valiTUserSafeByEmail(String email){
		
		Map map = new HashMap();
		map.put("columnName", "EMail");
		map.put("columnValue", email);
		map.put("statusName", "Bind_EMail");
		map.put("statusValue", "1");
		
		List<TUserSafe> list = getBySqlKey("getValiUserSafeByColumn", map);
		if(list != null){
			if(list.size() > 0 ){
				return list.get(0);
			}
		}
			return null;	
	}
	
	public TUserSafe valiTUserSafeByMobile(String mobile){
		
		Map map = new HashMap();
		map.put("columnName", "Mobile");
		map.put("columnValue", mobile);
		map.put("statusName", "Bind_Mobile");
		map.put("statusValue", 1);
		
		List<TUserSafe> list = getBySqlKey("getValiUserSafeByColumn", map);
		if(list != null){
			if(list.size() > 0 ){
				return list.get(0);
			}
		}
			return null;	
	}
	
	public TUserSafe valiTUserSafeByQuesion(long userId){
		
		Map map = new HashMap();
		map.put("columnName", "user_id");
		map.put("columnValue", userId);

		
		List<TUserSafe> list = getBySqlKey("getValiUserSafeByQuesion", map);
		if(list != null){
			if(list.size() > 0 ){
				return list.get(0);
			}
		}
			return null;	
	}
	
	
	public TUserSafe getUserSafe(long safeId){
		return getUnique("getUserSafe", safeId);
	}
	
	public void updateTUserSafeByPk(TUserSafe tUserSafe){
		update("updateUserSafeByUserId", tUserSafe);
	}
	
	public TUserSafe queryTUserSafeByValidateKey(TUserSafe tUserSafe){
		return getUnique("queryEntityByValidateKey", tUserSafe);
	}
	
	public TUserSafe queryTUserSafeByuserId(String userId){
		return getUnique("queryEntityByUserId", userId);
	}
}
