/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.crowdfunding.model.backstage.TcprojectHistoryplan;


@Repository
public class TcprojectHistoryplanDao extends  BaseDao<TcprojectHistoryplan>{
	
	public Class getEntityClass()
	 {
	     return TcprojectHistoryplan.class;
	 }
	
	/**
	 * 查询项目下的历史情况
	 * @param proId
	 * @return
	 */
	public List<TcprojectHistoryplan> getByProId(Map<String,Object> map){
		return getBySqlKey("getByProId", map);
	}
	
	/**
	 * 查询项目下的历史情况和支出收入
	 * @param map
	 * @return
	 */
	public List<TcprojectHistoryplan> getproPlanandPayment(Map<String,Object> map){
		return getBySqlKey("getproPlanandPayment", map);
	}

}
