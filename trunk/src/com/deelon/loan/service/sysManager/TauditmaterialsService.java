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
import com.deelon.loan.dao.sysManager.TauditmaterialsDao;
import com.deelon.loan.model.sysManager.Tauditmaterials;

@ Service
public class TauditmaterialsService extends BaseService<Tauditmaterials>{
	
	@ Resource
	private TauditmaterialsDao tauditmaterialsDao;
	
	protected IEntityDao<Tauditmaterials, Long> getEntityDao()
	{
		return this.tauditmaterialsDao;
	}
	public List<Tauditmaterials> getTauditmaterialsList(){
		return tauditmaterialsDao.getTauditmaterialsList();
		
	}
	
	/**
	 * 获取用户已经上传 和未上传的资料
	 * @param userId
	 * @return
	 */
	public List<Tauditmaterials> getAudiMeByUserId(long userId){
		return tauditmaterialsDao.getAudiMeByUserId(userId);
	}

}