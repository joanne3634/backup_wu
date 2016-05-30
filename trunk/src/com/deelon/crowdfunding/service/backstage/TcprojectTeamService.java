/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.service.backstage;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.crowdfunding.dao.backstage.TcprojectTeamDao;
import com.deelon.crowdfunding.model.backstage.TcprojectModel;
import com.deelon.crowdfunding.model.backstage.TcprojectTeam;

@ Service
public class TcprojectTeamService extends BaseService<TcprojectTeam>{
	
	@ Resource
	private TcprojectTeamDao tcprojectTeamDao;
	
	protected IEntityDao<TcprojectTeam, Long> getEntityDao()
	{
		return this.tcprojectTeamDao;
	}

	
	/**
	 * 查找项目的团队
	 * @param projectId
	 * @return
	 */
	public List<TcprojectTeam> getByProId(long projectId){
		return tcprojectTeamDao.getByProId(projectId);
	}
}