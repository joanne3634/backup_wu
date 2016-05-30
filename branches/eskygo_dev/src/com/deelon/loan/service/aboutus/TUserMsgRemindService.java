package com.deelon.loan.service.aboutus;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.DateUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.aboutus.TUserMsgRemindDao;
import com.deelon.loan.model.aboutus.TUserMsgRemind;

@ Service
public class TUserMsgRemindService extends BaseService<TUserMsgRemind>{
	@Resource
	private TUserMsgRemindDao tuserMsgRemindDao;
	
	protected IEntityDao<TUserMsgRemind, Long> getEntityDao()
	{
		return this.tuserMsgRemindDao;
	}
	public void add(TUserMsgRemind entity) {
		tuserMsgRemindDao.add(entity);
	}
	
	
	public TUserMsgRemind getById(long MsgRemindId ){
		return tuserMsgRemindDao.getById(MsgRemindId);
	}
	public void update(TUserMsgRemind entity){
		tuserMsgRemindDao.update(entity);
	}
	public List<TUserMsgRemind>   getAll() {
		return tuserMsgRemindDao.getAll();
	} 
	public void del(long msgRemindId){
		tuserMsgRemindDao.delById(msgRemindId);
	}
	
	public List<TUserMsgRemind> getReceiverId(int  ReceiverId){
           return tuserMsgRemindDao.getReceiverId(ReceiverId);
	}
	
	
	/**
	 * 根据查询条件获取我的私信的列表内容
	 * @param start
	 * @param end
	 * @param status
	 * @param userId
	 * @param pb 
	 * @return
	 */
	public List<TUserMsgRemind> getMyPrivateInfos(String start, String end,String typeId, long receiverId, long isDel,PageBean pb) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("typeId", typeId);
		if(null!=start&&""!=start){
			map.put("start", DateUtil.parseDate(start+" 00:00:00"));
		}
		if(null!=end&&""!=end){
			map.put("end", DateUtil.parseDate(end+" 23:59:59"));
		}
		map.put("receiverId", receiverId);
		map.put("isDel",isDel);
		return tuserMsgRemindDao.getBySqlKey("getMyPrivateInfos", map,pb);
	}
	
	public List<TUserMsgRemind> getOutBoxData(String start, String end,String typeId, long senderId, PageBean pb) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(null!=start&&""!=start){
			map.put("start", DateUtil.parseDate(start+" 00:00:00"));
		}
		if(null!=end&&""!=end){
			map.put("end", DateUtil.parseDate(end+" 23:59:59"));
		}
		map.put("typeId", typeId);
		map.put("senderId", senderId);
		return tuserMsgRemindDao.getBySqlKey("getOutBoxData", map,pb);
	}

/**
 * 根据消息记录id查询回复的信息
 */
	public List<TUserMsgRemind> getReplyInfos(long MsgRemindId) {
		QueryFilter filter = new QueryFilter();
		filter.addFilter("replyID", MsgRemindId);
		List<TUserMsgRemind> tuserMsgReminds = tuserMsgRemindDao.getBySqlKeyAll(filter,TUserMsgRemind.class, "getReplyInfos");
		return tuserMsgReminds;
	}
	
	/**
	 * 查询用户当天发送的 信息
	 * 
	 * @param map
	 * @return
	 */
	public List<TUserMsgRemind> getNowDaySendInfo(Map<String,Object> map) {
		return tuserMsgRemindDao.getNowDaySendInfo(map);
	}

	/**
	 * 查询上一次约谈的的发送时间TUserMsgRemind
	 * 
	 * @param map
	 * @return
	 */
	public List<TUserMsgRemind> getlastSendTimeInfo(Map<String,Object> map) {
		return tuserMsgRemindDao.getlastSendTimeInfo(map);
	}
	
	

	
	/**
	 * 查询用户未读的信息总数
	 * @param userId
	 * @return
	 */
	public long getUserMsgCount(Map<String, Object> map) {
		long count = (Long)tuserMsgRemindDao.getOne("getnewsum", map);
		return count;
	}
	public List getAllMsgRemind(QueryFilter queryFilter) {
		return tuserMsgRemindDao.getAllMsgRemind(queryFilter);
	}
	
	
	
}