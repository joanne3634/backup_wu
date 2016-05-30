/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.service.backstage;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.crowdfunding.dao.backstage.TcprojectContractDao;
import com.deelon.crowdfunding.model.backstage.TcprojectContract;

@ Service
public class TcprojectContractService extends BaseService<TcprojectContract>{
	
	@ Resource
	private TcprojectContractDao tcprojectContractDao;
	
	protected IEntityDao<TcprojectContract, Long> getEntityDao()
	{
		return this.tcprojectContractDao;
	}

}