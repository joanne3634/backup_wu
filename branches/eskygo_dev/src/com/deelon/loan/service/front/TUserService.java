package com.deelon.loan.service.front;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.encrypt.EncryptUtil;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.DateUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.webservice.UserData;
import com.deelon.crowdfunding.webservice.UserDatas;
import com.deelon.loan.dao.front.*;
import com.deelon.loan.dao.sysManager.TuserFundsDao;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.TuserLoginlog;
import com.deelon.loan.service.sysManager.SmsSendService;
import com.deelon.loan.util.MD5Util;
import com.deelon.loan.util.SendEmailUtil;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 用户请求服务
 *
 * @author deelon.hejian
 */
@Service
public class TUserService extends BaseService<TUser> {
    @Resource
    private SmsSendService smsSendService;
    @Autowired
    private TUserDao tUserDao;

    @Autowired
    private TUserSafeDao tUserSafeDao;

    @Autowired
    private TUserContactDao tUserContactDao;

    @Autowired
    private TUserFamilyDao tUserFamilyDao;

    @Autowired
    private TuserFundsDao tuserFundsDao;

    @Autowired
    private TuserLoginlogDao tuserLoginlogDao;

    private static Logger logger = LoggerFactory.getLogger(TUserService.class);


    public void saveloginlog(TuserLoginlog tuserloginlog) {

        tuserloginlog.setActionTime(new Date());
        tuserLoginlogDao.add(tuserloginlog);
    }


    /**
     * 获取ip地址
     *
     * @param request
     * @return ip地址
     */
    public String getRemortIP(HttpServletRequest request) {
        if (request.getHeader("x-forwarded-for") == null) {
            return request.getRemoteAddr();
        }
        return request.getHeader("x-forwarded-for");
    }

    /**
     * 用户登陆
     *
     * @param loginName
     * @param loginPwd
     * @return
     * @throws Exception
     * @throws NumberFormatException
     */
    public String login(String loginName, String loginPwd, HttpServletRequest request) throws NumberFormatException, Exception {
        TUser user = tUserDao.getUserByLoginName(loginName);

        if (user == null) {
            logger.error("用户名不存在");
            return "用户名不存在";
        }

        if (user.getIsActive() == 0) {
            logger.error("用户名未被激活");
            return "用户名未被激活，请等待管理员激活";
        }

        //这里去掉密码错误次数限制
        /*if (user.getLoginPwdErrCount() >= Integer.valueOf(AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString())) {
            //当前时间
			long currentTime = Date.parse(DateFormatUtil.format(new Date(), "yyyy/MM/dd"));	
			//解锁时间
			long deblockingTime = Date.parse(DateUtil.addOneDay(DateFormatUtil.formaDatetTime(user.getLastLoginTime())));
			
			if(currentTime < deblockingTime){				
				logger.error("密码输入错误"+ Integer.valueOf(AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString()) +"次已被锁定,次日自动解锁");
				return "密码输入错误"+ Integer.valueOf(AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString()) +"次已被锁定，次日自动解锁";
			}
		}else{
			if(user.getIsLock() == 1){
				logger.error("用户名已被锁定");
				return "用户名已被锁定，请联系管理员解锁";
			}
		}*/

        if (!MD5Util.MD5(loginPwd).equals(user.getLoginPwd())) {
            //密码输错，，，累加密码错误次数，，更新登录时间
            /*user.setLoginPwdErrCount(user.getLoginPwdErrCount() + 1);
            user.setLastLoginTime(new Date());
			tUserDao.update(user);
			*/
            /*//达到锁定条件    改变锁定状态  值为 1
            if(Integer.valueOf(AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString()) - user.getLoginPwdErrCount() == 0){
				user.setIsLock(1);
				tUserDao.update(user);
				logger.error("密码输入错误"+ Integer.valueOf(AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString()) +"次已被锁定,次日自动解锁");
				return "密码输入错误"+ Integer.valueOf(AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString()) +"次已被锁定，次日解锁";
			}*/
            //未达到锁定条件，，，，提示还有多少次机会
            //	logger.error("密码输入错误,您还有" + (Integer.valueOf(AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString()) - user.getLoginPwdErrCount()) + "次机会");
            //	return "密码输入错误,您还有" + (Integer.valueOf(AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString()) - user.getLoginPwdErrCount()) + "次机会";
            logger.error("密码输入错误!");
            return "密码输入错误!";
        }
        if (user.getLoginPwdErrCount() > 0) {
            user.setLoginPwdErrCount(0);
        }
        user.setLastLoginTime(new Date());
        user.setLoginCount(user.getLoginCount() + 1);
        user.setTradingPwdErrCount(0);
        tUserDao.update(user);
        user = tUserDao.getUserByLoginName(user.getLoginName());
        request.getSession().setAttribute("user", user);

        //tuserLoginlog.setActionTime(new Date());
        //tuserLoginlog.setResultId("1");
        //tuserLoginlog.setRemarks("登录成功");
        //saveloginlog(tuserLoginlog);   //记录登录日志

        return "0";

    }

    /**
     * 用户注册
     *
     * @param userSafe
     * @param user
     * @return
     * @throws Exception
     */
	public String register(TUserSafe userSafe, TUser user, HttpServletRequest request) throws Exception{

        if (tUserDao.getUserByLoginName(user.getLoginName()) != null) {
            return "该会员已被注册,请更换会员";
        }
        if (this.existEmail(userSafe.getEmail())) {
            return "该邮箱已被注册,请更换邮箱";
        }
        if (this.existIdNo(userSafe.getIdNo())) {
            return "该身份证号已被注册,请更换身份证";
        }
        if (tUserSafeDao.getUserSafeByColumn("Mobile", userSafe.getMobile()).size() > 0) {
            return "该手机号已被注册,请更换手机";
        }
        
            String Pwd = user.getLoginPwd();
            user.setUserId(UniqueIdUtil.genId());
            user.setLoginPwd(MD5Util.MD5(Pwd));
            //交易密码初始化为登录密码
            user.setTradingPwd(EncryptUtil.encryptSha256(Pwd));
            try{
            	 user.setIsActive(Integer.valueOf(AppUtil.getServletContext().getAttribute("ACTIVATION").toString()));  //系统设置的激活状态   1是 0否
                 if (Short.valueOf(AppUtil.getServletContext().getAttribute("LOCK").toString()) == 1) {   //系统设置的锁定状态 1锁定 0未锁定
                     user.setLoginPwdErrCount(Integer.valueOf(AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString()));

                 } else {
                     user.setLoginPwdErrCount(0);
                 }
                 user.setIsLock(Integer.valueOf(AppUtil.getServletContext().getAttribute("LOCK").toString()));
            }catch(Exception e){
            	logger.error("注册失败",e);
            	throw new UserException(e);
            }
           
            user.setGender("");
            user.setAge(0);
            user.setEdu("");
            user.setSchool("");
            user.setChecker((long) 0);
            user.setIsLeader(0);
            user.setIsAskPrice(0);
            user.setAskTimes(0);
            user.setIsDel(0);
            user.setIsCheck(0);
            user.setIsRecommended(0);
            if ("1".equals(user.getGroupId())) {   //创业者
                user.setProvincesId(0L);
                user.setCityId(0L);
                user.setContactName("");
                user.setBusinessLicense("");
            } else {
                if (0 == user.getIsCompany()) { // 个人投资
                    user.setContactName("");
                    user.setBusinessLicense("");
                } else {
                    //user.setRealName("");
					/**
					 *投资机构注册时，将联系人姓名同时保存到真实姓名
					 */
					user.setRealName(user.getContactName());
                }
            }
            //是否系统设置了锁定，或未激活
            try{
            	 if (Short.valueOf(AppUtil.getServletContext().getAttribute("LOCK").toString()) == 0 && Short.valueOf(AppUtil.getServletContext().getAttribute("ACTIVATION").toString()) == 1) {
                     user.setLastLoginTime(new Date());    //最后登录时间
                     user.setLoginCount(1);  //累计登录次数
                 } else {
                     user.setLoginCount(0);  //累计登录次数
                 }
            	 user.setTradingPwdErrCount(0);
            	 user.setRegisterTime(new Date());   //注册时间
            	 tUserDao.add(user);    //保存注册会员到数据库
            	 user = tUserDao.getUserByLoginName(user.getLoginName());
            	 request.getSession().setAttribute("user", user);
            	 userSafe.setSafeId(UniqueIdUtil.genId());
            	 userSafe.setUserId(user.getUserId());
            	 userSafe.setBindMobile((short)1);
            	 tUserSafeDao.saveUserSafe(userSafe);
            }catch(Exception e){
            	logger.error("注册失败",e);
            	throw new UserException(e);
            }
            try{
            	TUserFunds tuserFunds = new TUserFunds();
            	tuserFunds.setFundsId(UniqueIdUtil.genId());
            	tuserFunds.setUserId(user.getUserId());
            	tuserFunds.setLimitMaxIn(BigDecimal.valueOf(Long.valueOf(AppUtil.getServletContext().getAttribute("LIMIT_MAX_IN").toString())));  //系统设置借入额度
            	tuserFunds.setLimitMaxOut(BigDecimal.valueOf(Long.valueOf(AppUtil.getServletContext().getAttribute("LIMIT_MAX_OUT").toString())));//系统设置借出额度
            	tuserFunds.setBalance(BigDecimal.valueOf(0));
            	tuserFunds.setFreeze(BigDecimal.valueOf(0));
            	tuserFunds.setAvailable(BigDecimal.valueOf(0));
            	tuserFunds.setFundsIn(BigDecimal.valueOf(0));
            	tuserFunds.setFundsOut(BigDecimal.valueOf(0));
            	tuserFunds.setCreditIn(0);
            	tuserFunds.setCreditOut(0);
            	tuserFunds.setPayMark("");
            	tuserFundsDao.add(tuserFunds);
            	//发送验证码到短信开始
            	String content = "您好，您已成功注册为无忧筹众筹系统的会员，会员名为" + user.getLoginName() + "【无忧筹】";
            	smsSendService.getSendSmsInfoResult(userSafe.getMobile(), content, "", "P");
                //发送短信结束
                //发送邮件开始
    			SendEmailUtil.sendEmail(userSafe.getEmail(), "注册成功提示", content);   //发送邮件
            }catch(Exception e){
            	
            }
            return "0";
    }

    /**
     * 验证用户名是否存在 (存在返回true,不存在返回false)
     *
     * @param loginName
     * @return
     */
    public boolean existLoginName(String loginName) {
        if ((tUserDao.getUserBycolumn("LoginName", loginName).size() > 0)) {
            return true;
        }
        return false;
    }

    /**
     * 验证邮箱是否被绑定
     *
     * @param email
     * @return
     */
    public boolean existEmail(String email) {
        if ((tUserSafeDao.getUserSafeByColumn("EMail", email).size() > 0)) {
            return true;
        }
        return false;
    }

    /**
     * 验证身份证号
     *
     * @param idNo
     * @return
     */
    public boolean existIdNo(String idNo) {
        if ((tUserSafeDao.getUserSafeByColumn("id_no", idNo).size() > 0)) {
            return true;
        }
        return false;
    }

    /**
     * 修改密码
     *
     * @param userSafe
     */
    public int modifyPwd(TUser tuser) {
        return tUserDao.updateUser(tuser);
    }

    /**
     * 根据登录账户查询
     *
     * @param tUser
     * @return
     */
    public TUser queryTUserByLoginName(TUser tUser) {
        return tUserDao.getUserByLoginName(tUser.getLoginName());
    }

    /**
     * 修改登录密码
     *
     * @param userId
     * @param oldPassword
     * @param newPassword
     * @param rePassword
     * @throws UserException
     */
    public String updateLoginPwd(long userId, String oldPassword,
                                 String newPassword, String rePassword) throws UserException {
        //String result = "";
        TUser user = tUserDao.getById(userId);
        if (user == null) {
            throw new UserException(String.format("用户{%s}不存在!", userId));
        }
        if (!MD5Util.MD5(oldPassword).equals(user.getLoginPwd())) {
            return "原密码输入错误";
        }
        if (!newPassword.equals(rePassword)) {
        	return "新密码输入不一致";
        }
        //throw new UserException(String.format("密码输入错误", userId));
        try {
            user.setLoginPwd(MD5Util.MD5(newPassword));
            int result = tUserDao.update(user);
            if (result > 0) {
                return "修改密码成功";
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        return "修改密码失败";
    }

    /**
     * 修改交易密码
     *
     * @param userId
     * @param oldPassword
     * @param newPassword
     * @param rePassword
     * @throws UserException
     */
    public String updateTradePwd(long userId, String oldPassword,
                                 String newPassword, String rePassword) throws UserException {

        TUser user = tUserDao.getById(userId);
        if (user == null) {
            throw new UserException(String.format("用户{%s}不存在!", userId));
        }
        if (!EncryptUtil.encryptSha256(oldPassword).equals(user.getTradingPwd())) {
            return "原始交易密码输入错误";
            //throw new UserException(String.format("密码输入错误", userId));
        } else {
            user.setTradingPwd(EncryptUtil.encryptSha256(newPassword));
            int result = tUserDao.updateUser(user);
            if (result > 0) {
                return "修改交易密码成功";
            }
        }
        return "修改交易密码失败";
    }

    public TUser getUserById(long userId) {
        List<TUser> users = tUserDao.getUserBycolumn("user_Id", userId);
        if (users == null || users.size() == 0) {
            return null;
        }
        return users.get(0);
    }

    /**
     * 获取用户的信息
     *
     * @return
     */
    public List<TUser> getAllUserInfos(QueryFilter queryFilter) {
        return tUserDao.getAllUserInfos(queryFilter);
    }

    /**
     * 获取用户的 图像 信用 家庭 工作 等信息
     *
     * @param userId
     * @return
     */
    public TUser getUserInfoForDetail(Long userId) {
        return tUserDao.getUserInfoForDetail(userId);
    }

    /**
     * 根据用户id获取用户的信息
     *
     * @param userId
     * @return
     */
    public TUser getuserInfoByUserId(Long userId) {
        return tUserDao.getuserInfoByUserId(userId);
    }

    public int updateUser(TUser user) {
        return tUserDao.updateUser(user);
    }

    @Override
    protected IEntityDao<TUser, Long> getEntityDao() {
        // TODO Auto-generated method stub
        return this.tUserDao;
    }

    public List<TUser> updateUserTogether(Long[] lAryId) {
        // TODO Auto-generated method stub
        List<TUser> users = new ArrayList<TUser>();
        for (int i = 0; i < lAryId.length; i++) {
            long lon = lAryId[i];
            TUser user = tUserDao.getUserByUserId(lon);
            users.add(user);
        }
        return users;
    }


    public int updateAuditPeople(String userId, String pclerkId) {
        // TODO Auto-generated method stub
        if (userId.indexOf(",") == -1) {
            long userid = Long.parseLong(userId);
            long pclerkid = Long.parseLong(pclerkId);
            TUser user = new TUser();
            user.setUserId(userid);
            user.setChecker(pclerkid);
            int returnNum = tUserDao.updateUser(user);
            return returnNum;
        } else {
            String[] userIds = userId.split(",");
            long pclerkid = Long.parseLong(pclerkId);
            int returnNum = 0;
            for (int i = 0; i < userIds.length; i++) {
                long userid = Long.parseLong(userIds[i]);
                TUser user = new TUser();
                user.setUserId(userid);
                user.setChecker(pclerkid);
                returnNum = tUserDao.updateUser(user);
            }
            return returnNum;
        }

    }

    /**
     * 用绑定手机登陆
     *
     * @param mobile   手机号
     * @param loginPwd 密码
     * @param request
     * @throws Exception 在getMessage方法中获取登陆失败的说明
     */
    public void loginByMobile(String mobile, String loginPwd, HttpServletRequest request) throws Exception {
        TuserLoginlog tuserLoginlog = new TuserLoginlog();

        tuserLoginlog.setLoginLogId(Long.valueOf(UniqueIdUtil.genId()));
        tuserLoginlog.setTypeId("1");
        tuserLoginlog.setPlatformId("1");
        tuserLoginlog.setClientIp(getRemortIP(request));
        tuserLoginlog.setDeviceId("");
        tuserLoginlog.setUserId(0L);
        tuserLoginlog.setResultId("1");
        tuserLoginlog.setRemarks("登陆成功");

        TUser user = null;
        boolean flag = false;
        try {
            if (StringUtil.isEmpty(mobile) || StringUtil.isEmpty(loginPwd)) {
                throw new Exception("手机号码或密码为空！");
            }
            QueryFilter filter = new QueryFilter();
            filter.addFilter("mobile", mobile);
            List<TUserSafe> safeList = tUserSafeDao.getAll(filter);
            if (safeList == null || safeList.size() == 0) {
                throw new Exception("该手机号尚未注册！");
            }
            TUserSafe safe = safeList.get(0);
            user = this.getById(safe.getUserId());
            if (user == null) {
                throw new Exception("用户账号异常！");
            }

            tuserLoginlog.setUserId(user.getUserId());
            user.setLastLoginTime(new Date());
            user.setLoginCount(user.getLoginCount() + 1);

            if (user.getIsLock() == 1) {
                throw new Exception("用户已锁定！");
            }
            if (user.getIsActive() == 0) {
                throw new Exception("用户尚未激活");
            }
            if (!MD5Util.MD5(loginPwd).equals(user.getLoginPwd())) {
                user.setLoginPwdErrCount(user.getLoginPwdErrCount() + 1);
                int allowErrorCount = Integer.valueOf(AppUtil
                        .getServletContext()
						.getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString());

                int remianCount = allowErrorCount - user.getLoginPwdErrCount();
                if (remianCount <= 0) {
                    user.setIsLock(1);
                    throw new Exception("你的密码已经输入错误" + allowErrorCount
                            + "次，账号被锁定，请联系工作人员解锁");
                }
                throw new Exception("密码不正确,你已经输入密码错误"
                        + user.getLoginPwdErrCount() + "次，再输错账号" + remianCount + "将被锁定！");
            }
            flag = true;
        } catch (Exception e) {
            tuserLoginlog.setResultId("2");
            tuserLoginlog.setRemarks(e.getMessage());
            throw e;
        } finally {
            tuserLoginlog.setActionTime(new Date());
            this.saveloginlog(tuserLoginlog);
            if (user != null) {
                tUserDao.updateUser(user);
            }
            if (flag) {
                request.getSession().setAttribute("user", user);
            }
        }
    }

    /**
     * 根据认投项目获取用户的信息
     *
     * @return
     */
    public List<TUser> getUserByLeadProject(Long projectId) {
        return tUserDao.getUserByLeadProject(projectId);
    }

    /**
     * 获取领投人
     *
     * @return
     */
    public TUser getLeadInvestor(Long projectId) {
        TUser tuser = null;
        List<TUser> tuserList = tUserDao.getUserByLeadProject(projectId);
        if (tuserList != null && tuserList.size() > 0)
            tuser = tuserList.get(0);
        return tuser;
    }

    /**
     * 根据认投项目获取用户的信息
     *
     * @return
     */
    public List<TUser> getUserByFollowProject(Long projectId) {
        return tUserDao.getUserByFollowProject(projectId);
    }

    /**
     * 取得所有投资人信息通过项目ID
     *
     * @return
     */
    public List<TUser> getAllInvestorByProjectId(Long projectId) {
        return tUserDao.getAllInvestorByProjectId(projectId);
    }

    /**
     * 取得所有投资人信息
     *
     * @return
     */
    public List<TUser> getAllInvestorList(QueryFilter filter) {
        return tUserDao.getAllInvestorList(filter);
    }


    public void updateUserSafeByUserId(TUserSafe userSafe) {
        tUserSafeDao.updateUserSafeByUserId(userSafe);
    }

    public void updateById(TUser tUser) {
        tUserDao.updateById(tUser);
    }


    /**
     * webservice同步用户
     *
     * @param userSafe
     * @param user
     * @return
     * @throws Exception
     */
    public String syncInsertUser(String xmluserDatas) throws Exception {

//		if(tUserDao.getUserByLoginName(user.getLoginName()) != null){
//			return "该会员已被注册,请更换会员";
//		}
//		if(this.existEmail(userSafe.getEmail())){
//			return "该邮箱已被注册,请更换邮箱";
//		}
//		if(this.existIdNo(userSafe.getIdNo())){
//			return "该身份证号已被注册,请更换身份证";
//		}
//		if(tUserSafeDao.getUserSafeByColumn("Mobile", userSafe.getMobile()).size() > 0){
//			return "该手机号已被注册,请更换手机";
//		}

        String loginName = "";
        String loginPwd = "";
        String realName = "";
        String email = "";
        String mobile = "";
        String idNumber = "";
        String groupId = "";
        String registerTime = "";

        UserData userData = null;
        XStream s = new XStream(new DomDriver());
        s.alias("userDatas", UserDatas.class);
        s.alias("userData", UserData.class);
        s.autodetectAnnotations(true);
        UserDatas userDatas = (UserDatas) s.fromXML(xmluserDatas);
        if (userDatas != null) {
            if (userDatas.getUserDataList() != null && userDatas.getUserDataList().size() > 0) {
                List<UserData> userDataList = userDatas.getUserDataList();
                int userSize = userDatas.getUserDataList().size();
                for (int u = 0; u < userSize; u++) {
                    userData = userDataList.get(u);

                    loginName = userData.getLoginName();
                    loginPwd = userData.getLoginPwd();
                    realName = userData.getRealName();
                    email = userData.getEmail();
                    mobile = userData.getMobile();
                    idNumber = userData.getIdNumber();
                    groupId = userData.getGroupId();
                    registerTime = userData.getRegisterTime();
                    if (!existLoginName(loginName)) {

                        if (StringUtil.isEmpty(loginName)) {
                            return "登陆名称不能为空";
                        }
                        if (StringUtil.isEmpty(loginPwd)) {
                            return "登陆密码不能为空";
                        }
                        if (StringUtil.isEmpty(realName)) {
                            return "真实姓名不能为空";
                        }
                        if (StringUtil.isEmpty(email)) {
                            return "email不能为空";
                        }
                        if (StringUtil.isEmpty(mobile)) {
                            return "手机号码不能为空";
                        }
                        if (StringUtil.isEmpty(idNumber)) {
                            return "身份证号不能为空";
                        }
                        if (StringUtil.isEmpty(groupId)) {
                            return "分组不能为空,用户类型(1项目方2投资者3综合)";
                        }
                        TUser user = new TUser();
                        Long userIdreg = UniqueIdUtil.genId();
                        user.setUserId(userIdreg);
                        user.setLoginName(loginName);
                        user.setLoginPwd(loginPwd);
                        user.setRealName(realName);
                        user.setGroupId(groupId);
                        if (StringUtil.isNotEmpty(registerTime)) {
                            user.setRegisterTime(DateUtil.parseDate(registerTime));
                        } else {
                            user.setRegisterTime(new Date());
                        }
                        user.setTradingPwd(EncryptUtil.encryptSha256(loginPwd));
                        //交易密码初始化为登录密码
                        user.setIsActive(Integer.valueOf(AppUtil.getServletContext().getAttribute("ACTIVATION").toString()));  //系统设置的激活状态   1是 0否
                        if (Short.valueOf(AppUtil.getServletContext().getAttribute("LOCK").toString()) == 1) {   //系统设置的锁定状态 1锁定 0未锁定
                            user.setLoginPwdErrCount(Integer.valueOf(AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString()));

                        } else {
                            user.setLoginPwdErrCount(0);
                        }
                        user.setIsLock(Integer.valueOf(AppUtil.getServletContext().getAttribute("LOCK").toString()));
                        user.setGender("");
                        user.setAge(0);
                        user.setEdu("");
                        user.setSchool("");
                        user.setChecker((long) 0);
                        user.setIsLeader(0);
                        user.setIsAskPrice(0);
                        user.setAskTimes(0);
                        user.setIsDel(0);
                        user.setIsCheck(0);
                        user.setIsRecommended(0);
                        user.setProvincesId(0L);
                        user.setCityId(0L);
                        user.setLoginCount(0);  //累计登录次数
                        user.setTradingPwdErrCount(0);
                        user.setRemarks("");
                        user.setPersonalAddress("");
                        if ("1".equals(groupId)) {   //创业者
                            user.setProvincesId(0L);
                            user.setIsCompany(0);
                            user.setCityId(0L);
                            user.setContactName("");
                            user.setBusinessLicense("");
                        } else {
                            //统一按照个人投资处理
                            user.setIsCompany(0);
                            user.setContactName("");
                            user.setBusinessLicense("");
                        }
                        tUserDao.add(user);    //保存注册会员到数据库
                        user = tUserDao.getUserByLoginName(user.getLoginName());
                        //添加usersafe
                        TUserSafe userSafe = new TUserSafe();
                        userSafe.setSafeId(UniqueIdUtil.genId());
                        userSafe.setUserId(userIdreg);
                        userSafe.setEmail(email);
                        userSafe.setMobile(mobile);
                        userSafe.setIdNo(idNumber);
                        tUserSafeDao.saveUserSafe(userSafe);

                        TUserFunds tuserFunds = new TUserFunds();
                        tuserFunds.setFundsId(UniqueIdUtil.genId());
                        tuserFunds.setUserId(userIdreg);
                        tuserFunds.setLimitMaxIn(BigDecimal.valueOf(Long.valueOf(AppUtil.getServletContext().getAttribute("LIMIT_MAX_IN").toString())));  //系统设置借入额度
                        tuserFunds.setLimitMaxOut(BigDecimal.valueOf(Long.valueOf(AppUtil.getServletContext().getAttribute("LIMIT_MAX_OUT").toString())));//系统设置借出额度
                        tuserFunds.setBalance(BigDecimal.valueOf(0));
                        tuserFunds.setFreeze(BigDecimal.valueOf(0));
                        tuserFunds.setAvailable(BigDecimal.valueOf(0));
                        tuserFunds.setFundsIn(BigDecimal.valueOf(0));
                        tuserFunds.setFundsOut(BigDecimal.valueOf(0));
                        tuserFunds.setCreditIn(0);
                        tuserFunds.setCreditOut(0);
                        tuserFunds.setPayMark("");
                        tuserFundsDao.add(tuserFunds);

                    }
                }
            }
        }

        return "success";
    }
    /**
     * 取得所有认筹投资人信息
     *
     * @return
     */
    public List<TUser> getAllASKInvestorList(QueryFilter filter) {
        return tUserDao.getAllASKInvestorList(filter);
    }
}
