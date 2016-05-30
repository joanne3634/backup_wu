package com.deelon.loan.dao.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TUserAuditMat;
import com.deelon.loan.model.front.TUserAuditMatUpload;

@Repository
public class TUserAuditMatUploadDao extends BaseDao<TUserAuditMatUpload>{

	@Override
	public Class<TUserAuditMatUpload> getEntityClass() {
		return TUserAuditMatUpload.class;
	}
	
	public List<TUserAuditMatUpload> getUserAuditMatUploadByUserAndauditMatId(long userId,long auditMatId){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("auditMatId", auditMatId);
		
		List<TUserAuditMatUpload> list = getBySqlKey("getUserAuditMatUploadByUserAndmaterialsId", map);
		
		return list;

	}
	

	
	
}
