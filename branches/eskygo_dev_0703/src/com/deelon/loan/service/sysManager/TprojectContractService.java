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
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TprojectContractDao;
import com.deelon.loan.model.front.TProjectContract;

@ Service
public class TprojectContractService extends BaseService<TProjectContract>{
	
	@ Resource
	private TprojectContractDao tprojectContractDao;
	
	protected IEntityDao<TProjectContract, Long> getEntityDao()
	{
		return this.tprojectContractDao;
	}
	
	/**
	 * 获取所有合同
	 * @param queryFilter
	 * @return
	 */
	public List<TProjectContract> getAllContarct(QueryFilter queryFilter){
		return tprojectContractDao.getAllContarct(queryFilter);
	}

}