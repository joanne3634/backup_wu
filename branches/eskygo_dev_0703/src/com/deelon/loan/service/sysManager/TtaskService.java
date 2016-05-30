/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.sysManager;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.sysManager.TtaskDao;
import com.deelon.loan.model.front.TTask;


@ Service
public class TtaskService extends BaseService<TTask>{
	
	@Resource
	private TtaskDao ttaskDao;

	protected IEntityDao<TTask, Long> getEntityDao()
	{
		return this.ttaskDao;
	}
	
	public List<TTask> getTaskByGroupId(Long groupID,long userId){
		return this.ttaskDao.getTaskByGroupId(groupID,userId);
	}


	
//	public void saveOrUpdateTUserFunds(TUserFunds tu){
//		tuserFundsDao.saveOrUpdateTUserFunds(tu);
//	}
}