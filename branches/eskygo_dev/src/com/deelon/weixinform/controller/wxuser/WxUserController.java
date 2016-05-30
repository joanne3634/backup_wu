package com.deelon.weixinform.controller.wxuser;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.servlet.ValidCode;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.TuserLoginlog;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.front.UserInfoService;

/**
 * 前台用户处理控制器
 * 
 * @author deelon.hejian
 * 
 */
@Controller
@RequestMapping({ "/weixin/wxuser/" })
public class WxUserController extends BaseController {

	@Autowired
	private TUserService tUserService;
	
	@Autowired
	private UserInfoService userInfoService;
	
	@Autowired
	private TuserSafeService userSafeService;
	@Autowired
	private TuserSafeService tuserSafeService;

	/**
	 * 跳转到注册页面
	 * @return
	 */
	@RequestMapping({ "registerInit" })
	public ModelAndView registerInit() {
		return new ModelAndView("/weixinform/wxuser/register.jsp");
	}

	/**
	 * 微信平台用户注册
	 * 
	 * @param user
	 *            用户实体类
	 * @return ModelAndView 注册结果
	 * @throws Exception 
	 */
	@RequestMapping({ "register" })
	@ResponseBody
	public Object register(HttpServletRequest request,String loginName,
			String loginPwd, String mobile) throws Exception {
		System.out.println("User role!");
		ResultMessage message = new ResultMessage(1,"注册成功");
		String code = request.getParameter("code");
		if(code==null){
			message.setResult(0);
			message.setMessage("验证码不正确！");
			return message;
		}
		Object checkCodeObj = request.getSession().getAttribute("BIND_PHONE_CODE");
		if(checkCodeObj==null){
			message.setResult(0);
			message.setMessage("验证码不正确！");
			return message;
		}
		if(!code.equals(checkCodeObj.toString())){
			message.setResult(0);
			message.setMessage("验证码不正确！");
			return message;
		}
		Object phoneObj = request.getSession().getAttribute("BIND_PHONE");
		if(phoneObj==null){
			message.setResult(0);
			message.setMessage("手机号不正确！");
			return message;
		}
		if(!phoneObj.toString().equals(mobile)){
			message.setResult(0);
			message.setMessage("手机号已改变！");
			return message;
		}
		
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.addFilter("mobile", mobile);
		List<TUserSafe> safeList = tuserSafeService.getAll(queryFilter);
		if(safeList!=null && safeList.size()>0){
			message.setMessage("你的手机号已经绑定某个账号，不能再用来注册账号。");
			return message;
		}
		
		Long userId = UniqueIdUtil.genId();
		TUserSafe userSafe = new TUserSafe();
		userSafe.setEmail("");
		userSafe.setMobile(mobile);
		userSafe.setUserId(userId);
		userSafe.setLoginName(loginName);
		userSafe.setBindMobile((short)1);

		TUser user = new TUser();
		user.setUserId(userId);
		user.setLoginName(loginName);
		user.setLoginPwd(loginPwd);
		user.setTradingPwd(loginPwd);//初始化交易密码和登录密码相同
		user.setGroupId("1");
		user.setIsActive(Integer.valueOf(AppUtil.getServletContext().getAttribute("ACTIVATION").toString()));

		try {
			tUserService.register(userSafe, user,request);
		} catch (Exception e) {
			e.printStackTrace();
			message.setResult(0);
			message.setMessage("注册失败！");
		}
		return message;
	}

	/**
	 * 微信平台用户登陆
	 * 
	 * @param user
	 * @param password
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "login" })
	@ResponseBody
	public Object login(HttpServletRequest request, String loginName,
			String loginPwd){
		ResultMessage message = new ResultMessage(1,"登陆成功");
		try {
			logger.info(String.format("{%s} loging...", loginName));
			tUserService.loginByMobile(loginName, loginPwd,request);
		} catch (Exception e) {
			logger.error(String.format("{%s} login error! Message: {%s}",
					loginName, e.getMessage()));
			e.printStackTrace();
			message.setResult(0);
			message.setMessage(e.getMessage());
		}
		return message;	
	}
	
	/**
	 * 登录后跳转页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "loginRedirect" })
	public ModelAndView loginRedirect() throws Exception {
		return new ModelAndView("/weixinform/myaccount/myaccount.jsp");	
	}
	
	/**
	 * 其他界面跳转到登录界面
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "loginPage" })
	public ModelAndView loginPage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
		return null;	
	}

	/**
	 * 注销用户
	 * 
	 * @param user
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping({ "loginout" })
	public ModelAndView loginout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		TUser user = (TUser) request.getSession().getAttribute("user");
		
		if(user == null){
			response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
			return null;
		}
		TuserLoginlog tuserLoginlog = new TuserLoginlog();
		tuserLoginlog.setLoginLogId(Long.valueOf(UniqueIdUtil.genId()));
		tuserLoginlog.setUserId(user.getUserId());
		tuserLoginlog.setTypeId("2");
		tuserLoginlog.setPlatformId("1");
		tuserLoginlog.setClientIp(request.getRemoteAddr());
		tuserLoginlog.setDeviceId("");
		tuserLoginlog.setResultId("1");
		tuserLoginlog.setRemarks("成功退出登录");
		tUserService.saveloginlog(tuserLoginlog);
		
		
		request.getSession().removeAttribute("user");
		response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
		return null;
	}

	/**
	 * 验证用户名
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validateUserName" })
	public void validateUserName(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		String loginName = request.getParameter("loginName");
		System.out.println("loginName: " + loginName);
		Boolean tag = tUserService.existLoginName(loginName);
		PrintWriter out = response.getWriter();
		if (tag) {
			out.print("false");
		}else{
			out.print("true");
		}
	}

	/**
	 * 验证邮箱
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

		Boolean tag = tUserService.existEmail(email);
		PrintWriter out = response.getWriter();
		if (tag) {
			out.print("false");
		}else{
			out.print("true");
		}
	}
	
	private TUser getSessionUser(HttpServletRequest request) {
		return (TUser) request.getSession().getAttribute("user");
	}
	
	@RequestMapping("sendWeixinRegisterCheckCode")
	@ResponseBody
	public Object sendWeixinRegisterCheckCode(HttpServletRequest request){
		String phone = RequestUtil.getString(request, "phone");	
		ResultMessage message = new ResultMessage(1,"操作成功");
		try {
			if(StringUtil.isEmpty(phone)){
				throw new Exception("你的手机号为空！");
			}
			QueryFilter queryFilter = new QueryFilter();
			queryFilter.addFilter("mobile", phone);
			List<TUserSafe> safeList = tuserSafeService.getAll(queryFilter);
			if(safeList!=null && safeList.size()>0){
				throw new Exception("你的手机号已经绑定某个账号，不能再用来注册账号。");
			}
			userInfoService.sendbindMobileCode(phone, request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			message.setResult(0);
			message.setMessage("获取验证码失败，"+e.getMessage());
		}
		return message;
	}
}
