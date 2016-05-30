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
import com.deelon.loan.dao.front.TUserContactDao;
import com.deelon.loan.dao.front.TUserDao;
import com.deelon.loan.dao.front.TUserFamilyDao;
import com.deelon.loan.dao.front.TUserSafeDao;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserAuditMat;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.util.MD5Util;

/**
 * 用户请求服务
 * 
 * @author deelon.hejian
 * 
 */
@Service
public class TUserAuditMatService extends BaseService<TUserAuditMat> {

	@Autowired
	private TUserAuditMatDao tUserAuditMatDao;

	@Autowired
	private TUserSafeDao tUserSafeDao;

	@Autowired
	private TUserContactDao tUserContactDao;

	@Autowired
	private TUserFamilyDao tUserFamilyDao;

	private static Logger logger = LoggerFactory.getLogger(TUserAuditMatService.class);

	@Override
	protected IEntityDao<TUserAuditMat, Long> getEntityDao() {
		// TODO Auto-generated method stub
		return this.tUserAuditMatDao;
	}
	public TUserAuditMat getUserAuditMatsByUser(long userId,Long materialsId){
		
		return tUserAuditMatDao.getUserAuditMatsByUser(userId,materialsId);
	}
	
	public Boolean insertUserAuditMats(TUserAuditMat t){
		
		return tUserAuditMatDao.insertUserAuditMats(t);
	}
	
	public TUserAuditMat getUserAuditMatsByUser(long userId ,long materialsId){
		
		return tUserAuditMatDao.getUserAuditMatsByUser(userId,materialsId);
	}
	
	/**
	 * 取得用户 提交的审核材料 和审核情况
	 * @param userId
	 * @return
	 */
	public List<TUserAuditMat> getAuditFileByUserId(long userId){
		return tUserAuditMatDao.getAuditFileByUserId(userId);
	}
}
