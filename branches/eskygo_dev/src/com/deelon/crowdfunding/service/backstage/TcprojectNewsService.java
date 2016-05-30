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
import com.deelon.core.service.BaseService;
import com.deelon.crowdfunding.dao.backstage.TcprojectNewsDao;
import com.deelon.crowdfunding.model.backstage.TcprojectNews;

@ Service
public class TcprojectNewsService extends BaseService<TcprojectNews>{
	
	@ Resource
	private TcprojectNewsDao tcprojectNewsDao;
	
	protected IEntityDao<TcprojectNews, Long> getEntityDao()
	{
		return this.tcprojectNewsDao;
	}
	
	/**
	 * 获取项目下的动态
	 * @param proid
	 * @return
	 */
	public List<TcprojectNews> getByProId(Map<String,Object> map){
		return tcprojectNewsDao.getByProId(map);
	}

}