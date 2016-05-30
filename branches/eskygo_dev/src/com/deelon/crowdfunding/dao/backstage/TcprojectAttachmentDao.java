/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.crowdfunding.model.backstage.TcprojectAttachment;


@Repository
public class TcprojectAttachmentDao extends  BaseDao<TcprojectAttachment>{
	
	public Class getEntityClass()
	 {
	     return TcprojectAttachment.class;
	 }
	
	/**
	 * 查询项目下的附件
	 * @param proId
	 * @return
	 */
	public List<TcprojectAttachment> getByProId(long proId){
		return getBySqlKey("getByProId", proId);
	}

}
