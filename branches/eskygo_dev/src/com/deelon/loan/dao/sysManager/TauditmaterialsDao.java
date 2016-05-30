/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.sysManager.Tauditmaterials;


@Repository
public class TauditmaterialsDao extends  BaseDao<Tauditmaterials>{
	
	public Class getEntityClass()
	 {
	     return Tauditmaterials.class;
	 }
	
	public List<Tauditmaterials> getTauditmaterialsList(){
		return getBySqlKey("getAllTauditmaterials");
		
	}
	
	/**
	 * 获取用户已经上传 和未上传的资料
	 * @param userId
	 * @return
	 */
	public List<Tauditmaterials> getAudiMeByUserId(long userId){
		return getBySqlKey("getAudiMeByUserId", userId);
	}

}
