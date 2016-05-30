/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.service.backstage;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.crowdfunding.dao.backstage.TcprojectHpPaymentsDao;
import com.deelon.crowdfunding.model.backstage.TcprojectHpPayments;

@ Service
public class TcprojectHpPaymentsService extends BaseService<TcprojectHpPayments>{
	
	@ Resource
	private TcprojectHpPaymentsDao tcprojectHpPaymentsDao;
	
	protected IEntityDao<TcprojectHpPayments, Long> getEntityDao()
	{
		return this.tcprojectHpPaymentsDao;
	}
	
	/**
	 * 获取项目历史情况/未来计划 对应的收入和开支
	 * @param historyPlanId
	 * @return
	 */
	public List<TcprojectHpPayments> getByHistoryPlanId(long historyPlanId){
		return tcprojectHpPaymentsDao.getByHistoryPlanId(historyPlanId);
	}

}