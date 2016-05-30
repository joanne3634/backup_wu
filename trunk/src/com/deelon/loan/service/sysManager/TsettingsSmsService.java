package com.deelon.loan.service.sysManager;




import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.sysManager.TsettingsSmsDao;
import com.deelon.loan.model.sysManager.TsettingsSms;


@ Service
public class TsettingsSmsService extends BaseService<TsettingsSms>{
	
	@ Resource
	private TsettingsSmsDao tsettingsSmsDao;
	
	protected IEntityDao<TsettingsSms, Long> getEntityDao()
	{
		return this.tsettingsSmsDao;
	}
	
	public TsettingsSms getFirstOneSms(){
		List<TsettingsSms> list  =tsettingsSmsDao.getFirstOne();
		if(list.size()>0){
			TsettingsSms tsettingsSms =list.get(0);
			return tsettingsSms;
		}else{
			return null;
		}
	}

}