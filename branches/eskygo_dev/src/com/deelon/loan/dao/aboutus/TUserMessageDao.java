package com.deelon.loan.dao.aboutus;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository; 

import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.aboutus.TUserMessage;

@Repository
public class TUserMessageDao extends BaseDao<TUserMessage> {

	public Class getEntityClass() {
		return TUserMessage.class;
	}
	public List<TUserMessage> getUserId(int userid){
		Map params = new HashMap();  
		params.put("userId", userid); 
		List<TUserMessage> tuserMessage =getBySqlKey("getUserId",params);
		return tuserMessage;
	}
}
