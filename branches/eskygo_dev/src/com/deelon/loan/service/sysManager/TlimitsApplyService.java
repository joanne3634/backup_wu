/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.sysManager;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TlimitsApplyDao;
import com.deelon.loan.model.front.TLimitsApply;
import com.deelon.loan.model.front.TUserFunds;

@ Service
public class TlimitsApplyService extends BaseService<TLimitsApply>{
	
	@ Resource
	private TlimitsApplyDao tlimitsApplyDao;
	@ Resource
	private TuserFundsService tuserFundservice;
	
	protected IEntityDao<TLimitsApply, Long> getEntityDao()
	{
		return this.tlimitsApplyDao;
	}
	
	/**
	 * 通过分页查询所有已经审核和未审核 审核
	 * @param queryFilter
	 * @return
	 */
	public List<TLimitsApply> getAllTLimitsApply(QueryFilter queryFilter){
		return tlimitsApplyDao.getAllTLimitsApply(queryFilter);
	}
	
	/**
	 * 修改一条记录
	 * @param tLimitsApply
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public int updateTLimitsApplyByPk(TLimitsApply tLimitsApply){
		if("1".equals(tLimitsApply.getAudit_status())&&"1".equals(tLimitsApply.getTypeId())){//借入限额
			TUserFunds uf = tuserFundservice.getTUserFundsByUserId(tLimitsApply.getApplicant());
			uf.setLimitMaxIn(tLimitsApply.getLimitApply());
			tuserFundservice.update(uf);
		}else if("1".equals(tLimitsApply.getAudit_status())&&"2".equals(tLimitsApply.getTypeId())){//借出限额
			TUserFunds uf = tuserFundservice.getTUserFundsByUserId(tLimitsApply.getApplicant());
			uf.setLimitMaxOut(tLimitsApply.getLimitApply());
			tuserFundservice.update(uf);
		}
		return tlimitsApplyDao.updateTLimitsApplyByPk(tLimitsApply);
	}
	
	/**
	 * by id query
	 * @param id
	 * @return
	 */
	public TLimitsApply getTLimitsApplyById(Long id){
		return tlimitsApplyDao.getTLimitsApplyById(id);
	}

}