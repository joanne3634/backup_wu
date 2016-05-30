package com.deelon.loan.service.front;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.front.TUserContactDao;
import com.deelon.loan.model.front.TUserContact;

@ Service
public class TuserContactService extends BaseService<TUserContact> {

	@ Resource
	private TUserContactDao tuserContactDao;

	@Override
	protected IEntityDao<TUserContact, Long> getEntityDao() {
		return this.tuserContactDao;
	}
	
	/**
	 * 根据用户id查询记录
	 * @param userId
	 * @return
	 */
	public TUserContact queryTUserContactByuserId(String userId){
		return tuserContactDao.queryTUserContactByuserId(userId);
	}
}
