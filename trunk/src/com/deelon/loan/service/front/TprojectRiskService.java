/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.front;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.front.TprojectRiskDao;
import com.deelon.loan.model.front.TProjectRisk;

@ Service
public class TprojectRiskService extends BaseService<TProjectRisk>{
	
	@ Resource
	private TprojectRiskDao tprojectRiskDao;
	
	protected IEntityDao<TProjectRisk, Long> getEntityDao()
	{
		return this.tprojectRiskDao;
	}
	
	/**
	 * 保存或更新
	 * @param TProjectRisk
	 * @return
	 */
	public int saveOrUpdateTProjectRisk(TProjectRisk tprojectRisk){
		return tprojectRiskDao.saveOrUpdateTProjectRisk(tprojectRisk);
	}
	
	/**
	 * 分页,查询用户的资金流动记录 
	 * @param queryFilter
	 * @return
	 */
	public List<TProjectRisk> getAllDataOfUser(QueryFilter queryFilter){
		return tprojectRiskDao.getAllDataOfUser(queryFilter);
	}
	
	/**
	 * 获取用户的所有交易数据
	 * @return
	 */
	public List<TProjectRisk> getAllData(TProjectRisk tprojectRisk){
		return tprojectRiskDao.getAllData(tprojectRisk);
	}
	
	/**
	 * 查询记录 by 贷款项目id
	 * @param proId
	 * @return
	 */
	public TProjectRisk getTProjectRiskByProId(long proId){
		return tprojectRiskDao.getTProjectRiskByProId(proId);
	}
	

}