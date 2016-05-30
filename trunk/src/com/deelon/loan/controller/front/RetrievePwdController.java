package com.deelon.loan.controller.front;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.MailCommon;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TuserSafeService;

@Controller
@RequestMapping({ "/loan/front/" })
public class RetrievePwdController extends BaseController {

	@Resource
	private TuserSafeService tUserSafeService;

	@Resource
	private TUserService tUserService;
	private TUserSafe tUserSafe;
	
	@Action(description="找回密码页面")
	@RequestMapping({ "retrievePwd" })
	public ModelAndView sendDirectPage(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			return new ModelAndView("/loan/front/retrievePwd.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Action(description="通过邮件找回")
	@RequestMapping({ "retrievePwdByMail" })
	public String retrievePwdByMail(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("email_addr") String email_addr,
			@RequestParam("validCode_") String validCode) {
		try {

			if (tUserSafe == null) {
				tUserSafe = new TUserSafe();
			}

			String secretKey = UUID.randomUUID().toString(); // 密钥
			Timestamp outDate = new Timestamp(
					System.currentTimeMillis() + 30 * 60 * 1000);// 30分钟后过期
			long date = outDate.getTime() / 1000 * 1000;// 忽略毫秒数 mySql
														// 取出时间是忽略毫秒数的

			// 将过期时间保存到数据ku
			tUserSafe = tUserSafeService.queryTUserSafeByEmail(email_addr);
			if (tUserSafe != null) {

				if (StringUtil.isEmpty(tUserSafe.getEmail())) {
					request.setAttribute("MessageStr", "邮箱地址不正确,请输入绑定的邮箱!");
					request.getSession().setAttribute("MessageStr",
							"邮箱地址不正确,请输入绑定的邮箱!");
					throw new AccessDeniedException("邮箱地址不正确,请输入绑定的邮箱!");
				}

				String key = date + "$" + secretKey;
				tUserSafe.setOutDate(outDate);
				tUserSafe.setValidataKey(key);
				tUserSafeService.updateTUserSafeByPk(tUserSafe);

				// String digitalSignature = Md5.md5(key);// 数字签名
				String digitalSignature = key;// 数字签名

				String path = request.getContextPath();
				String basePath = request.getScheme() + "://"
						+ request.getServerName() + ":"
						+ request.getServerPort() + path + "/" + "loan/front/";
				
				String resetPassHref = basePath + "checkResetLink.ht?sid="
						+ digitalSignature + "&uid=" + tUserSafe.getUserId();

				String emailContent = "请勿回复本邮件.点击下面的链接,重设密码 " + resetPassHref+ ""
						+ " 本邮件超过30分钟,链接将会失效，需要重新申请'找回密码'";
				
				MailCommon mail = new MailCommon();
				mail.setSubject("测试邮件找回密码");
				mail.setHtmlBody(emailContent);
				mail.setAddress(email_addr, MailCommon.getTo());
				mail.setFromAddress("442812980@qq.com");
				mail.setSMTPHost("smtp.qq.com", "25", "442812980@qq.com","p283947");
				mail.sendBatch();
				response.sendRedirect(request.getContextPath()
						+ "/loan/front/sendEmailSuc.ht?email_addr=" + email_addr);
			} else {
				request.setAttribute("_EXCEPTION", "请输入注册时的邮箱地址 !");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Action(description="检查邮件链接")
	@RequestMapping("checkResetLink")
	public String checkResetLink(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("sid") String sid,
			@RequestParam("uid") String uid) {
		
		try {
			if (sid.equals("") || uid.equals("")) {
				request.setAttribute("mesg", "链接不完整,请重新生成");
				throw new AccessDeniedException("链接不完整,请重新生成!");
			}

			//
			if (tUserSafe == null) {
				tUserSafe = new TUserSafe();
			}
			tUserSafe.setValidataKey(sid);
			TUserSafe users = tUserSafeService
					.queryTUserSafeByValidateKey(tUserSafe);

			if (users != null) {
				Timestamp outDate = (Timestamp) users.getOutDate();
				if (outDate.getTime() <= System.currentTimeMillis()) { // 表示已经过期
					request.setAttribute("mesg", "链接已经过期,请重新申请找回密码.");
					System.out.println("时间 超时");
				}

				// String digitalSignature = Md5.md5(key);// 数字签名
				String digitalSignature = users.getValidataKey();
				System.out.println("digitalSignature>>>>" + digitalSignature);
				if (!digitalSignature.equals(sid)) {// 与先前保存到数据库中的校验码比较,看是否链接正确
					request.setAttribute("mesg", "链接不正确,是否已经过期了?重新申请吧.");
				} else {
					// 链接验证通过 转到修改密码页面
					response.sendRedirect(request.getContextPath()
							+ "/loan/front/modifyPwdPage.ht?uid=" + uid);
				}
			} else {
				request.setAttribute("mesg", "链接错误,无法找到匹配用户,请重新申请找回密码.");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Action(description="验证邮箱")
	@RequestMapping({ "emailValid" })
	public String emailValid(HttpServletRequest request,
			HttpServletResponse response) {
		try {

			String email_addr = request.getParameter("email_addr");
			TUserSafe us = tUserSafeService.queryTUserSafeByEmail(email_addr);
			if (us == null) {
				return "请输入注册的邮箱地址！";
			} else {
				return "";
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Action(description="手机发送校验码")
	@RequestMapping({ "mobileSendValiCode" })
	public String mobileSendValiCode(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("mobileNum") String mobileNum,
			@RequestParam("valiCode_2") String valiCode_2) {
		
		// 发送验证码到手机

		// 页面跳转到 输入手机验证码 的提示页面
		try {
			response.sendRedirect(request.getContextPath()
					+ "/loan/front/toMobileValiCodePage.ht?mobileNum="
					+ mobileNum);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Action(description="问题找回密码")
	@RequestMapping({ "questionBackPwd" })
	public String questionBackPwd(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("userName_") String userName_,
			@RequestParam("valiCode_3") String valiCode_3) {
		
		TUser us = new TUser();
		us.setLoginName(userName_);
		try {
			TUser u = tUserService.queryTUserByLoginName(us);
			if (u != null) {
				response.sendRedirect(request.getContextPath()
						+ "/loan/front/questionBackPwdPage.ht?uid="
						+ u.getUserId());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

}
