/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.front;

import java.util.List;



import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.front.TbankcardDao;
import com.deelon.loan.model.front.TBankcard;

@ Service
public class TbankcardService extends BaseService<TBankcard>{
	
	@ Resource
	private TbankcardDao tbankcardDao;
	
	protected IEntityDao<TBankcard, Long> getEntityDao()
	{
		return this.tbankcardDao;
	}
	
	/**
	 * 保存记录
	 * @param tbankcard
	 */
	public void saveTbankcard(TBankcard tbankcard){
		tbankcardDao.saveTbankcard(tbankcard);
	}
	
	/**
	 * 更新记录
	 * @param tbankcard
	 */
	public void updateTbankcard(TBankcard tbankcard){
		tbankcardDao.updateTbankcard(tbankcard);
	}
	/**
	 * 根据用户id取得银卡信息
	 * @param userId //用户id
	 * @return
	 */
	public List<TBankcard> getTBankcardByUserId(Long userId){
		return tbankcardDao.getTBankcardByUserId(userId);
	}
	
	/**
	 * 根据用户id取得用户的银卡信息和交易密码
	 * @param userId
	 * @return
	 */
	public List<TBankcard> getBankCardAndTransactionPwd(Long userId){
		return tbankcardDao.getBankCardAndTransactionPwd(userId);
	}
	

}