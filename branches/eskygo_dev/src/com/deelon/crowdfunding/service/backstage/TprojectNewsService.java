package com.deelon.crowdfunding.service.backstage;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */




import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.dao.backstage.TprojectNewsDao;
import com.deelon.crowdfunding.model.backstage.TcprojectNews;




@ Service
public class TprojectNewsService extends BaseService<TcprojectNews>{
	
	@ Resource
	private TprojectNewsDao tprojectNewsDao;
	
	protected IEntityDao<TcprojectNews, Long> getEntityDao()
	{
		return this.tprojectNewsDao;
	}
	//循环更新idDel状态
	public void update_isDel(Long[] ids){
		tprojectNewsDao.update_isDel(ids);
	}
	
	public List<TcprojectNews> getAllByTypeId(QueryFilter filter){
		List<TcprojectNews> list = tprojectNewsDao.getAllByTypeId(filter);
		return list;
	}
	
	public List<TcprojectNews> getTcprojectNewsCr(Map map){
		List<TcprojectNews> list = tprojectNewsDao.getTcprojectNewsCr(map);
		return list;
	}
	
	public List<TcprojectNews> getAllByCount(QueryFilter filter){
		List<TcprojectNews> list = tprojectNewsDao.getAllByTypeId(filter);
		return list;
	}
	
	public TcprojectNews getByNewId(Long pkid){
		TcprojectNews tcprojectNews = tprojectNewsDao.getByNewId(pkid);
		return tcprojectNews;
	}
}