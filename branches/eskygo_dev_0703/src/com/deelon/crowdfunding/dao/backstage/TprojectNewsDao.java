package com.deelon.crowdfunding.dao.backstage;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import java.util.List;

import com.deelon.core.db.BaseDao;
import com.deelon.core.util.BeanUtils;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.model.backstage.TcprojectNews;

@Repository
public class TprojectNewsDao extends  BaseDao<TcprojectNews>{
	
	public Class getEntityClass()
	 {
	     return TcprojectNews.class;
	 }
	//循环更新idDel状态
	public void update_isDel(Long[] ids){
	    if (BeanUtils.isEmpty(ids)) {
	        return;
	      }
	    for (long p : ids) {
//	    	Map map = new HashMap();
//	    	map.put("isDel", 1);
//	    	map.put("newsId", p);
//	        this.update("update_isDel", map);
	        TcprojectNews tcprojectNews = new TcprojectNews();
	        tcprojectNews.setIsDel(1);
	        tcprojectNews.setNewsId(p);
	        this.update("update_isDel", tcprojectNews);
	      }
	}
	
	public List<TcprojectNews> getAllByTypeId(QueryFilter filter){
		List<TcprojectNews> list = getBySqlKey("getAllByTypeId",filter);
		return list;
	}
	
	public List<TcprojectNews> getAllByCount(QueryFilter filter){
		List<TcprojectNews> list = getBySqlKey("getAllByCount",filter);
		return list;
	}
	
	public TcprojectNews getByNewId(Long pkid){
		TcprojectNews tcprojectNews = getUnique("getByNewId",pkid);
		return tcprojectNews;
	}
	public List<TcprojectNews> getTcprojectNewsCr(Map map) {
		List<TcprojectNews> list = getBySqlKey("getAllByTypeId",map);
		return list;
	}
}
