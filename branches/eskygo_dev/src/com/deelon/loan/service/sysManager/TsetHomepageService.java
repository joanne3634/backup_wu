/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.sysManager;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TsetHomepageDao;
import com.deelon.loan.model.sysManager.TSetHomepage;

@ Service
public class TsetHomepageService extends BaseService<TSetHomepage>{
	
	@ Resource
	private TsetHomepageDao tsetHomepageDao;
	
	protected IEntityDao<TSetHomepage, Long> getEntityDao()
	{
		return this.tsetHomepageDao;
	}
	
	/** 
	 * 通过分页查询所有
	 * @param queryFilter
	 * @return
	 */
	public List<TSetHomepage> getTSetHomepageByQuery(QueryFilter queryFilter){
		return tsetHomepageDao.getTSetHomepageByQuery(queryFilter);
	}
	
	/**
	 * 根据id获取记录
	 * @param homePageId
	 * @return
	 */
	public TSetHomepage getTSetHomepageById(String homePageId){
		return tsetHomepageDao.getTSetHomepageById(homePageId);
	}
	
	/**
	 * 更新或保存
	 * @param tSetHomepage
	 */
	public void saveOrUpTSetHomepage(TSetHomepage tSetHomepage){
		tsetHomepageDao.saveOrUpTSetHomepage(tSetHomepage);
	}
	
	/**
	 * 通过id删除
	 * @param id
	 */
	public void delTSetHomepageById(Long id){
		tsetHomepageDao.delTSetHomepageById(id);
	}

}