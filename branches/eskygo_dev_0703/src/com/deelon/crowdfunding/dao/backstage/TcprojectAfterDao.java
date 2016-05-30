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
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.model.backstage.TcprojectAfter;


@Repository
public class TcprojectAfterDao extends  BaseDao<TcprojectAfter>{
	
	public Class getEntityClass()
	 {
	     return TcprojectAfter.class;
	 }
	
	public List<TcprojectAfter> getAllPname(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getAllPname", map,pb);
	}
	
	public List<TcprojectAfter> getAllAfter(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getAllAfter", map,pb);
	}
	

	public List<TcprojectAfter> getAfterDeail(long fileId){
		QueryFilter filter = new QueryFilter();
		filter.addFilter("fileId", fileId);
		return getBySqlKeyAll(filter, TcprojectAfter.class,"getAfterDeail");
	}

	public List<TcprojectAfter> getProjectAfter(QueryFilter queryFilter) {
		// TODO Auto-generated method stub
		return getBySqlKey("getProjectAfter", queryFilter);
	}

	
}
