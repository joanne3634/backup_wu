package com.deelon.loan.controller.front;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.net.nt.NTAdapter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.encrypt.EncryptUtil;
import com.deelon.core.util.MailCommon;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.servlet.ValidCode;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.loan.dao.front.TUserCheckcodeDao;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserCheckcode;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.sysManager.TUserMobileChange;
import com.deelon.loan.model.sysManager.Temailinformation;
import com.deelon.loan.model.sysManager.TsettingsEmail;
import com.deelon.loan.model.sysManager.TsettingsSms;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.sysManager.SmsSendService;
import com.deelon.loan.service.sysManager.TUserMobileChangeService;
import com.deelon.loan.service.sysManager.TemailinformationService;
import com.deelon.loan.service.sysManager.TsettingsEmailService;
import com.deelon.loan.service.sysManager.TsettingsSmsService;
import com.deelon.loan.service.sysManager.TsmsinformationService;
import com.deelon.loan.util.MD5Util;
import com.deelon.loan.util.SendEmailUtil;
import com.ibm.db2.jcc.am.re;

@Controller
@RequestMapping({ "/safe/" })
public class SafeController {

	@Autowired
	private UserInfoService userInfoService;

	@Autowired
	private TuserSafeService userSafeService;

	@Autowired
	private TUserService tUserService;
	@Resource
	private TsettingsSmsService tsettingsSmsService;
	@Resource
	private TsettingsEmailService tsettingsEmailService;
	@Resource
	private TemailinformationService temailinformationService;
	@Resource
	private TsmsinformationService tsmsinformationService;
	@Resource
	private SmsSendService smsSendService;
	@Resource
	private TUserCheckcodeDao tUserCheckcodeDao;
	@Autowired
	private TUserMobileChangeService tuserMobileChangeService;

	private static Logger logger = LoggerFactory.getLogger(TUserService.class);

	/**
	 * 设置安全问题
	 * 
	 * @param request
	 * @param response
	 * @param a1
	 *            a2 a3 q1 q2 q3
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "fillSafeQuestion" })
	@ResponseBody
	public String fillSafeQuestion(HttpServletRequest request,
			HttpServletResponse response, String q1, String a1, String q2,
			String a2, String q3, String a3) throws Exception {

		if (TUserUtil.getLogUser(request) == null) {
			// return "登录已失效，请重新登录";
			logger.info("登录已失效，");
			response.sendRedirect(request.getContextPath() + "/index-web.jsp"); // 登录已失效，请重新登录
		}
		long userId = TUserUtil.getLogUser(request).getUserId();
		String flag = request.getParameter("flag");
		if ("change".equals(flag)) {
			TUserSafe userSafe = userInfoService.getUserSafe(userId);
			String sa1 = userSafe.getA1();
			String sa2 = userSafe.getA2();
			String sa3 = userSafe.getA3();
			if (sa1.equals(EncryptUtil.encryptMd5(a1))
					&& sa2.equals(EncryptUtil.encryptMd5(a2))
					&& sa3.equals(EncryptUtil.encryptMd5(a3))) {
				userSafe.setQ1("");
				userSafe.setQ2("");
				userSafe.setQ3("");
				userSafe.setA1("");
				userSafe.setA2("");
				userSafe.setA3("");
				userSafeService.updateUserSafeSecurityByUserId(userSafe);
				return "1";
			} else {
				return "2";
			}

		} else {
			userInfoService.saveSafeQuestion(userId, q1, a1, q2, a2, q3, a3);
			return "0";
		}
	}

	/**
	 * 安全问题页面跳转
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "safeQuestionInit" })
	public ModelAndView safeQuestionInit(HttpServletRequest request) {
		long userId = TUserUtil.getLogUser(request).getUserId();
		TUserSafe userSafe = userInfoService.getUserSafe(userId);
		if (null == userSafe)
			return null;
		// 回答正确原有问题后，跳转到重置页面
		String flag = request.getParameter("flag");
		if ("old".equals(flag)) {
			return new ModelAndView("/loan/front/securityQuestion.jsp")
					.addObject("userSafe", userSafe);
		}
		// 如果已设置安全问题，则跳转到已设置页面
		if (!"".equals(userSafe.getQ1()))
			return new ModelAndView("/loan/front/securityQuestioned.jsp")
					.addObject("userSafe", userSafe);
		else
			return new ModelAndView("/loan/front/securityQuestion.jsp")
					.addObject("userSafe", userSafe);
	}

	/**
	 * 填写原来的安全问题答案，填写成功后提交，可重新设置安全问题
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "safeQuestionChange" })
	public ModelAndView safeQuestionChange(HttpServletRequest request) {
		long userId = TUserUtil.getLogUser(request).getUserId();
		TUserSafe userSafe = userInfoService.getUserSafe(userId);
		if (null == userSafe)
			return new ModelAndView("/loan/front/securityQuestion.jsp");
		return new ModelAndView("/loan/front/securityQuestionChange.jsp")
				.addObject("userSafe", userSafe);
	}

	/**
	 * 点击链接发送邮件，填写验证码，提交后重置安全问题
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "safeQuestionReset" })
	public ModelAndView safeQuestionReset(HttpServletRequest request) {
		long userId = TUserUtil.getLogUser(request).getUserId();
		TUserSafe userSafe = userInfoService.getUserSafe(userId);
		if (null == userSafe)
			return new ModelAndView("/loan/myAccount/bindEmail.jsp").addObject(
					"error", "未绑定邮箱，请先绑定邮箱！");
		if (!StringUtil.isEmpty(userSafe.getEmail())
				&& 1 == userSafe.getBindEmail())
			return new ModelAndView("/loan/front/securityQuestionReset.jsp");
		return new ModelAndView("/loan/myAccount/bindEmail.jsp").addObject(
				"error", "未绑定邮箱，请先绑定邮箱！");
	}

	/**
	 * 点击链接跳转发送邮件页面，填写验证码，提交后重置安全问题
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "safeQuestionResetPage" })
	public ModelAndView safeQuestionResetPage(HttpServletRequest request) {
		return new ModelAndView("/loan/front/securityQuestionReset.jsp");
	}

	/**
	 * 向手机发送验证码(绑定，修改手机验证码)
	 * 
	 * @param request
	 * @param response
	 * @return 验证码信息（“验证码已发送，请查收”或者“验证码发送失败”或者“验证码发送失败，请重发”）
	 * @throws IOException
	 */
	@RequestMapping({ "sendPhoneValiCode" })
	@ResponseBody
	public String sendPhoneValiCode(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// PrintWriter out = response.getWriter();
		String phone = request.getParameter("phone"); // 接收发送验证码的手机
		String phoneFlag = request.getParameter("phoneFlag"); // 判断是绑定还是修改的标识
																// phoneFlag=null
																// 初次绑定
																// phoneFlag=“changephone”修改手机号
		TUser user = getSessionUser(request); // 当前用户
		if (user == null) {
			logger.info("登录失效");
		}
		try {
			if ("changephone".equals(phoneFlag)) { // /修改手机先验证是否输入原手机正确
				TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
						.getUserId()); // 根据当前获取到用户的绑定手机号
				if (userSafe != null) {
					if (!userSafe.getMobile().equals(phone)) { // 判断输入的原手机号是否匹配
						return "0"; // 输入错误手机号码标识
					}
				}
			}
			String code = String.valueOf(100000 + new Random().nextInt(100000));
			logger.debug("手机验证码: " + code);
			// 发送验证码到短信开始
			String content = "尊敬的会员您好，您的手机验证码：" + code
					+ ",为了保证用户安全,请勿将信息泄漏【无忧筹众筹平台】";
			String[] str = smsSendService.getSendSmsInfoResult(phone, content,
					"", "P");
			// 发送短信结束

			// 保存验证码开始
			TUserCheckcode uck = new TUserCheckcode(); // 保存验证码实体类
			uck.setCheckCodeId(UniqueIdUtil.genId()); // 验证记录ID
			uck.setUserId(user.getUserId()); // 用户ID
			uck.setCheckCodeId(UniqueIdUtil.genId()); // 验证记录ID
			uck.setCheckCode(code); // 验证码
			uck.setFromObj(phone); // 手机号码
			uck.setTypeId("1"); // 类型：1短信 2邮件
			uck.setCreateTime(new Date()); // 生成验证码时间
			if ("0".equals(str[0])) {
				uck.setIsHaveSend((short) 1);// 成功状态
			} else {
				uck.setIsHaveSend((short) 0);// 失败状态
			}
			uck.setIsHaveSend((short) 1); // 是否已经发送 0未发送 1已发送
			uck.setIsPass((short) 0); // 验证通过
			tUserCheckcodeDao.add(uck);
			// 保存验证码结束

			// 保存发送短信记录开始
			Tsmsinformation tsmsinformation = new Tsmsinformation();
			tsmsinformation.setInfoId(UniqueIdUtil.genId());// 消息ID
			tsmsinformation.setServiceType(1); // 通知类型（1=网站、2=系统、3=APP）
			tsmsinformation.setMobileNum(phone);// 手机号码
			tsmsinformation.setMessasge(content);// 短信内容
			tsmsinformation.setCreator(user.getUserId());// 创建人ID
			tsmsinformation.setCreateTime(new Date());// 创建时间
			if ("0".equals(str[0])) {
				tsmsinformation.setStatus(2);// 成功状态
			} else {
				tsmsinformation.setStatus(3);// 失败状态
			}
			tsmsinformation.setSendTime(new Date());// 发送时间
			tsmsinformationService.add(tsmsinformation);
			// 保存发送短信记录结束

			if ("0".equals(str[0])) {
				return "验证码已发送，请查收";
			}

			// return
			// userInfoService.sendbindMobileCode(user.getUserId(),phone,phoneFlag,request);
		} catch (Exception e) {
			logger.error(String.format("{%d}向手机发送验证码失败", user.getUserId()));
			return "验证码发送失败";
		}
		return "验证码发送失败，请重发";

	}

	/**
	 * 验证修改手机的验证是否正确.........正确就跳转页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "ValichangephoneCode" })
	public ModelAndView ValichangephoneCode(HttpServletRequest request,
			HttpServletResponse response) {

		String code = request.getParameter("code"); // 验证码
		String phone = request.getParameter("phone");
		String phoneM = phone.replace(phone.substring(3, 7), "****"); // 中间4位号码以加密的形式显示

		TUser user = TUserUtil.getLogUser(request);

		if ("".equals(code)) {
			return new ModelAndView("/loan/myAccount/xiugaibangdingshouji.jsp")
					.addObject("mobile", phoneM).addObject("error", "请输入验证码");
		}

		// 验证验证码是否正确
		QueryFilter query = new QueryFilter();
		query.addFilter("checkCode", code);
		query.addFilter("userId", user.getUserId());
		query.addFilter("isPass", 0);
		List list = tUserCheckcodeDao.getAll(query);

		// 成功后跳转页面
		if (list.size() > 0) {
			TUserCheckcode uck = (TUserCheckcode) list.get(0);
			uck.setIsPass((short) 1);
			tUserCheckcodeDao.update(uck);
			return new ModelAndView("/loan/myAccount/changebindPhone.jsp")
					.addObject("mobile", phoneM);
		} else {// 验证码不正确，跳转页面
			return new ModelAndView("/loan/myAccount/xiugaibangdingshouji.jsp")
					.addObject("mobile", phoneM).addObject("error", "验证码输入有误");
		}

		// String sysCode = (String)
		// request.getSession().getAttribute("change_PHONE_CODE"); //修改手机的验证码
		// if( sysCode == null){
		// return new
		// ModelAndView("/loan/myAccount/xiugaibangdingshouji.jsp").addObject("mobile",
		// phoneM).addObject("error", "未获取验证码");
		// }

		// if(!sysCode.equals(code)){
		// 验证码不正确，跳转当前页面
		// return new
		// ModelAndView("/loan/myAccount/xiugaibangdingshouji.jsp").addObject("mobile",
		// phoneM).addObject("error", "验证码输入有误");
		// }

	}

	/**
	 * 验证修改邮箱的验证是否正确.........正确就跳转页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "ValichangeEmailCode" })
	public ModelAndView ValichangeEmailCode(HttpServletRequest request,
			HttpServletResponse response) {

		String code = request.getParameter("code"); // 验证码
		String email = request.getParameter("email");
		TUser user = TUserUtil.getLogUser(request);

		// String sysCode = (String)
		// request.getSession().getAttribute("CHANGE_EMAIL_CODE"); //修改邮箱的验证码
		// if( sysCode == null){
		// return new
		// ModelAndView("/loan/myAccount/bindUpdateEmail.jsp").addObject("email",
		// userSafe.getEmail()).addObject("error", "请点击获取验证码");
		// }
		try {
			TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
					.getUserId());

			if ("".equals(code)) {
				return new ModelAndView("/loan/myAccount/bindUpdateEmail.jsp")
						.addObject("email", userSafe.getEmail()).addObject(
								"error", "请输入验证码");
			}

			if (!userSafe.getEmail().equals(email)) {
				return new ModelAndView("/loan/myAccount/bindUpdateEmail.jsp")
						.addObject("email", userSafe.getEmail()).addObject(
								"error", "请输入正确的绑定邮箱");
			}

			// 验证验证码是否正确
			QueryFilter query = new QueryFilter();
			query.addFilter("checkCode", code);
			query.addFilter("userId", user.getUserId());
			query.addFilter("isPass", 0);
			List list = tUserCheckcodeDao.getAll(query);

			// 成功后跳转页面
			if (list.size() > 0) {
				TUserCheckcode uck = (TUserCheckcode) list.get(0);
				uck.setIsPass((short) 1);
				tUserCheckcodeDao.update(uck);
				request.getSession().setAttribute("updateEmailCode",
						EncryptUtil.encryptSha256(code));
				return new ModelAndView("/loan/myAccount/changebindEmail.jsp")
						.addObject("email", email).addObject("updateEmailCode",
								EncryptUtil.encryptSha256(code));
			} else {// 验证码不正确，跳转页面
				return new ModelAndView("/loan/myAccount/bindUpdateEmail.jsp")
						.addObject("email", email)
						.addObject("error", "验证码输入有误");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ModelAndView("/loan/myAccount/bindUpdateEmail.jsp")
				.addObject("email", email);

	}

	/**
	 * 验证绑定手机验证码输入是否正确
	 * 
	 * @param request
	 * @param response
	 * @param mobileCode
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validatePhoneCode" })
	@ResponseBody
	public String validatePhoneCode(HttpServletRequest request,
			HttpServletResponse response, String mobileCode) throws IOException {
		String code = request.getParameter("code"); // 手机验证码
		// String validCode = request.getParameter("validCode"); ///随机验证码
		// String password = request.getParameter("loginPwd"); //登录密码
		String phone = request.getParameter("phone"); // 手机号
		TUser user = getSessionUser(request);
		// PrintWriter out = response.getWriter();

		if (user == null) {
			logger.info("登录失效");
		}

		// String bgvalidCode =
		// (String)request.getSession().getAttribute(ValidCode.SessionName_Randcode);
		// if ((bgvalidCode == null) ||
		// (org.apache.commons.lang.StringUtils.isEmpty(validCode)) ||
		// (!bgvalidCode.equals(validCode)))
		// {
		// logger.info("验证码输入有错");
		// return "验证码输入有错";
		// }

		// if (userInfoService.validatePassword(user.getUserId(), password)) {
		// logger.error(String.format("{%d}登陆密码错误", user.getUserId()));
		// return "登陆密码错误";
		// }
		if ("".equals(code)) {
			return "请输入验证码";
		}

		try {
			TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
					.getUserId());

			// 验证验证码是否正确
			QueryFilter query = new QueryFilter();
			query.addFilter("checkCode", code);
			query.addFilter("userId", user.getUserId());
			query.addFilter("isPass", 0);
			List list = tUserCheckcodeDao.getAll(query);

			if (list.size() > 0) { // 表示验证码正确
				TUserCheckcode uck = (TUserCheckcode) list.get(0);
				TUserMobileChange tUserMobileChange = new TUserMobileChange();
				tUserMobileChange.setMobileChangeid(UniqueIdUtil.genId());
				tUserMobileChange.setMobileOld(userSafe.getMobile());
				tUserMobileChange.setMobileNew(phone);
				tUserMobileChange.setCreateTime(new Date());
				tUserMobileChange.setUserId(user.getUserId());
				tuserMobileChangeService.add(tUserMobileChange);

				uck.setIsPass((short) 1);
				tUserCheckcodeDao.update(uck);

				userSafe.setBindMobile((short) 1);
				userSafe.setMobile(phone);
				userSafeService.update(userSafe);
				logger.debug("绑定手机成功");
				return "0";
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "手机验证码输入有误";
	}

	/**
	 * 根据原邮箱获取验证码修改绑定手机.........正确就跳转页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "ValichangephoneWheresfEmail" })
	public ModelAndView ValichangephoneWheresfEmail(HttpServletRequest request,
			HttpServletResponse response) {

		String code = request.getParameter("code"); // 验证码
		// String mobile = request.getParameter("mobile");
		// String email = request.getParameter("email");
		// String idNo = request.getParameter("idNo");
		TUser user = getSessionUser(request);
		TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
				.getUserId());
		String phoneM = userSafe.getMobile().replace(
				userSafe.getMobile().substring(3, 7), "****"); // 中间4位号码以加密的形式显示
		try {

			if ("".equals(code)) {
				return new ModelAndView(
						"/loan/myAccount/xiugaibangdingshouji.jsp").addObject(
						"mobile", phoneM).addObject("error", "请输入验证码");
			}

			// 验证验证码是否正确
			QueryFilter query = new QueryFilter();
			query.addFilter("checkCode", code);
			query.addFilter("userId", user.getUserId());
			query.addFilter("isPass", 0);
			List list = tUserCheckcodeDao.getAll(query);

			// 成功后跳转页面
			if (list.size() > 0) {
				TUserCheckcode uck = (TUserCheckcode) list.get(0);
				uck.setIsPass((short) 1);
				tUserCheckcodeDao.update(uck);
				return new ModelAndView("/loan/myAccount/changebindPhone.jsp")
						.addObject("mobile", phoneM);
			} else {// 验证码不正确，跳转页面
				return new ModelAndView(
						"/loan/myAccount/xiugaibangdingshouji.jsp").addObject(
						"mobile", phoneM).addObject("error", "验证码输入有误");
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ModelAndView("/loan/myAccount/xiugaibangdingshouji.jsp")
				.addObject("mobile", phoneM);
	}

	/**
	 * 根据原手机获取验证码修改绑定邮箱........正确就跳转页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "ValichangeemailWheresfEmail" })
	public ModelAndView ValichangeemailWheresfEmail(HttpServletRequest request,
			HttpServletResponse response) {

		String code = request.getParameter("code"); // 验证码
		// String phone = request.getParameter("phone");

		// String phoneM = phone.replace(phone.substring(3, 7), "****");
		// //中间4位号码以加密的形式显示
		// sysCode = (String)
		// request.getSession().getAttribute("CHEANGEMAIL_PHONE_CODE");
		// //原邮箱修改绑定手机的验证码

		// if(sysCode == null){
		// return new
		// ModelAndView("/loan/myAccount/bindUpdateEmail.jsp").addObject("email",
		// email).addObject("error", "请点击获取验证码").addObject("biaoshi",
		// "biaoshi");
		// }

		try {
			TUser user = getSessionUser(request);
			TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
					.getUserId());

			if ("".equals(code)) {
				return new ModelAndView("/loan/myAccount/bindUpdateEmail.jsp")
						.addObject("email", userSafe.getEmail()).addObject(
								"error", "请输入验证码");
			}

			// 验证验证码是否正确
			QueryFilter query = new QueryFilter();
			query.addFilter("checkCode", code);
			query.addFilter("userId", user.getUserId());
			query.addFilter("isPass", 0);
			List list = tUserCheckcodeDao.getAll(query);

			// 成功后跳转页面
			if (list.size() > 0) {
				TUserCheckcode uck = (TUserCheckcode) list.get(0);
				uck.setIsPass((short) 1);
				tUserCheckcodeDao.update(uck);
				return new ModelAndView("/loan/myAccount/changebindEmail.jsp");
			} else {// 验证码不正确，跳转页面
				return new ModelAndView("/loan/myAccount/bindUpdateEmail.jsp")
						.addObject("email", userSafe.getEmail()).addObject(
								"error", "验证码输入有误");
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ModelAndView("/loan/myAccount/bindUpdateEmail.jsp");

	}

	/**
	 * 向邮箱发送验证码(通过邮箱发送验证码重置手机号码)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "sendEmailResetPhoneValiCode" })
	@ResponseBody
	public String sendEmailResetPhoneValiCode(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// PrintWriter out = response.getWriter();
		String email = request.getParameter("email"); // 绑定邮箱
		// String emailFlag = request.getParameter("emailFlag");
		String idNo = request.getParameter("idNo"); // 身份证号
		TUser user = getSessionUser(request);
		if (user == null) {
			logger.info("登录失效");
			// response.sendRedirect(request.getContextPath() +
			// "/index-web.jsp");
		}
		try {
			TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
					.getUserId());
			if (userSafe != null) {
				if (!userSafe.getIdNo().equals(idNo)) {
					return "请输入正确的绑定身份证号";
				} else if (userSafe.getBindIdNo() != 1) {
					return "该身份证号未绑定";
				}
				if (!userSafe.getEmail().equals(email)) { // 判断和绑定邮箱是否匹配
					return "请输入正确的绑定邮箱";
				} else if (userSafe.getBindEmail() != 1) {
					return "该邮箱未绑定";
				}
			}

			// TODO 向邮箱发送验证码
			String code = String.valueOf(100000 + new Random().nextInt(100000));
			String htmlbody = "尊敬的会员您好，您的邮箱验证码：" + code
					+ ",为了保证用户安全,请勿将信息泄漏【无忧筹众筹平台】";
			boolean issucceed = SendEmailUtil.sendEmail(email, "邮箱验证码",
					htmlbody); // 发送邮件
			logger.debug("邮箱验证码: " + code);

			TUserCheckcode uck = new TUserCheckcode();
			uck.setCheckCodeId(UniqueIdUtil.genId());
			uck.setCheckCode(code);
			uck.setFromObj(email);
			uck.setTypeId("2");
			uck.setCreateTime(new Date());
			uck.setIsHaveSend((short) 1);
			uck.setUserId(user.getUserId());
			uck.setIsPass((short) 0);
			tUserCheckcodeDao.add(uck); // 保存发送记录

			Temailinformation emailinformation = new Temailinformation();
			emailinformation.setInfoId(UniqueIdUtil.genId());
			emailinformation.setServiceType(1);
			emailinformation.setEmailAddr(email);
			emailinformation.setHeader("邮箱");
			emailinformation.setMessasge(htmlbody);
			if (issucceed) {
				emailinformation.setStatus(2); // 成功
			} else {
				emailinformation.setStatus(3); // 失败
			}
			emailinformation.setCreator(user.getUserId());
			emailinformation.setCreateTime(new Date());
			temailinformationService.add(emailinformation);

			if (issucceed) {
				return "1"; // 验证已发送的标识
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return "0"; // 验证码失败的标识
	}

	/**
	 * 向手机发送验证码(通过手机发送验证码重置邮箱)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "sendEmailResetEmailValiCode" })
	@ResponseBody
	public String sendEmailResetEmailValiCode(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// PrintWriter out = response.getWriter();
		String phone = request.getParameter("phone"); // 绑定手机
		// String phoneFlag = request.getParameter("phoneFlag");
		String idNo = request.getParameter("idNo"); // 身份证号
		TUser user = getSessionUser(request);
		if (user == null) {
			logger.info("登录失效");
			// response.sendRedirect(request.getContextPath() +
			// "/index-web.jsp");
		}
		try {
			TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
					.getUserId());
			if (userSafe != null) {
				if (!userSafe.getIdNo().equals(idNo)) {
					return "请输入正确的绑定身份证号";
				} else if (userSafe.getBindIdNo() != 1) {
					return "该身份证号未绑定";
				}
				if (!userSafe.getMobile().equals(phone)) { // 判断和绑定手机是否匹配
					return "请输入正确的绑定手机";
				} else if (userSafe.getBindMobile() != 1) {
					return "该手机号未绑定";
				}
			}
			// TODO 向邮箱发送验证码
			String code = String.valueOf(100000 + new Random().nextInt(100000));
			String content = "尊敬的会员您好，您的手机验证码：" + code
					+ ",为了保证用户安全,请勿将信息泄漏【无忧筹众筹平台】";
			String[] str = smsSendService.getSendSmsInfoResult(phone, content,
					"", "p");
			logger.debug("手机验证码: " + code);
			// return userInfoService.sendbindEmailCode(user.getUserId(),email);
			TUserCheckcode uck = new TUserCheckcode();
			uck.setCheckCodeId(UniqueIdUtil.genId());
			uck.setCheckCode(code);
			uck.setFromObj(phone);
			uck.setTypeId("1");
			uck.setCreateTime(new Date());
			if ("0".equals(str[0])) {
				uck.setIsHaveSend((short) 1);// 成功状态
			} else {
				uck.setIsHaveSend((short) 0);// 失败状态
			}
			uck.setUserId(user.getUserId());
			uck.setIsPass((short) 0);
			tUserCheckcodeDao.add(uck); // 保存发送记录

			Tsmsinformation tsmsinformation = new Tsmsinformation();
			tsmsinformation.setInfoId(UniqueIdUtil.genId());
			tsmsinformation.setServiceType(1);
			tsmsinformation.setMobileNum(phone);
			tsmsinformation.setMessasge(content);
			tsmsinformation.setCreator(user.getUserId());
			tsmsinformation.setCreateTime(new Date());
			if ("0".equals(str[0])) {
				tsmsinformation.setStatus(2);// 成功状态
			} else {
				tsmsinformation.setStatus(3);// 失败状态
			}
			tsmsinformation.setSendTime(new Date());
			tsmsinformationService.add(tsmsinformation);

			if ("0".equals(str[0])) {
				return "1"; // 发送成功标识
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return "0"; // 发送失败标识
	}

	/**
	 * 向邮箱发送验证码(绑定，修改邮箱)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "sendEmailValiCode" })
	@ResponseBody
	public String sendEmailValiCode(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// PrintWriter out = response.getWriter();
		String email = request.getParameter("email"); // 绑定邮箱
		String emailFlag = request.getParameter("emailFlag");// 此标识是否是修改操作(等于changeEmail)
																// 否则就是绑定
		TUser user = getSessionUser(request);
		if (user == null) {
			logger.info("登录失效");
			// response.sendRedirect(request.getContextPath() +
			// "/index-web.jsp");
		}
		try {

			if ("changeEmail".equals(emailFlag)) { // /修改邮箱先验证是否输入原邮箱正确
				TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
						.getUserId()); // 根据当前获取到用户的绑定邮箱
				if (userSafe != null) {
					if (!userSafe.getEmail().equals(email)) { // 判断输入的原邮箱是否匹配
						return "0"; // 输入错误邮箱标识
					}
				}
			}

			String code = String.valueOf(100000 + new Random().nextInt(100000));
			// 发送邮件开始
			String htmlbody = "尊敬的会员您好，您的邮箱验证码：" + code
					+ ",为了保证用户安全,请勿将信息泄漏【无忧筹众筹平台】";
			boolean issucceed = SendEmailUtil.sendEmail(email, "邮箱验证码",
					htmlbody); // 发送邮件
			// 发送邮件结束
			logger.debug("邮箱验证码: " + code);
			// return userInfoService.sendbindEmailCode(user.getUserId(),email);

			// 保存验证码
			TUserCheckcode uck = new TUserCheckcode();
			uck.setCheckCodeId(UniqueIdUtil.genId());
			uck.setCheckCode(code);
			uck.setFromObj(email);
			uck.setTypeId("2");
			uck.setCreateTime(new Date());
			if (issucceed) {
				uck.setIsHaveSend((short) 1); // 成功
			} else {
				uck.setIsHaveSend((short) 0); // 失败
			}
			uck.setUserId(user.getUserId());
			uck.setIsPass((short) 0);
			tUserCheckcodeDao.add(uck); // 保存发送记录

			// 保存发送邮件的信息记录
			Temailinformation emailinformation = new Temailinformation();
			emailinformation.setInfoId(UniqueIdUtil.genId());
			emailinformation.setServiceType(1); // 通知类型（1=网站、2=系统、3=APP）
			emailinformation.setEmailAddr(email);
			emailinformation.setHeader("邮箱");
			emailinformation.setMessasge(htmlbody);
			if (issucceed) {
				emailinformation.setStatus(2); // 成功
			} else {
				emailinformation.setStatus(3); // 失败
			}
			emailinformation.setCreator(user.getUserId());
			emailinformation.setCreateTime(new Date());
			temailinformationService.add(emailinformation);

			if (issucceed) {
				return "验证码已发送，请查收"; // 成功
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return "验证码发送失败，请重试";
	}

	/**
	 * 验证邮箱验证码输入是否正确
	 * 
	 * @param request
	 * @param response
	 * @param mobileCode
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validateEmailCode" })
	@ResponseBody
	public String validateEmailCode(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String code = request.getParameter("code"); // 邮箱验证码

		String email = request.getParameter("email");
		TUser user = getSessionUser(request);

		if (user == null) {
			logger.info("登录失效");
			// response.sendRedirect(request.getContextPath() +
			// "/index-web.jsp");
		}

		if ("".equals(code)) {
			return "请输入验证码";
		}

		try {
			TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
					.getUserId());
			// 验证验证码是否正确
			QueryFilter query = new QueryFilter();
			query.addFilter("checkCode", code);
			query.addFilter("userId", user.getUserId());
			query.addFilter("isPass", 0);
			List list = tUserCheckcodeDao.getAll(query);

			if (list.size() > 0) { // 表示验证码正确
				TUserCheckcode uck = (TUserCheckcode) list.get(0);
				uck.setIsPass((short) 1);
				tUserCheckcodeDao.update(uck);

				userSafe.setBindEmail((short) 1);
				userSafe.setEmail(email);
				userSafeService.update(userSafe);
				logger.debug("绑定邮箱成功");
				return "0";
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "邮箱验证码输入有误";
	}

	/**
	 * 验证邮箱验证码输入是否正确 安全问题中，验证邮箱验证码
	 * 
	 * @param request
	 * @param response
	 * @param mobileCode
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validateSingleEmailCode" })
	public ModelAndView validateSingleEmailCode(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String emailcode = request.getParameter("code"); // 邮箱验证码
		String email = request.getParameter("email");
		TUser user = getSessionUser(request);

		if (user == null) {
			logger.info("登录失效");
			response.sendRedirect(request.getContextPath() + "/index-web.jsp");
		}

		try {
			TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
					.getUserId());

			if ("".equals(emailcode)) {
				return new ModelAndView("/loan/front/securityQuestionReset.jsp")
						.addObject("email", userSafe.getEmail()).addObject(
								"error", "请输入验证码");
			}

			if (!userSafe.getEmail().equals(email)) {
				return new ModelAndView("/loan/front/securityQuestionReset.jsp")
						.addObject("email", userSafe.getEmail()).addObject(
								"error", "请输入正确的绑定邮箱");
			}

			if (userInfoService.validateEmailCode(user.getUserId(), emailcode,
					email, request)) {
				// TUserSafe userSafe =
				// userInfoService.getUserSafe(user.getUserId());
				userSafe.setQ1("");
				userSafe.setQ2("");
				userSafe.setQ3("");
				userSafe.setA1("");
				userSafe.setA2("");
				userSafe.setA3("");
				userSafeService.updateUserSafeSecurityByUserId(userSafe);
				logger.debug("安全问题重置成功");
				return new ModelAndView(
						"redirect:/safe/safeQuestionInit.ht?flag=old");
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ModelAndView("/loan/front/securityQuestionReset.jsp")
				.addObject("error", "邮箱验证码输入有误");
	}

	/**
	 * 验证绑定邮箱(并向邮箱发送验证)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "valiBindEmail" })
	public ModelAndView valiBindEmail(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// PrintWriter out = response.getWriter();
		// TUser user = getSessionUser(request);
		String email = request.getParameter("email");
		String velicode = request.getParameter("code");
		String validCode = (String) request.getSession().getAttribute(
				ValidCode.getSessionName_Randcode());

		if (email == null) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}

		if ((validCode == null)
				|| (org.apache.commons.lang.StringUtils.isEmpty(velicode))
				|| (!validCode.equalsIgnoreCase(velicode))) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp")
					.addObject("yxzh-btn", "yxzh-btn").addObject("error",
							"验证码输入有误");

		}

		try {

			TUserSafe userSafe = userSafeService.valiTUserSafeByEmail(email);
			if (userSafe == null) {
				return new ModelAndView("/loan/myAccount/wangjimima.jsp")
						.addObject("error", "该邮箱没有绑定用户名");
			}
			String code = String.valueOf(100000 + new Random().nextInt(100000)); // 向邮箱地址发送的验证码
			logger.debug("邮箱地址验证码: " + code);
			String htmlbody = "尊敬的会员您好，您的邮箱验证码：" + code
					+ ",为了保证用户安全,请勿将信息泄漏【无忧筹众筹平台】";
			boolean issucceed = SendEmailUtil.sendEmail(email, "邮箱验证码",
					htmlbody); // 发送邮件

			TUserCheckcode uck = new TUserCheckcode();
			uck.setCheckCodeId(UniqueIdUtil.genId());
			uck.setCheckCode(code);
			uck.setFromObj(email);
			uck.setTypeId("2");
			uck.setCreateTime(new Date());
			if (issucceed) {
				uck.setIsHaveSend((short) 1); // 成功
			} else {
				uck.setIsHaveSend((short) 0); // 失败
			}
			uck.setUserId(userSafe.getUserId());
			uck.setIsPass((short) 0);
			tUserCheckcodeDao.add(uck); // /保存发送验证码记录

			Temailinformation emailinformation = new Temailinformation();
			emailinformation.setInfoId(UniqueIdUtil.genId());
			emailinformation.setServiceType(1);
			emailinformation.setEmailAddr(email);
			emailinformation.setHeader("邮箱");
			emailinformation.setMessasge(htmlbody);
			if (issucceed) {
				emailinformation.setStatus(2); // 成功
			} else {
				emailinformation.setStatus(3); // 失败
			}
			emailinformation.setCreator(userSafe.getUserId());
			emailinformation.setCreateTime(new Date());
			temailinformationService.add(emailinformation);

			if (issucceed) {
				return new ModelAndView("/loan/myAccount/wangjimima2-email.jsp")
						.addObject("email", email).addObject("userId",
								userSafe.getUserId());
			}

		} catch (Exception e) {
			// logger.error(String.format("{%d}向邮箱发送验证码失败", user.getUserId()));
			// return "发送失败";
			e.printStackTrace();
		}
		return new ModelAndView("/loan/myAccount/wangjimima.jsp").addObject(
				"error", "验证码发送失败，请重试");
	}

	/**
	 * 验证绑定邮箱验证码
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "valiBindEmailcode" })
	public ModelAndView valiBindEmailcode(HttpServletRequest request,
			HttpServletResponse response) {

		String code = request.getParameter("email_code");
		// String sysemailCode = (String)
		// request.getSession().getAttribute("SYS_EMAIL_CODE");
		String email = request.getParameter("email");
		String userId = request.getParameter("userId");

		try {
			if ("".equals(code)) {
				return new ModelAndView("/loan/myAccount/wangjimima2-email.jsp")
						.addObject("email", email).addObject("error", "请输入验证码");
			}

			// 验证验证码是否正确
			QueryFilter query = new QueryFilter();
			query.addFilter("checkCode", code);
			query.addFilter("userId", userId);
			query.addFilter("isPass", 0);
			List list = tUserCheckcodeDao.getAll(query);
			// 成功后跳转页面
			if (list.size() > 0) {
				TUserCheckcode uck = (TUserCheckcode) list.get(0);
				uck.setIsPass((short) 1);
				tUserCheckcodeDao.update(uck);
				request.getSession().setAttribute("resetCode",
						EncryptUtil.encryptSha256(code));
				return new ModelAndView("/loan/myAccount/wangjimima3-email.jsp")
						.addObject("email", email)
						.addObject("userId", userId)
						.addObject("resetCode", EncryptUtil.encryptSha256(code));
			} else {// 验证码不正确，跳转页面
				return new ModelAndView("/loan/myAccount/wangjimima2-email.jsp")
						.addObject("email", email)
						.addObject("error", "验证码输入有误");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ModelAndView("/loan/myAccount/wangjimima2-email.jsp")
				.addObject("email", email);
	}

	/**
	 * 邮箱重置用户登录密码
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "emailresetpass" })
	public ModelAndView emailresetpass(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String userId = request.getParameter("userId");
		String pass = request.getParameter("newPwd");
		String resetCode = request.getParameter("resetCode");
		String session_resetCode = (String) request.getSession().getAttribute(
				"resetCode");

		if (session_resetCode == null) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}

		if (!session_resetCode.equals(resetCode)) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}
		try {
			TUser user = userInfoService.getUserByUserId(Long.valueOf(userId));
			user.setLoginPwd(MD5Util.MD5(pass));
			user.setLoginPwdErrCount(0);
			tUserService.update(user);
			request.getSession().removeAttribute("resetCode");
			return new ModelAndView("/loan/myAccount/wangjimima3-email.jsp")
					.addObject("success", "密码重置成功");

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ModelAndView("/loan/myAccount/wangjimima.jsp");
	}

	/**
	 * 验证绑定手机(并向邮箱发送验证)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "valiBindPhone" })
	public ModelAndView valiBindPhone(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// PrintWriter out = response.getWriter();
		// TUser user = getSessionUser(request);
		String mobile = request.getParameter("mobile");
		String velicode = request.getParameter("code");
		String validCode = (String) request.getSession().getAttribute(
				ValidCode.getSessionName_Randcode());

		if (mobile == null) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}

		if ((validCode == null)
				|| (org.apache.commons.lang.StringUtils.isEmpty(velicode))
				|| (!validCode.equalsIgnoreCase(velicode))) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp")
					.addObject("identifying", "sjzh-btn").addObject("error",
							"验证码输入有误");

		}

		try {
			TUserSafe userSafe = userSafeService.valiTUserSafeByMobile(mobile);
			if (userSafe == null) {
				return new ModelAndView("/loan/myAccount/wangjimima.jsp")
						.addObject("mobile", mobile)
						.addObject("identifying", "sjzh-btn")
						.addObject("error", "该手机号码没有绑定用户名");
			}
			String phoneM = userSafe.getMobile().replace(
					userSafe.getMobile().substring(3, 7), "****"); // 中间4位号码以加密的形式显示
			String code = String.valueOf(100000 + new Random().nextInt(100000)); // 向手机号码发送的验证码
			String content = "尊敬的会员您好，您的手机验证码：" + code
					+ ",为了保证用户安全,请勿将信息泄漏【无忧筹众筹平台】";
			String[] str = smsSendService.getSendSmsInfoResult(mobile, content,
					"", "p");

			TUserCheckcode uck = new TUserCheckcode();
			uck.setCheckCodeId(UniqueIdUtil.genId());
			logger.debug("手机号码验证码: " + code);
			uck.setCheckCode(code);
			uck.setFromObj(mobile);
			uck.setTypeId("1");
			uck.setCreateTime(new Date());
			if ("0".equals(str[0])) {
				uck.setIsHaveSend((short) 1);// 成功状态
			} else {
				uck.setIsHaveSend((short) 0);// 失败状态
			}
			uck.setIsPass((short) 0);
			uck.setUserId(userSafe.getUserId());
			tUserCheckcodeDao.add(uck); // /保存发送验证码记录

			Tsmsinformation tsmsinformation = new Tsmsinformation();
			tsmsinformation.setInfoId(UniqueIdUtil.genId());
			tsmsinformation.setServiceType(1);
			tsmsinformation.setMobileNum(mobile);
			tsmsinformation.setMessasge(content);
			tsmsinformation.setCreator(userSafe.getUserId());
			tsmsinformation.setCreateTime(new Date());
			if ("0".equals(str[0])) {
				tsmsinformation.setStatus(2);// 成功状态
			} else {
				tsmsinformation.setStatus(3);// 失败状态
			}
			tsmsinformation.setSendTime(new Date());
			tsmsinformationService.add(tsmsinformation);

			if ("0".equals(str[0])) {
				return new ModelAndView(
						"/loan/myAccount/wangjimima2-mobile.jsp").addObject(
						"mobile", phoneM).addObject("userId",
						userSafe.getUserId());
			}
			// request.getSession().setMaxInactiveInterval(1800); //30分钟后过期

		} catch (Exception e) {
			// logger.error(String.format("{%d}向邮箱发送验证码失败", user.getUserId()));
			// return "发送失败";sss
			e.printStackTrace();
		}
		return new ModelAndView("/loan/myAccount/wangjimima.jsp").addObject(
				"error", "验证码发送失败，请重试");
	}

	/**
	 * 验证绑定手机验证码
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "valiBindMobilecode" })
	public ModelAndView valiBindMobilecode(HttpServletRequest request,
			HttpServletResponse response) {

		String code = request.getParameter("mobile_code");
		// String sysemailCode = (String)
		// request.getSession().getAttribute("SYS_MOBILE_CODE");
		String mobile = request.getParameter("mobile");
		String userId = request.getParameter("userId");

		try {

			if ("".equals(code)) {
				return new ModelAndView(
						"/loan/myAccount/wangjimima2-mobile.jsp").addObject(
						"mobile", mobile).addObject("error", "请输入验证码");
			}

			// 验证验证码是否正确
			QueryFilter query = new QueryFilter();
			query.addFilter("checkCode", code);
			query.addFilter("userId", userId);
			query.addFilter("isPass", 0);
			List list = tUserCheckcodeDao.getAll(query);
			// 成功后跳转页面
			if (list.size() > 0) {
				TUserCheckcode uck = (TUserCheckcode) list.get(0);
				uck.setIsPass((short) 1);
				tUserCheckcodeDao.update(uck);
				request.getSession().setAttribute("resetCode",
						EncryptUtil.encryptSha256(code));
				return new ModelAndView(
						"/loan/myAccount/wangjimima3-mobile.jsp").addObject(
						"userId", userId).addObject("resetCode",
						EncryptUtil.encryptSha256(code));
			} else {// 验证码不正确，跳转页面
				return new ModelAndView(
						"/loan/myAccount/wangjimima2-mobile.jsp").addObject(
						"mobile", mobile).addObject("error", "验证码输入有误");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ModelAndView("/loan/myAccount/wangjimima2-mobile.jsp")
				.addObject("mobile", mobile);
	}

	/**
	 * 手机重置用户登录密码
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "mobileresetpass" })
	public ModelAndView mobileresetpass(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		String userId = request.getParameter("userId");
		String pass = request.getParameter("newPwd");
		String resetCode = request.getParameter("resetCode");
		String session_resetCode = (String) request.getSession().getAttribute(
				"resetCode");

		if (session_resetCode == null) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}

		if (!session_resetCode.equals(resetCode)) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}

		try {
			TUser user = userInfoService.getUserByUserId(Long.valueOf(userId));
			user.setLoginPwd(MD5Util.MD5(pass));
			user.setLoginPwdErrCount(0);
			tUserService.update(user);
			request.getSession().removeAttribute("resetCode");
			return new ModelAndView("/loan/myAccount/wangjimima3-mobile.jsp")
					.addObject("success", "密码重置成功");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ModelAndView("/loan/myAccount/wangjimima.jsp");
	}

	/**
	 * 验证安全问题
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "valiBindQuesion" })
	public ModelAndView valiBindQuesion(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// PrintWriter out = response.getWriter();
		// TUser user = getSessionUser(request);
		String loginName = request.getParameter("loginName");
		String code = request.getParameter("code");
		String validCode = (String) request.getSession().getAttribute(
				ValidCode.getSessionName_Randcode());

		if (loginName == null) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}

		if ((validCode == null)
				|| (org.apache.commons.lang.StringUtils.isEmpty(code))
				|| (!validCode.equalsIgnoreCase(code))) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp")
					.addObject("loginName", loginName)
					.addObject("identifying", "mbzh-btn")
					.addObject("error", "验证码输入有误");

		}

		try {
			TUser user = userInfoService.getTUserByLoginName(loginName);

			if (user == null) {
				return new ModelAndView("/loan/myAccount/wangjimima.jsp")
						.addObject("identifying", "mbzh-btn").addObject(
								"error", "该用户名没有注册");
			}

			TUserSafe userSafe = userSafeService.valiTUserSafeByQuesion(user
					.getUserId());
			if (userSafe == null) {
				return new ModelAndView("/loan/myAccount/wangjimima.jsp")
						.addObject("error", "该用户名没有注册");
			}
			// Random random = new Random();
			// int randomNb = random.nextInt(3) + 1; //随机数，随机抽选一个安全问题提问
			return new ModelAndView("/loan/myAccount/wangjimima2-quesion.jsp")
					.addObject("userSafe", userSafe);

		} catch (Exception e) {

			e.printStackTrace();
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}

	}

	/**
	 * 验证用户名安全问题答案
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @throws IOException
	 */
	@RequestMapping({ "valiBindquesionAnswer" })
	public ModelAndView valiBindquesionAnswer(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// String randomNb = request.getParameter("randomNb"); //随机数
		String userId = request.getParameter("userId"); // 用户名Id
		String a1 = request.getParameter("a1"); // 安全问题答案1
		String a2 = request.getParameter("a2"); // 安全问题答案2
		String a3 = request.getParameter("a3"); // 安全问题答案3

		if (userId == null || a1 == null || a2 == null || a3 == null) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}
		TUserSafe userSafe = userSafeService.valiTUserSafeByQuesion(Long
				.valueOf(userId));

		if (!EncryptUtil.encryptMd5(a1).equals(userSafe.getA1())) {
			return new ModelAndView("/loan/myAccount/wangjimima2-quesion.jsp")
					.addObject("userSafe", userSafe).addObject("a2", a2)
					.addObject("a3", a3).addObject("error", "回答答案有误");
		}

		if (!EncryptUtil.encryptMd5(a2).equals(userSafe.getA2())) {
			return new ModelAndView("/loan/myAccount/wangjimima2-quesion.jsp")
					.addObject("userSafe", userSafe).addObject("a1", a1)
					.addObject("a3", a3).addObject("error", "回答答案有误");
		}

		if (!EncryptUtil.encryptMd5(a3).equals(userSafe.getA3())) {
			return new ModelAndView("/loan/myAccount/wangjimima2-quesion.jsp")
					.addObject("userSafe", userSafe).addObject("a2", a2)
					.addObject("a1", a1).addObject("error", "回答答案有误");
		}

		request.getSession().setAttribute("resetCode",
				EncryptUtil.encryptSha256(a1 + a2 + a3));
		return new ModelAndView("/loan/myAccount/wangjimima3-quesion.jsp")
				.addObject("a1", a1)
				.addObject("a2", a2)
				.addObject("a3", a3)
				.addObject("userId", userId)
				.addObject("resetCode", EncryptUtil.encryptSha256(a1 + a2 + a3));

	}

	/**
	 * 安全问题重置用户登录密码
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "quesionresetpass" })
	public ModelAndView quesionresetpass(HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		String pass = request.getParameter("newPwd");
		String userId = request.getParameter("userId");
		String resetCode = request.getParameter("resetCode");
		String session_resetCode = (String) request.getSession().getAttribute(
				"resetCode");

		if (pass == null || userId == null || session_resetCode == null) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}

		if (!session_resetCode.equals(resetCode)) {
			return new ModelAndView("/loan/myAccount/wangjimima.jsp");
		}
		try {
			TUser user = userInfoService.getUserByUserId(Long.valueOf(userId));
			if (user == null) {
				return new ModelAndView("/loan/myAccount/wangjimima.jsp");
			}
			user.setLoginPwd(MD5Util.MD5(pass));
			user.setLoginPwdErrCount(0);
			tUserService.update(user);
			request.getSession().removeAttribute("resetCode");
			return new ModelAndView("/loan/myAccount/wangjimima3-quesion.jsp")
					.addObject("success", "密码重置成功");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("/loan/myAccount/wangjimima.jsp");
	}

	/**
	 * jq验证框架 验证手机号码是否唯一
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validatePhone" })
	public void validatePhone(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		String phone = request.getParameter("phone");
		TUser user = getSessionUser(request);
		Boolean tag = userSafeService.existPhone(phone);
		if (user != null) {
			TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
					.getUserId());
			if (userSafe.getMobile().equals(phone)) {
				if (userSafe.getBindMobile() == 1) {
					tag = true;
				} else {
					tag = false;
				}

			}
		}

		PrintWriter out = response.getWriter();
		if (tag) {
			out.print("false");
		} else {
			out.print("true");
		}
	}

	/**
	 * 验证邮箱地址
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validateEmail" })
	public void validateEmail(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");
		TUser user = getSessionUser(request);
		Boolean tag = userSafeService.existEmail(email);
		if (user != null) {
			TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
					.getUserId());
			if (userSafe.getEmail().equals(email)) {
				tag = false;
			}
		}

		PrintWriter out = response.getWriter();
		if (tag) {
			out.print("false");
		} else {
			out.print("true");
		}

	}

	/**
	 * 验证绑定邮箱地址
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validateBindEmail" })
	public void validateBindEmail(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");
		TUser user = getSessionUser(request);

		TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
				.getUserId());

		Boolean tag = userSafeService.existEmail(email);
		if (userSafe.getEmail().equals(email)) {
			tag = false;
		}

		PrintWriter out = response.getWriter();
		if (tag) {
			out.print("false");
		} else {
			out.print("true");
		}

	}

	/**
	 * 验证个人邮箱地址是否存在 安全问题中，通过邮箱重置答案
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validateSingleEmail" })
	public void validateSingleEmail(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");
		TUser user = getSessionUser(request);

		TUserSafe userSafe = userSafeService.getUserSafeByUserId(user
				.getUserId());

		Boolean tag = false;
		if (userSafe.getEmail().equals(email) && userSafe.getBindEmail() == 1) {
			tag = true;
		}

		PrintWriter out = response.getWriter();
		// 判断是否是安全问题发的邮件，还是绑定邮箱发的邮件
		if (tag) {
			out.print("true");
		} else {
			out.print("false");
		}

	}

	@RequestMapping({ "wangjimimapage" })
	public ModelAndView wangjimimapage() {
		return new ModelAndView("/loan/myAccount/wangjimima.jsp");
	}

	/**
	 * 跳转至绑定或修改手机页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "bindPhone" })
	public ModelAndView bindPhone(HttpServletRequest request,
			HttpServletResponse response) {
		TUser user = (TUser) request.getSession().getAttribute("user");
		String flag = request.getParameter("flag");
		TUserSafe userSafe = null;
		if (user != null) {
			userSafe = userSafeService.getUserSafeByUserId(user.getUserId()); // 根据当前用户获取用户安全表，判断是否绑定
			if (userSafe != null) {
				if (userSafe.getBindMobile() == 1) { // 绑定手机状态为1，表示是已绑定了，跳转至修改手机页面
					String phone = userSafe.getMobile().replace(
							userSafe.getMobile().substring(3, 7), "****"); // 中间4位号码以加密的形式显示
					return new ModelAndView(
							"/loan/myAccount/xiugaibangdingshouji.jsp")
							.addObject("mobile", phone).addObject("flag", flag);
				}
			}
		}

		return new ModelAndView("/loan/myAccount/bindPhone.jsp");
	}

	/**
	 * 绑定/修改邮箱
	 * 
	 * @return
	 */
	@RequestMapping({ "bindEmail" })
	public ModelAndView bindEmail(HttpServletRequest request,
			HttpServletResponse response) {
		TUser user = (TUser) request.getSession().getAttribute("user");
		String flag = request.getParameter("flag");
		TUserSafe userSafe = null;
		if (user != null) {
			userSafe = userSafeService.getUserSafeByUserId(user.getUserId()); // 根据当前用户获取用户安全表，判断是否绑定
			if (userSafe != null) {
				if (userSafe.getBindEmail() == 1) { // 绑定手机状态为1，表示是已绑定了，跳转至修改邮箱页面

					return new ModelAndView(
							"/loan/myAccount/bindUpdateEmail.jsp").addObject(
							"email", userSafe.getEmail()).addObject("flag",
							flag);
				}
			}
		}
		// TUser user = getSessionUser(request);
		//
		// TUserSafe userSafe =
		// userSafeService.getUserSafeByUserId(user.getUserId());
		// String email = "";
		// if(1 == userSafe.getBindEmail())
		// email = userSafe.getEmail();
		// return new
		// ModelAndView("/loan/myAccount/bindUpdateEmail.jsp").addObject("userSafe",
		// userSafe).addObject("email", email);
		return new ModelAndView("/loan/myAccount/bindEmail.jsp");
	}

	private TUser getSessionUser(HttpServletRequest request) {
		return (TUser) request.getSession().getAttribute("user");
	}
}
