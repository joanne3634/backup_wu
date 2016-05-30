package com.deelon.loan.service.sysManager;




import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.sysManager.TsettingsEmailDao;
import com.deelon.loan.model.sysManager.TsettingsEmail;


@ Service
public class TsettingsEmailService extends BaseService<TsettingsEmail>{
	
	@ Resource
	private TsettingsEmailDao tsettingsEmailDao;
	
	protected IEntityDao<TsettingsEmail, Long> getEntityDao()
	{
		return this.tsettingsEmailDao;
	}

	public TsettingsEmail getFirstOneEmail(){
		List<TsettingsEmail> list =tsettingsEmailDao.getFirstOne();
		if(list.size()>0){
			TsettingsEmail tsettingsEmail =list.get(0);
			return tsettingsEmail; 
		}else{
			return null;
		}
		
	}
}