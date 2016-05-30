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
import com.deelon.crowdfunding.dao.backstage.TcprojectAttachmentDao;
import com.deelon.crowdfunding.model.backstage.TcprojectAttachment;

@ Service
public class TcprojectAttachmentService extends BaseService<TcprojectAttachment>{
	
	@ Resource
	private TcprojectAttachmentDao tcprojectAttachmentDao;
	
	protected IEntityDao<TcprojectAttachment, Long> getEntityDao()
	{
		return this.tcprojectAttachmentDao;
	}
	
	/**
	 * 查询项目下的附件
	 * @param proId
	 * @return
	 */
	public List<TcprojectAttachment> getByProId(long proId){
		return tcprojectAttachmentDao.getByProId(proId);
		
	}

}