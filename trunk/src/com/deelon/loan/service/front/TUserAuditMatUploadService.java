package com.deelon.loan.service.front;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.encrypt.EncryptUtil;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.front.TUserAuditMatDao;
import com.deelon.loan.dao.front.TUserAuditMatUploadDao;
import com.deelon.loan.dao.front.TUserContactDao;
import com.deelon.loan.dao.front.TUserDao;
import com.deelon.loan.dao.front.TUserFamilyDao;
import com.deelon.loan.dao.front.TUserSafeDao;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserAuditMat;
import com.deelon.loan.model.front.TUserAuditMatUpload;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.util.MD5Util;

/**
 * 用户请求服务
 * 
 * @author deelon.hejian
 * 
 */
@Service
public class TUserAuditMatUploadService extends BaseService<TUserAuditMatUpload> {

	@Autowired
	private TUserAuditMatUploadDao tUserAuditMatUploadDao;


	private static Logger logger = LoggerFactory.getLogger(TUserAuditMatUploadService.class);

	@Override
	protected IEntityDao<TUserAuditMatUpload, Long> getEntityDao() {
		// TODO Auto-generated method stub
		return this.tUserAuditMatUploadDao;
	}

	
	public List<TUserAuditMatUpload> getUserAuditMatUploadByUserAndauditMatId(long userId ,long auditMatId){
		
		return tUserAuditMatUploadDao.getUserAuditMatUploadByUserAndauditMatId(userId, auditMatId);
	}
	
	
}
