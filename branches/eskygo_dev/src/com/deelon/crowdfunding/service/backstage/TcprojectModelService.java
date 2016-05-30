/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.service.backstage;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.crowdfunding.dao.backstage.TcprojectModelDao;
import com.deelon.crowdfunding.model.backstage.TcprojectModel;

@ Service
public class TcprojectModelService extends BaseService<TcprojectModel>{
	
	@ Resource
	private TcprojectModelDao tcprojectModelDao;
	
	protected IEntityDao<TcprojectModel, Long> getEntityDao()
	{
		return this.tcprojectModelDao;
	}
	
	/**
	 * 查找项目的商业模式
	 * @param projectId
	 * @return
	 */
	public TcprojectModel getByProId(long projectId){
		return tcprojectModelDao.getByProId(projectId);
	}

}