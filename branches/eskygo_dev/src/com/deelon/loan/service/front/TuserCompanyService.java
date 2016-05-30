package com.deelon.loan.service.front;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.front.TUserCompanyDao;
import com.deelon.loan.model.front.TUserCompany;

@ Service
public class TuserCompanyService extends BaseService<TUserCompany> {

	@ Resource
	private TUserCompanyDao tuserCompanyDao;

	@Override
	protected IEntityDao<TUserCompany, Long> getEntityDao() {
		return this.tuserCompanyDao;
	}
	
	/**
	 * 根据用户id查询记录
	 * @param userId
	 * @return
	 */
	public TUserCompany queryTUserCompanyByuserId(String userId){
		return tuserCompanyDao.queryTUserCompanyByuserId(userId);
	}
}
