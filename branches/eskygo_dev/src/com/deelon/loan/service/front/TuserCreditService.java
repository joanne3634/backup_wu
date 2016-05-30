/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.front;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.loan.dao.front.TuserCreditDao;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TuserCredit;
import com.deelon.loan.service.sysManager.TuserFundsService;

@ Service
public class TuserCreditService extends BaseService<TuserCredit>{
	
	@ Resource
	private TuserCreditDao tuserCreditDao;
	@ Resource
	private TuserFundsService tuserFundsService;
	
	protected IEntityDao<TuserCredit, Long> getEntityDao()
	{
		return this.tuserCreditDao;
	}
	
	/**
	 * 保存一条记录
	 * @param tuserCredit
	 */
	public void saveTuserCredit(TuserCredit tuserCredit){
		tuserCreditDao.saveTuserCredit(tuserCredit);
	}
	
	/**
	 * 更新用户的信用指数
	 * @param userId
	 * @param keyId
	 * @param creditNum
	 * @param typeid
	 * @param description
	 * @return
	 */
	public boolean updateUserCredit(Long userId,Long keyId,Integer creditNum,Integer typeid,String description){
		boolean flag = false;
		try{
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setCreditId(UniqueIdUtil.genId());
			tuserCredit.setUserId(userId);
			tuserCredit.setTypeId(typeid);
			tuserCredit.setKeyId(keyId);
			tuserCredit.setCreditAdd(creditNum);
			tuserCredit.setDescription(description);
			tuserCredit.setCreateTime(new Date());
			saveTuserCredit(tuserCredit);
			//t_userFunds表
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(userId);
			String groupId =tuserFunds.getUser().getGroupId();
			int creditOut =tuserFunds.getCreditOut();
			int creditIn =tuserFunds.getCreditIn();
			//1.out 2.in
			if("1".equals(groupId)){//理财用户
				tuserFunds.setCreditOut(creditOut+creditNum);
				tuserFundsService.update(tuserFunds);
			}else if("2".equals(groupId)){//借款用户
				tuserFunds.setCreditIn(creditIn+creditNum);
				tuserFundsService.update(tuserFunds);
			}else{//综合用户
				tuserFunds.setCreditOut(creditOut+creditNum);
				tuserFunds.setCreditIn(creditIn+creditNum);
				tuserFundsService.update(tuserFunds);
			}
			flag = true;
		}catch(Exception e){
			throw new RuntimeException();
		}
		return flag;
	}
	
}