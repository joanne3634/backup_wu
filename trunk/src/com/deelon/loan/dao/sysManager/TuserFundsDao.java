/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TuserCredit;


@Repository
public class TuserFundsDao extends  BaseDao<TUserFunds>{
	
	public Class getEntityClass()
	 {
	     return TUserFunds.class;
	 }
	
	public TUserFunds getTUserFundsByUserId(Long id){
		return getUnique("getUserFundsByUserId", id);
	}
	
	public TUserFunds getByUserId(Long id){
		return getUnique("getByUserId", id);
	}
	
	//
	public void saveOrUpdateTUserFunds(TUserFunds tu){
		if(tu.getFundsId()!=0){
			
			update("update", tu);
			
		}else{
			update("add", tu);
		}
	}
	
	/**
	 * 获取用户的理财资产 借款资产 账户余额
	 * @param userId
	 * @return
	 */
	public TUserFunds getPersonalAssetsByUserId(Long userId){
		TUserFunds account=getUnique("getPersonalAssetsByUserId", userId);
		TUserFunds licai=getUnique("getuserLiCai", userId);
		TUserFunds fuzhai=getUnique("getUserP_LoanReal", userId);
		TUserFunds t=new TUserFunds();
		if(account!=null)
		t.setAvailable(account.getAvailable());
		if(licai!=null)
		t.setPiEffectAmountTotal(licai.getPiEffectAmountTotal());
		if(fuzhai!=null)
		t.setPloanRealTotal(fuzhai.getPloanRealTotal());
		return t;
	}
	
	public TUserFunds getfundsCredit(Long userId){
		return getUnique("getfundsCredit", userId);
	}
	
	/**
	 * 查询用户资金信息
	 * @param queryFilter
	 * @return
	 */
	public List<TUserFunds> getUserFundsList(QueryFilter queryFilter){
		return getBySqlKey("getUserFundsList", queryFilter);
	}

}

