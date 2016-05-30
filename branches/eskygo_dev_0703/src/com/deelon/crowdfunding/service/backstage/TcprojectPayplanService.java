/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.service.backstage;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.crowdfunding.dao.backstage.TcprojectPayplanDao;
import com.deelon.crowdfunding.model.backstage.TcprojectPayplan;

@ Service
public class TcprojectPayplanService extends BaseService<TcprojectPayplan>{
	
	@ Resource
	private TcprojectPayplanDao tcprojectPayplanDao;
	
	protected IEntityDao<TcprojectPayplan, Long> getEntityDao()
	{
		return this.tcprojectPayplanDao;
	}

	public void delByProjectId(Long projectId) {
		tcprojectPayplanDao.delBySqlKey("delByProjectId", projectId);
	}

}