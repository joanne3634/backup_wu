package com.deelon.loan.service.front;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.front.TUserDao;
import com.deelon.loan.dao.front.TuserCreditDao;
import com.deelon.loan.dao.front.TuserTaskcompleteDao;
import com.deelon.loan.dao.sysManager.TtaskDao;
import com.deelon.loan.dao.sysManager.TuserFundsDao;
import com.deelon.loan.model.front.TTask;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TuserCredit;
import com.deelon.loan.model.front.TuserTaskcomplete;

@Service
public class TuserTaskcompleteService extends BaseService<TuserTaskcomplete> {

	@Autowired
	private TuserTaskcompleteDao tuserTaskcompleteDao;
	@Autowired
	private TtaskDao taskDao;
	@Autowired
	private TuserCreditDao userCreditDao;
	@Autowired
	private TuserFundsDao userFundsDao;
	@Autowired
	private TUserDao userDao;

	protected IEntityDao<TuserTaskcomplete, Long> getEntityDao() {
		return this.tuserTaskcompleteDao;
	}
	/**
	 * 完成任务增加信用度
	 * @param userId
	 * @param taskId
	 */
	public void viweAddcredit(long userId,long taskId){
		
		TuserTaskcomplete t = tuserTaskcompleteDao.gettuserTaskcomplete(userId,taskId);
		TUserFunds tUserFunds = userFundsDao.getByUserId(userId);   
		TUser user = userDao.getById(userId);
		
		if(t != null ||tUserFunds == null|| user == null){  //已经完成的任务
			return;
		}
		TTask task = taskDao.getById(taskId);
		TuserTaskcomplete userTaskcomplete = new TuserTaskcomplete();
		userTaskcomplete.setUserId(userId);
		userTaskcomplete.setTaskId((int) taskId);
		userTaskcomplete.setCreditAdd(task.getCreditAdd());
		userTaskcomplete.setIsComplete(1);
		userTaskcomplete.setCompleteTime(new Date());
		tuserTaskcompleteDao.add(userTaskcomplete);  //保存完成任务
		
		TuserCredit tc = new TuserCredit();
		tc.setUserId(userId);
		tc.setTypeId(2);
		tc.setCreditAdd(task.getCreditAdd());
		tc.setDescription("完成任务增加信用度");
		tc.setCreateTime(new Date()); 
		tc.setKeyId(taskId);
		userCreditDao.add(tc);   //添加 增加信用度的记录
		
		if(user.getGroupId().equals("1")){  //借款信用度任务
			tUserFunds.setCreditOut(tUserFunds.getCreditOut() + task.getCreditAdd());
		}else if(user.getGroupId().equals("2")){
			tUserFunds.setCreditIn(tUserFunds.getCreditIn() + task.getCreditAdd());
		}
		userFundsDao.update(tUserFunds);
	}
	
	public TuserTaskcomplete gettuserTaskcomplete(long userId,long taskId){
		return tuserTaskcompleteDao.gettuserTaskcomplete(userId, taskId);
	}
}