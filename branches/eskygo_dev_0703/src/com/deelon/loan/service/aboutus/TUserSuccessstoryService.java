package com.deelon.loan.service.aboutus;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.aboutus.TUserSuccessstoryDao;
import com.deelon.loan.model.aboutus.TUserSuccessstory;

@ Service
public class TUserSuccessstoryService extends BaseService<TUserSuccessstory> {
	
	@Resource
	private TUserSuccessstoryDao tUserSuccessstoryDao;

	@Override
	protected IEntityDao<TUserSuccessstory, Long> getEntityDao() {
		return this.tUserSuccessstoryDao;
	}
	
	public void addSettings(TUserSuccessstory tUserSuccessstory) {
		tUserSuccessstoryDao.save(tUserSuccessstory);
	}

	public void updateSettings(TUserSuccessstory tUserSuccessstory) {
		tUserSuccessstoryDao.updateUserSuccesstory(tUserSuccessstory);
	}
	
	public List<TUserSuccessstory> getAll() {
		return tUserSuccessstoryDao.getAll();
	}
	public void del(long successstoryId) {
		tUserSuccessstoryDao.delById(successstoryId);
	}
}
