/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.crowdfunding.model.backstage.TcprojectNews;


@Repository
public class TcprojectNewsDao extends  BaseDao<TcprojectNews>{
	
	public Class getEntityClass()
	 {
	     return TcprojectNews.class;
	 }
	
	/**
	 * 获取项目下的动态
	 * @param proid
	 * @return
	 */
	public List<TcprojectNews> getByProId(Map<String,Object> map){
		return getBySqlKey("getByProId", map);
	}

}
