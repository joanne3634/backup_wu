/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.crowdfunding.model.backstage.TcprojectModel;


@Repository
public class TcprojectModelDao extends  BaseDao<TcprojectModel>{
	
	public Class getEntityClass()
	 {
	     return TcprojectModel.class;
	 }
	
	/**
	 * 查找项目的商业模式
	 * @param projectId
	 * @return
	 */
	public TcprojectModel getByProId(long projectId){
		return getUnique("getByProId", projectId);
	}

}
