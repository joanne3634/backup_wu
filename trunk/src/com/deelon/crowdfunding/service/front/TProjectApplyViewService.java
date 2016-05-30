/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.service.front;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.crowdfunding.dao.front.TProjectApplyViewDao;
import com.deelon.loan.model.front.TProjectApplyView;

@ Service
public class TProjectApplyViewService extends BaseService<TProjectApplyView>{
	
	@ Resource
	private TProjectApplyViewDao tProjectApplyViewDao;
	
	protected IEntityDao<TProjectApplyView, Long> getEntityDao()
	{
		return this.tProjectApplyViewDao;
	}
	
	public List<TProjectApplyView> getTProjectApplyViewList(Long projectId){
		return tProjectApplyViewDao.getTProjectApplyViewList(projectId);
	}
//	public List<TProjectApplyView> getTProjectApplyViewUserList(Long projectId){
//		return tProjectApplyViewDao.getTProjectApplyViewUserList(projectId);
//	}
	public Long queryPavAgreeViewCount(Long projectId){
		return tProjectApplyViewDao.queryPavAgreeViewCount(projectId);
	}
	/**
	 * 保存记录
	 * @param 
	 */
	public void saveTbankcard(TProjectApplyView tProjectApplyView){
		tProjectApplyViewDao.saveTProjectApplyView(tProjectApplyView);
	}
	
	/**
	 * 更新记录
	 * @param 
	 */
	public void updateTbankcard(TProjectApplyView tProjectApplyView){
		tProjectApplyViewDao.update(tProjectApplyView);
	}

	

}