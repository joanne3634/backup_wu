/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.front;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TuserSetauto;


@Repository
public class TuserSetautoDao extends  BaseDao<TuserSetauto>{
	
	public Class getEntityClass()
	 {
	     return TuserSetauto.class;
	 }
	
	
	public int saveOrUpdateTuserSetauto(TuserSetauto tuserSetauto){
		if(tuserSetauto.getSetAutoId()!=null){
			return update("update", tuserSetauto);
		}else{
			return update("add", tuserSetauto);
		}
	}
	
	/**
	 * 查询所有设置了自动投标的用户
	 * @return
	 */
	public List<TuserSetauto> getAllAutoTenderList(){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String currentDate=sdf.format(new Date());
		return getBySqlKey("getAllAutoTenderList",currentDate);
	}
	
	/**
	 * 根据用户id 查询用户最近的 投标条件设置
	 * @param userId
	 * @return
	 */
	public TuserSetauto getTuserSetautoByUserId(Long userId){
		return getUnique("getTuserSetautoByUserId", userId);
	}

}
