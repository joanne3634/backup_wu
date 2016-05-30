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
import com.deelon.crowdfunding.dao.backstage.TcprojectAfterDao;
import com.deelon.crowdfunding.model.backstage.TcprojectAfter;

@ Service
public class TcprojectAfterService extends BaseService<TcprojectAfter>{
	
	@ Resource
	private TcprojectAfterDao tcprojectAfterDao;
	
	protected IEntityDao<TcprojectAfter, Long> getEntityDao()
	{
		return this.tcprojectAfterDao;
	}
	

	public List<TcprojectAfter> getAllPname(Map<String,Object> map,PageBean pb){
		return tcprojectAfterDao.getAllPname(map,pb);
	}
	public List<TcprojectAfter> 	getAllAfter(Map<String,Object> map,PageBean pb){
		return tcprojectAfterDao.getAllAfter(map,pb);
	}

	
	public List<TcprojectAfter> getAfterDeail(long fileId){
		return tcprojectAfterDao.getAfterDeail(fileId);
	}


	public List<TcprojectAfter> getProjectAfter(QueryFilter queryFilter) {
		// TODO Auto-generated method stub
		return tcprojectAfterDao.getProjectAfter(queryFilter);
	}
}