package com.deelon.loan.dao.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TUserAuditMat;

@Repository
public class TUserAuditMatDao extends BaseDao<TUserAuditMat>{

	@Override
	public Class<TUserAuditMat> getEntityClass() {
		return TUserAuditMat.class;
	}
	
	public List<TUserAuditMat> getUserAuditMatsByUser(long userId){
		return getBySqlKey("getByUserId", userId);
	}
	
	
	public Boolean insertUserAuditMats(TUserAuditMat t){
		int c = insert("add", t);
		if(c > 0){
			return true;
		}
		return false;
	}
	public TUserAuditMat getUserAuditMatsByUser(long userId,long materialsId){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("materialsId", materialsId);
		
		List<TUserAuditMat> list = getBySqlKey("getByUserId", map);
		
		if(list.size() >0){
			return list.get(0);
		}
		return null;
	}
	
	/**
	 * 取得用户 提交的审核材料 和审核情况
	 * @param userId
	 * @return
	 */
	public List<TUserAuditMat> getAuditFileByUserId(long userId){
		return getBySqlKey("getAuditFileByUserId", userId);
	}
	
}
