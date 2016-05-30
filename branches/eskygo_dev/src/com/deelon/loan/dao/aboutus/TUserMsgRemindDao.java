package com.deelon.loan.dao.aboutus;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.aboutus.TUserMessage;
import com.deelon.loan.model.aboutus.TUserMsgRemind;

@Repository
public class TUserMsgRemindDao extends BaseDao<TUserMsgRemind>  {

 
	public Class getEntityClass() {
		return TUserMsgRemind.class;
	}
	public List<TUserMsgRemind> getReceiverId(int ReceiverId){
		Map params = new HashMap();  
		params.put("ReceiverId", ReceiverId); 
		List<TUserMsgRemind> tuserMsgRemind =getBySqlKey("getReceiverId",params);
		return tuserMsgRemind;
	}
	
	public void del(long msgRemindId){
		delBySqlKey("delById",msgRemindId);
	}
	
	/**
	 * 查询用户当天发送的 信息
	 * 
	 * @param map
	 * @return
	 */
	public List<TUserMsgRemind> getNowDaySendInfo(Map<String,Object> map) {
		return getBySqlKey("getNowDaySendInfo", map);
	}
	/**
	 * 查询上一次约谈的的发送时间的TUserMsgRemind
	 * @param map
	 * @return
	 */
	public List<TUserMsgRemind> getlastSendTimeInfo (Map<String,Object> map) {
		return getBySqlKey("getlastSendTimeInfo", map);
	}
	
	
	  public Object getOne(String sqlKey, Object params)
	  {
	    String statement = getIbatisMapperNamespace() + "." + sqlKey;
	    Object object = getSqlSessionTemplate().selectOne(statement, params);
	    return object;
	  }
	public List getAllMsgRemind(QueryFilter queryFilter) {
		return getBySqlKey("getAllMsgRemind", queryFilter);
	}
	
} 
