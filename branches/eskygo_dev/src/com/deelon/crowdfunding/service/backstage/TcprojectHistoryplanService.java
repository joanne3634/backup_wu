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
import com.deelon.crowdfunding.dao.backstage.TcprojectHistoryplanDao;
import com.deelon.crowdfunding.model.backstage.TcprojectHistoryplan;

@ Service
public class TcprojectHistoryplanService extends BaseService<TcprojectHistoryplan>{
	
	@ Resource
	private TcprojectHistoryplanDao tcprojectHistoryplanDao;
	
	protected IEntityDao<TcprojectHistoryplan, Long> getEntityDao()
	{
		return this.tcprojectHistoryplanDao;
	}

	/**
	 * 查询项目下的历史情况
	 * 
	 * @param proId
	 * @return
	 */
	public List<TcprojectHistoryplan> getByProId(Map<String,Object> map){
		return tcprojectHistoryplanDao.getByProId(map);
		
	}
	/**
	 * 查询项目下的历史情况和支出收入
	 * @param map
	 * @return
	 */
	public List<TcprojectHistoryplan> getproPlanandPayment(Map<String,Object> map){
		return tcprojectHistoryplanDao.getproPlanandPayment(map);
	}
	
}