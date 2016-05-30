/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.service.backstage;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.dao.backstage.TcprojectCommentsDao;
import com.deelon.crowdfunding.model.backstage.TcprojectComments;

@ Service
public class TcprojectCommentsService extends BaseService<TcprojectComments>{
	
	@ Resource
	private TcprojectCommentsDao tcprojectCommentsDao;
	
	protected IEntityDao<TcprojectComments, Long> getEntityDao()
	{
		return this.tcprojectCommentsDao;
	}
	
	
	/**
	 * 查询项目下的评论
	 * @param projectId
	 * @return
	 */
	public List<TcprojectComments> getTcprojectCommentsByProId(Map<String,Object> map,PageBean pb){
		return tcprojectCommentsDao.getTcprojectCommentsByProId(map,pb);
	}

	public TcprojectComments getCount(long commentsId){
		return tcprojectCommentsDao.getCount(commentsId);
	}
	
	public List<TcprojectComments> getByCommentsId(QueryFilter filter,long commentsId){
		return tcprojectCommentsDao.getByCommentsId(commentsId);
	}
}