package com.deelon.loan.service.sysManager;




import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TbankDao;
import com.deelon.loan.model.sysManager.Tbank;

@ Service
public class TbankService extends BaseService<Tbank>{
	
	@ Resource
	private TbankDao tbankDao;
	
	protected IEntityDao<Tbank, Long> getEntityDao()
	{
		return this.tbankDao;
	}

	public List getAllOther(QueryFilter queryFilter) {
		return tbankDao.getAllOther(queryFilter);
	}
	
	public List<Tbank> getAllByWhere(Map<String,Object> map) {
		return tbankDao.getAllByWhere(map);
	}

}