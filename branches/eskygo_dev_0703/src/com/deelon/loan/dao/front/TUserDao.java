package com.deelon.loan.dao.front;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TUser;


/**
 * 用户数据库操作类
 * 
 * @author deelon.hejian
 * 
 */
@Repository
public class TUserDao extends BaseDao<TUser> {

	public Class<TUser> getEntityClass() {
		return TUser.class;
	}

	public void saveUser(TUser user) {
		insert("insertUser", user);
	}

	/**
	 * 根据用户登陆名获取用户的信息
	 * @param loginName
	 * @return
	 */
	public TUser getUserByLoginName(String loginName) {
		TUser user = getUnique("getUserByLoginName", loginName);
		return user;
	}

	public int updateUser(TUser user) {
		return update("updateT_user", user);
	}

	public List<TUser> getUserBycolumn(String columnName, Object columnValue) {
		Map<String, Object> column = new HashMap<String, Object>();
		column.put("columnName", columnName);
		column.put("columnValue", columnValue);
		return getBySqlKey("getUserBycolumn", column);
	}

	public List<TUser> getUsers() {
		return getBySqlKey("getUsers");
	}

	public void delUser(long userId) {
		delBySqlKey("delUser", userId);
	}
	
	public TUser getUserByUserId(long userId) {
		return  getUnique("getUserByUserId", userId);
	}
	
	/**
	 * 获取用户的信息
	 * @return
	 */
	public List<TUser> getAllUserInfos(QueryFilter queryFilter){
		List<TUser> list=getBySqlKey("getAllUserInfos",queryFilter);
		if(list!=null&&list.size()>0){
			String alinkAction="";
			for (TUser t : list) {
				alinkAction="";
				if(t.getIsLock()==1){//已锁定
					alinkAction+="<a href=\"javascript:void(0)\" onclick=\"unclockAccount("+t.getUserId()+");\">解锁</a>";
					
//					t.setAlinkAction();
				}else{
					alinkAction+="<a href=\"javascript:void(0)\" onclick=\"lockAccount("+t.getUserId()+");\">锁定</a>";
				}
				if(t.getIsActive()==0){//未激活
					alinkAction+="&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0)\" onclick=\"activateAccount("+t.getUserId()+");\">激活</a>";
				//	alinkAction+="&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0)\" onclick=\"lockAccount("+t.getUserId()+");\">锁定账号</a>";
				}/*else{
					alinkAction+="<a href=\"javascript:void(0)\" onclick=\"lockAccount("+t.getUserId()+");\">锁定账号</a>";
				}*/
				
				t.setAlinkAction(alinkAction);
			}
		}
		return list;
	}
	
	/**
	 * 根据用户id获取用户的信息
	 * @param userId
	 * @return
	 */
	public TUser  getuserInfoByUserId(Long userId){
		return getUnique("getuserInfoByUserId", userId);
	}
	
	/**
	 * 获取用户的 图像 信用 家庭 工作 等信息
	 * @param userId
	 * @return
	 */
	public TUser getUserInfoForDetail(Long userId){
		return getUnique("getUserInfoForDetail", userId);
	}

	public void updateById(TUser TUser){
		update("updateById", TUser);
	}
	
	/**
	 * 根据认投项目获取用户的信息
	 * @return
	 */
	public List<TUser> getUserByLeadProject(Long projectId){
		return getBySqlKey("getUserByLeadProject",projectId);
	}
	/**
	 * 根据认投项目获取用户的信息 
	 * @return
	 */
	public List<TUser> getUserByFollowProject(Long projectId){
		return getBySqlKey("getUserByFollowProject",projectId);
	}
	/**
	 * 取得所有投资人信息通过项目Id
	 * @return
	 */
	public List<TUser> getAllInvestorByProjectId(Long projectId){
		return getBySqlKey("getAllInvestorByProjectId",projectId);
	}
	/**
	 * 取得所有投资人信息
	 * @return
	 */
	public List<TUser> getAllInvestorList(QueryFilter filter){
		return getBySqlKey("getAllInvestorList",filter);
	}
	/**
	 * 取得所有未付认筹意向金的投资人信息
	 * @return
	 */
	public List<TUser> getAllASKInvestorList(QueryFilter filter){
		return getBySqlKey("getAllASKInvestorList",filter);
	}
}
