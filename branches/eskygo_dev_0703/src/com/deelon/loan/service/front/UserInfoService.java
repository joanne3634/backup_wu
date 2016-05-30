package com.deelon.loan.service.front;

import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deelon.core.encrypt.EncryptUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.front.TUserCheckcodeDao;
import com.deelon.loan.dao.front.TUserCompanyDao;
import com.deelon.loan.dao.front.TUserContactDao;
import com.deelon.loan.dao.front.TUserDao;
import com.deelon.loan.dao.front.TUserFamilyDao;
import com.deelon.loan.dao.front.TUserSafeDao;
import com.deelon.loan.dao.sysManager.TsmsinformationDao;
import com.deelon.loan.dao.sysManager.TuserFundsDao;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserCheckcode;
import com.deelon.loan.model.front.TUserCompany;
import com.deelon.loan.model.front.TUserContact;
import com.deelon.loan.model.front.TUserFamily;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.sysManager.TUserMobileChange;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.sysManager.SmsSendService;
import com.deelon.loan.service.sysManager.TUserMobileChangeService;
import com.deelon.loan.util.MD5Util;

@Service
public class UserInfoService {

	@Autowired
	private TUserContactDao tUserContactDao;

	@Autowired
	private TUserFamilyDao tUserFamilyDao;

	@Autowired
	private TUserDao tUserDao;

	@Autowired
	private TUserSafeDao tUserSafeDao;

	@Autowired
	private TUserCompanyDao tUserCompanyDao;

	@Autowired
	private TUserCheckcodeDao tUserCheckcodeDao;
	
	@Autowired
	private TuserFundsDao tuserFundsDao;
	
	@Autowired
	private TsmsinformationDao tsmsinformationDao;
	
	@Autowired
	private TUserMobileChangeService tuserMobileChangeService;
	
	@Autowired
	private SmsSendService smsSendService;

	private static Logger logger = LoggerFactory.getLogger(TUserService.class);
	
	public TUserCompany getUserCompanyByUserId(long userId){
		List<TUserCompany> userCompanies = tUserCompanyDao.getUserCompanyByColumn("user_Id", userId);
		if(userCompanies==null || userCompanies.size()==0){
			return null;
		}
		return userCompanies.get(0);
	}
	public TUserContact getUserContactByUserId(long userId){
		List<TUserContact> userContact = tUserContactDao.getUserContactByColumn("user_Id", userId);
		if(userContact==null || userContact.size()==0){
			return null;
		}
		return userContact.get(0);
	}
	
	public TUserFamily getUserFamilyByUserId(long userId){
		List<TUserFamily>  ufs = tUserFamilyDao.getUserFamilyByColumn("user_Id", userId);
		if(ufs == null || ufs.size() == 0){
			return null;
		}
		return ufs.get(0);
	}
	
	public TUserSafe getUserSafeByUserId(long userId){
		List<TUserSafe> uss = tUserSafeDao.getUserSafeByColumn("user_id", userId);
		if(uss == null || uss.size()==0){
			return null;
		}
		return uss.get(0);
	}

	/**
	 * 编辑会员资料
	 */
	public void editUserInfo(TUser user) {
		tUserDao.updateUser(user);
	}

	/**
	 * 编辑会员联系方式
	 * 
	 * @param userContact
	 */
	public void editUserInfo(TUserContact userContact) {
		
		List<TUserContact> ucts = tUserContactDao.getUserContactByColumn(
				"user_id", userContact.getUserId());
		if (ucts == null || ucts.size() == 0) {
			userContact.setContactId(UniqueIdUtil.genId());
			tUserContactDao.addUserContact(userContact);
		} else {
			userContact.setCUpdateTime(new Date());
			tUserContactDao.updateUserContactByUserId(userContact);
		}
	}

	/**
	 * 编辑会员家庭情况
	 * 
	 * @param userFamily
	 */
	public void editUserInfo(TUserFamily userFamily) {
		List<TUserFamily> ufs = tUserFamilyDao.getUserFamilyByColumn("user_id",
				userFamily.getUserId());
		userFamily.setFUpdateTime(new Date());
		userFamily.setFamilyId(Long.valueOf(UniqueIdUtil.genId()));
		if (ufs == null || ufs.size() == 0) {
			userFamily.setFamilyId(UniqueIdUtil.genId());
			tUserFamilyDao.addUserFamily(userFamily);
		} else {
			System.out.println("修改用户家庭资料");
			tUserFamilyDao.updateUserFamilyByUserId(userFamily);
		}
	}

	/**
	 * 编辑会员用户安全信息
	 * 
	 * @param userSafe
	 */
	public void editUserInfo(TUserSafe userSafe) {
		List<TUserSafe> userSafes = tUserSafeDao.getUserSafeByColumn("user_id",
				userSafe.getUserId());
		if (userSafes == null || userSafes.size() == 0) {
			tUserSafeDao.saveUserSafe(userSafe);
		} else {
			tUserSafeDao.updateUserSafeByUserId(userSafe);
		}
	}
	/**
	 * 获取会员用户安全信息
	 * 
	 * @param userSafe
	 */
	public TUserSafe getUserSafe(long userId) {
		List<TUserSafe> userSafes = tUserSafeDao.getUserSafeByColumn("user_id",
				userId);
		if(userSafes.size() == 0){
			return new TUserSafe();
		}
		return userSafes.get(0);

	}
	/**
	 * 获取会员用户安全信息
	 * 
	 * @param userSafe
	 */
	public TUser getUserByUserId(long userId) {
		return tUserDao.getUserByUserId(userId);
	}
	
	
	/**
	 * 重置会员用户密码
	 * 
	 * @param userSafe
	 */
	public boolean resetTuserPass(TUser t) {
		
		try {
			tUserDao.updateUser(t);
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return false;
	}
	

	/**
	 * 编辑会员单位信息
	 * 
	 * @param userCompany
	 */
	public void editUserInfo(TUserCompany userCompany) {
		List<TUserCompany> userCompanies = tUserCompanyDao
				.getUserCompanyByColumn("user_id", userCompany.getUserId());
		userCompany.setCUpdateTime(new Date());
		if (userCompanies == null || userCompanies.size() == 0) {
			userCompany.setCompanyId(Long.valueOf(UniqueIdUtil.genId()));
			tUserCompanyDao.saveUserCompany(userCompany);
			logger.debug(String.format("用户{%s}单位信息不存在,不能添加单位信息",
					userCompany.getUserId()));
		} else {
			tUserCompanyDao.updateUserCompanyByUserId(userCompany);
		}
	}

	public void bindEmail(long userId, String email) {
		
	}

	/**
	 * 验证手机验证码
	 * 
	 * @param userId
	 * @param mobileCode
	 * @return
	 */
	public boolean validatePhoneCode(long userId, String mobileCode,String phone,HttpServletRequest request) {
		List<TUserSafe> userSafes = tUserSafeDao.getUserSafeByColumn("user_id",
				userId);
		TUserSafe userSafe = userSafes.get(0);
		
		//TUserCheckcode uck = tUserCheckcodeDao.getUserCheckcodeByUserIdDesc(userId);
		
		String sysCode = (String) request.getSession().getAttribute("BIND_PHONE_CODE");  //绑定手机验证码
		
		if(sysCode == null){return false;}    
		
		if (sysCode.equals(mobileCode)) {
			TUserCheckcode uck = tUserCheckcodeDao.getUserCheckcodeByUserIdAndCode(userId, mobileCode);
			TUserMobileChange tUserMobileChange = new TUserMobileChange();
			tUserMobileChange.setMobileOld(userSafe.getMobile());
			tUserMobileChange.setMobileNew(phone);
			tUserMobileChange.setCreateTime(new Date());
			tUserMobileChange.setUserId(userId); 
			tuserMobileChangeService.add(tUserMobileChange);
			uck.setIsPass((short)1);
			userSafe.setBindMobile((short) 1);
			userSafe.setMobile(phone);
			tUserSafeDao.updateUserSafeByUserId(userSafe);
			tUserCheckcodeDao.updateUserCheckcode(uck);
			request.getSession().removeAttribute("BIND_PHONE_CODE");
			return true;
		}
		return false;
	}

	/**
	 * 发送手机验证码    。。。。。。(绑定,修改手机号码操作)
	 * 
	 * @param 当前登录的用户Id  (userId)
	 * @param 接收验证码的手机  (phone)
	 * @param 绑定或者修改 (phoneflag)
	 * @param request
	 * @throws UserException
	 */
	public String sendbindMobileCode(long userId,String phone,String phoneflag,HttpServletRequest request) throws UserException {
		
		//List<TUserSafe> userSafes = tUserSafeDao.getUserSafeByColumn("user_id",
		//		userId);
		//if (userSafes == null || userSafes.size() == 0) {
		//	return "个人信息未填写完整,不能绑定手机";
			//throw new UserException("个人信息未填写完整,不能绑定手机!");
		//}
		//TUserSafe userSafe = userSafes.get(0);
		TUserCheckcode uck = new TUserCheckcode();
		uck.setCheckCodeId(UniqueIdUtil.genId());
		uck.setUserId(userId);
		// TODO 像手机发送验证码
		String code = String.valueOf(100000 + new Random().nextInt(100000));
		logger.debug("手机验证码: " + code);
		uck.setCheckCodeId(UniqueIdUtil.genId());
		uck.setCheckCode(code);
		uck.setFromObj(phone);
		uck.setTypeId("手机验证码");
		uck.setCreateTime(new Date());
		uck.setIsHaveSend((short)1);
		uck.setIsPass((short) 0);
		
		try {
			tUserCheckcodeDao.saveUserCheckcode(uck);
			
			String content = "尊敬的会员您好，您的手机验证码："+code + ",为了保证用户安全,请勿将信息泄漏【无忧筹】";
			String[] str = smsSendService.getSendSmsInfoResult(phone, content, "", "p");
			
			Tsmsinformation tsmsinformation = new Tsmsinformation();
			tsmsinformation.setInfoId(UniqueIdUtil.genId());
			tsmsinformation.setServiceType(1);
			tsmsinformation.setMobileNum(phone);
			tsmsinformation.setMessasge(content);
			tsmsinformation.setCreator(userId);
			tsmsinformation.setCreateTime(new Date());
			if("0".equals(str[0])){
				tsmsinformation.setStatus(2);//成功状态
			}else{
				tsmsinformation.setStatus(3);//失败状态
			}
			
			tsmsinformation.setSendTime(new Date());
			tsmsinformationDao.add(tsmsinformation);

			if("0".equals(str[0])){
				return "验证码已发送，请查收";
			}
			
			if("changephone".equals(phoneflag)){
				request.getSession().setAttribute("change_PHONE_CODE", code);
			}else{
				request.getSession().setAttribute("BIND_PHONE_CODE", code);
			}			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return "验证码发送失败";
	}
	/**
	 * 微信平台注册发送手机验证码
	 */
	public boolean sendbindMobileCode(String phone,HttpServletRequest request){
		TUserCheckcode uck = new TUserCheckcode();
		uck.setCheckCodeId(UniqueIdUtil.genId());
		uck.setUserId(0);
		String code = String.valueOf(100000 + new Random().nextInt(100000));
		logger.debug("手机验证码: " + code);
		uck.setCheckCode(code);
		uck.setFromObj(phone);
		uck.setTypeId("手机验证码");
		uck.setCreateTime(new Date());
		uck.setIsHaveSend((short)1);
		uck.setIsPass((short) 0);
		
		try {
			tUserCheckcodeDao.saveUserCheckcode(uck);
			request.getSession().setAttribute("BIND_PHONE_CODE", code);
			request.getSession().setAttribute("BIND_PHONE", phone);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return false;
		}
		return true;
	}
	/**
	 * 发送邮箱验证码
	 * 
	 * @param userId
	 * @throws UserException
	 */
	public String sendbindEmailCode(long userId,String email) throws UserException {
		List<TUserSafe> userSafes = tUserSafeDao.getUserSafeByColumn("user_id",
				userId);
		if (userSafes == null || userSafes.size() == 0) {
			return "个人信息未填写完整,不能绑定邮箱";
			//throw new UserException("个人信息未填写完整,不能绑定手机!");
		}
		//TUserSafe userSafe = userSafes.get(0);
		String rEmail = email;
		TUserCheckcode uck = new TUserCheckcode();
		uck.setCheckCodeId(UniqueIdUtil.genId());
		uck.setUserId(userId);
		// TODO 向邮箱发送验证码
		String code = String.valueOf(100000 + new Random().nextInt(100000));
		logger.debug("邮箱验证码: " + code);
		uck.setCheckCode(code);
		uck.setFromObj(rEmail);
		uck.setTypeId("邮箱验证码");
		uck.setCreateTime(new Date());
		uck.setIsHaveSend((short)1);
		try {
			tUserCheckcodeDao.saveUserCheckcode(uck);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return "验证码已发送，请注意查收";
	}
	
	/**
	 * 验证邮箱验证码
	 * 
	 * @param userId
	 * @param mobileCode
	 * @return
	 */
	public boolean validateEmailCode(long userId, String emailCode,String email,HttpServletRequest request) {
		//List<TUserSafe> userSafes = tUserSafeDao.getUserSafeByColumn("user_id",
		//		userId);
		//TUserSafe userSafe = userSafes.get(0);
		//TUserCheckcode uck = tUserCheckcodeDao.getUserCheckcodeByUserIdAndCode(userId, emailCode);
		//验证验证码是否正确
		QueryFilter query = new QueryFilter();
		query.addFilter("checkCode", emailCode);
		query.addFilter("userId", userId);
		query.addFilter("isPass", 0);
		List list = tUserCheckcodeDao.getAll(query);
		if(list.size() == 0){
			return false;
			
		}
		TUserCheckcode uck = (TUserCheckcode) list.get(0);
		uck.setIsPass((short) 1);
		tUserCheckcodeDao.update(uck);
		return true;

	}
	
	
	/**
	 *  保存发送验证记录
	 * 
	 * @param TUserCheckcode

	 */
	public boolean saveUserCheckcode(TUserCheckcode uck){
		
		try {
			tUserCheckcodeDao.saveUserCheckcode(uck);
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return false;
		
	}

	/**
	 * 保存安全问题
	 * 
	 * @param userId
	 * @param q1
	 * @param a1
	 * @param q2
	 * @param a2
	 * @param q3
	 * @param a3
	 * @throws Exception 
	 */
	public void saveSafeQuestion(long userId, String q1, String a1, String q2,
			String a2, String q3, String a3) throws Exception {
		TUserSafe userSafe = tUserSafeDao.getUserSafeByColumn("user_id", userId).get(0);
		userSafe.setUserId(userId);
		userSafe.setQ1(q1);
		userSafe.setQ2(q2);
		userSafe.setQ3(q3);
		userSafe.setA1(EncryptUtil.encryptMd5(a1));   //encryptSha256加密
		userSafe.setA2(EncryptUtil.encryptMd5(a2));	 //encryptSha256加密
		userSafe.setA3(EncryptUtil.encryptMd5(a3));   ////encryptSha256加密
		//List<TUser> users = tUserDao.getUserBycolumn("user_id", userId);
		//System.out.println(users.get(0));
		//if (users == null || users.size() == 0) {
		//	tUserSafeDao.saveUserSafe(userSafe);
		//} else {
			tUserSafeDao.updateUserSafeByUserId(userSafe);
		//}
	}
	
	/**
	 * 根据用户名获取user
	 * 
	 * @param loginName
	 * @return
	 */
	public TUser getTUserByLoginName(String loginName) {
		
		return tUserDao.getUserByLoginName(loginName);
	}
	
	public TUserFunds getUserFundsInfo(long userId){
		return tuserFundsDao.getByUserId(userId);
	}
	
	public void updateUserFundsInfo(TUserFunds userFunds){
		tuserFundsDao.saveOrUpdateTUserFunds(userFunds);
	}

	public boolean validatePassword(long userId, String password) {
		TUser user = tUserDao.getUserBycolumn("user_id", userId).get(0);
		System.out.println(user);
		//return password.equals(MD5Util.MD5(user.getLoginPwd()));
		return !MD5Util.MD5(password).equals(user.getLoginPwd());
	}
}
