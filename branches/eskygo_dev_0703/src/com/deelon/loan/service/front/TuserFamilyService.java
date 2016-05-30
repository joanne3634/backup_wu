package com.deelon.loan.service.front;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.front.TUserFamilyDao;
import com.deelon.loan.model.front.TUserFamily;

@ Service
public class TuserFamilyService extends BaseService<TUserFamily> {

	@ Resource
	private TUserFamilyDao tuserFamilyDao;

	@Override
	protected IEntityDao<TUserFamily, Long> getEntityDao() {
		return this.tuserFamilyDao;
	}
	
	/**
	 * 根据用户id查询记录
	 * @param userId
	 * @return
	 */
	public TUserFamily queryTUserFamilyByuserId(String userId){
		return tuserFamilyDao.queryTUserFamilyByuserId(userId);
	}
}
