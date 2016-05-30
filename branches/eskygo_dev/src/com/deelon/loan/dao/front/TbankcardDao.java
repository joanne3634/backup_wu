/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.front;

import java.util.List;


import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TBankcard;


@Repository
public class TbankcardDao extends  BaseDao<TBankcard>{
	
	public Class getEntityClass()
	 {
	     return TBankcard.class;
	 }
	
	public void saveTbankcard(TBankcard tbankcard){
			
			//update("update", tbankcard);
			update("add", tbankcard);
	}
	
	public void updateTbankcard(TBankcard tbankcard){
		
		//update("update", tbankcard);
		update("update", tbankcard);
}
	
	public List<TBankcard> getTBankcardByUserId(Long userId){
		return getBySqlKey("getTbankCardByUserId", userId);
	}
	
	public List<TBankcard> getBankCardAndTransactionPwd(Long userId){
		
		return getBySqlKey("getBankCardAndTransactionPwd", userId);
	}

}
