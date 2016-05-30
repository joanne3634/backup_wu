/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.front;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.front.TprojectAcceptDao;
import com.deelon.loan.model.front.TProjectAccept;

@ Service
public class TprojectAcceptService extends BaseService<TProjectAccept>{
	
	@ Resource
	private TprojectAcceptDao tprojectAcceptDao;
	
	protected IEntityDao<TProjectAccept, Long> getEntityDao()
	{
		return this.tprojectAcceptDao;
	}
	
	

}