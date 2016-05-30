/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.crowdfunding.model.backstage.TcprojectTeam;


@Repository
public class TcprojectTeamDao extends  BaseDao<TcprojectTeam>{
	
	public Class getEntityClass()
	 {
	     return TcprojectTeam.class;
	 }
	
	/**
	 * 查找项目的团队
	 * @param projectId
	 * @return
	 */
	public List<TcprojectTeam> getByProId(long projectId){
		return getBySqlKey("getByProId", projectId);
	}

}
