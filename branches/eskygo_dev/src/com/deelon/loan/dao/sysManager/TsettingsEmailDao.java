package com.deelon.loan.dao.sysManager;



import java.util.List;

import org.springframework.stereotype.Repository;
import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.sysManager.TsettingsEmail;



@Repository
public class TsettingsEmailDao extends  BaseDao<TsettingsEmail>{
	
	public Class getEntityClass()
	 {
	     return TsettingsEmail.class;
	 }

	public List<TsettingsEmail> getFirstOne(){
		return (List<TsettingsEmail>)getBySqlKey("getFirstOne");
	}
}
