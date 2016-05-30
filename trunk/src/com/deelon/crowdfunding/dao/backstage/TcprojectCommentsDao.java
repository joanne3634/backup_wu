/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.dao.backstage;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.page.PageBean;
import com.deelon.crowdfunding.model.backstage.TcprojectComments;


@Repository
public class TcprojectCommentsDao extends  BaseDao<TcprojectComments>{
	
	public Class getEntityClass()
	 {
	     return TcprojectComments.class;
	 }
	
	/**
	 * 查询项目下的评论
	 * @param projectId
	 * @return
	 */
	public List<TcprojectComments> getTcprojectCommentsByProId(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getTcprojectCommentsByProId", map,pb);
	}
	
	public TcprojectComments getCount(long commentsId){
		return getUnique("getCount", commentsId);
	}

	public List<TcprojectComments> getByCommentsId(long commentsId){
		return getBySqlKey("getByCommentsId",commentsId);
	}
}
