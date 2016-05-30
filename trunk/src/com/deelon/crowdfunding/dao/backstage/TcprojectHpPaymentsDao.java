/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.crowdfunding.model.backstage.TcprojectHpPayments;


@Repository
public class TcprojectHpPaymentsDao extends  BaseDao<TcprojectHpPayments>{
	
	public Class getEntityClass()
	 {
	     return TcprojectHpPayments.class;
	 }
	
	/**
	 * 获取项目历史情况/未来计划 对应的收入和开支
	 * @param historyPlanId
	 * @return
	 */
	public List<TcprojectHpPayments> getByHistoryPlanId(long historyPlanId){
		return getBySqlKey("getByHistoryPlanId", historyPlanId);
	}

}
