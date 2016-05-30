package com.deelon.loan.service.front;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.encrypt.EncryptUtil;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.front.TUserContactDao;
import com.deelon.loan.dao.front.TUserDao;
import com.deelon.loan.dao.front.TUserFamilyDao;
import com.deelon.loan.dao.front.TUserSafeDao;
import com.deelon.loan.dao.front.TriskCompanyDao;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.TriskCompany;
import com.deelon.loan.util.MD5Util;

/**
 * 用户请求服务
 * 
 * @author deelon.hejian
 * 
 */
@Service
public class TriskCompanyService extends BaseService<TriskCompany> {

	@Autowired
	private TriskCompanyDao triskCompanyDao;



	private static Logger logger = LoggerFactory.getLogger(TriskCompanyService.class);


	
//	public TriskCompany getTriskCompanyById(long companyId){
//		List<TriskCompany> triskCompanys = triskCompanyDao.getTriskCompanyBycolumn("Company_id",companyId);
//		if(triskCompanys==null || triskCompanys.size() == 0){
//			return null;
//		}
//		return triskCompanys.get(0);
//	}
//	
//
//	
	@Override
	protected IEntityDao<TriskCompany, Long> getEntityDao() {
		// TODO Auto-generated method stub
		return this.triskCompanyDao;
	}
	
	/**
	 * 查找默认担保机构
	 * @return
	 */
	public TriskCompany getDefaultRiskcom(){
		return triskCompanyDao.getDefaultRiskcom();
	}
	
	/**
	 * 修改默认风控机构
	 * @return
	 */
	public void updateDefault(TriskCompany triskCompany){
		triskCompanyDao.updateDefault(triskCompany);
	}
}
