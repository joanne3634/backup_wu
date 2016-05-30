package com.deelon.loan.controller.front;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.AppUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.servlet.ValidCode;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TareaService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.platform.model.system.SysAuditModelType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

/**
 * 前台用户请求处理控制器
 *
 * @author deelon.hqx
 * @date 2014-09-30
 */
@Controller
@RequestMapping({"/user/"})
@Action(ownermodel = SysAuditModelType.USER_MANAGEMENT)
public class UserController extends BaseController {

    private static final Logger LOG = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private TUserService tUserService;
    @Resource
    private TareaService tareaService;
    @Autowired
    private TuserSafeService userSafeService;

    /**
     * 初始化用户注册页面，根据选择的是注册投资和或创业者进行跳转
     *
     * @param request 使用request取得用户提交数据
     * @param type    枚举类型，1和2,1创业者，2投资者
     * @return ModelAndView 返回创业者或投资者页面
     * @throws Exception
     */
    @RequestMapping({"registerInit"})
    public ModelAndView registerInit(HttpServletRequest request) {

        String type = request.getParameter("type");
        // 获取省级地区
        QueryFilter query = new QueryFilter();
        query.addFilter("parentId", 1);
        query.addFilter("orderField", "order_code");
        query.addFilter("orderSeq", "desc");
        List<Tarea> arealist = tareaService.getAll(query); //获取市级地区

        request.setAttribute("arealist", arealist);

        if ("1".equals(type)) {// 跳转到创业者页面
            return new ModelAndView("/crowdfunding/front/entrepreneurRegist.jsp"); // 注册创业者页面
        } else {// 跳转到投资者页面
            return new ModelAndView("/crowdfunding/front/investorRegist.jsp"); // 注册投资人页面
        }
    }

    /**
     * 用户点提交进行注册，后台进行处理
     *
     * @param tuser 用户基本信息
     * @param tuser 用户扩展信息，保存用户的身份证，手机，银行卡等信息
     * @return String 返回注册结果
     * @throws Exception
     */
    @RequestMapping({"register"})
    @ResponseBody
    public String register(HttpServletRequest request,
                           HttpServletResponse response, TUser tuser, TUserSafe tuserSafe)
            throws Exception {
        LOG.info("user register:loginName={}", tuser.getLoginName());

        String message = "注册成功";
        String code = request.getParameter("code"); //验证码
        if ((org.apache.commons.lang.StringUtils.isEmpty(code))) {
            return "请输入验证码";
        }

        String validCode = (String) request.getSession().getAttribute(
                ValidCode.getSessionName_Randcode()); //session中的验证码
        LOG.info("User register:validCOde={}", validCode);
        if ((validCode == null) || (!validCode.equalsIgnoreCase(code))) {
            LOG.info("验证码输入有误");
            return "验证码输入有误";
        }

        // 实名认证

		/*  if(StringUtil.isNotEmpty(tuser.getRealName()) && StringUtil.isNotEmpty(tuserSafe.getIdNo())){
              String message = "";
			  Map<String,Object> map =userSafeService.idcardIsReal(request,response,tuser.getRealName(),tuserSafe.getIdNo());
			  if(map.get("same")!=null && String.valueOf(map.get("same")).equals("1")){
				  message ="1";//姓名，身份证号一致 
				  tuserSafe.setBindIdNo((short)1);
				  }else{
				  message = String.valueOf(map.get("msg"));
				  return message;
				  }
			  }*/

        //“个人说明”注册时后台设定为用户名［前台已控制过］
        tuser.setRemarks(tuser.getLoginName());
        try {
            message = tUserService.register(tuserSafe, tuser, request);//调用注册方法进行实际注册
            // if(result.equals("0")){ //注册成功
            // request.getSession().setAttribute("user", user);
            // }
        } catch (UserException e) {
            LOG.error("register error:userName= {}", tuser.getLoginName(), e);
            message = "注册失败";
        }
        return message;
    }

    /**
     * 前台用户登陆
     *
     * @param user
     * @param password
     * @return
     * @throws Exception
     */
    @RequestMapping({"login"})
    @ResponseBody
    public String login(HttpServletRequest request, String loginName,
                        String loginPwd) throws Exception {
        String result = "";
        try {
            String code = request.getParameter("code");                //用户提交的验证码
            if ((org.apache.commons.lang.StringUtils.isEmpty(code))) { // 判断验证码是否为空
                return "请输入验证码";
            }

            String validCode = (String) request.getSession().getAttribute(
                    ValidCode.getSessionName_Randcode());
            if ((validCode == null) || (!validCode.equalsIgnoreCase(code))) {
                logger.info("验证码输入有误");
                return "验证码输入有误";
            }
            logger.info(String.format("{%s} loging...", loginName));
            result = tUserService.login(loginName, loginPwd, request);
        } catch (UserException e) {
            logger.error(String.format("{%s} login error! Message: {%s}",
                    loginName, e.getMessage()));
            e.printStackTrace();
        }

        return result;
    }

    /**
     * 注销用户,清空当前用户的session，返回到首页
     *
     * @param user
     * @return
     * @throws IOException
     */
    @RequestMapping({"logout"})
    public ModelAndView logout(HttpServletRequest request,
                               HttpServletResponse response) throws IOException {

        TUser user = TUserUtil.getLogUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/index-web.jsp");
        }

        request.getSession().removeAttribute("user");
        response.sendRedirect(request.getContextPath() + "/index-web.jsp");
        return null;
    }

    /**
     * 注册的时候验证用户名是否存在
     *
     * @param request
     * @param response
     * @return 返回true或者false
     * @throws IOException
     */
    @RequestMapping({"validateUserName"})
    public void validateUserName(HttpServletRequest request,
                                 HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String loginName = request.getParameter("loginName");//输入的登录名
        System.out.println("loginName: " + loginName);
        Boolean tag = tUserService.existLoginName(loginName);//检查这个用户名是否已经存在
        PrintWriter out = response.getWriter();
        if (tag) {
            out.print("false");
        } else {
            out.print("true");
        }
    }

    /**
     * 注册的时候验证email是否存在
     *
     * @param request
     * @param response
     * @return 返回true或者false
     * @throws IOException
     */
    @RequestMapping({"validateEmail"})
    public void validateEmail(HttpServletRequest request,
                              HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");//输入的email

        Boolean tag = tUserService.existEmail(email);//检查这个email是否已经存在
        PrintWriter out = response.getWriter();
        if (tag) {
            out.print("false");
        } else {
            out.print("true");
        }
    }

    /**
     * 注册的时候验证输入的身份证号是否已经存在
     *
     * @param request
     * @param response
     * @return 返回true或者false
     * @throws IOException
     */
    @RequestMapping({"validateIdNo"})
    public void validateIdNo(HttpServletRequest request,
                             HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String idNo = request.getParameter("idNo");//输入的身份证号码
        TUser user = TUserUtil.getLogUser(request);
        Boolean tag = tUserService.existIdNo(idNo); //检查输入的身份证号码是否已经存在

        if (user != null) {
            TUserSafe userSafe = userSafeService.getUserSafeByUserId(user.getUserId());
            if (userSafe.getIdNo().equals(idNo)) {
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
     * jq验证框架 验证手机号码是否唯一，是否已经存在
     *
     * @param request
     * @param response
     * @return 返回true或者false
     * @throws IOException
     */
    @RequestMapping({"validatePhone"})
    public void validatePhone(HttpServletRequest request,
                              HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        String mobile = request.getParameter("mobile");//输入的身手机号码
        Boolean tag = userSafeService.existPhone(mobile);//检查输入的手机号码是否存在
        PrintWriter out = response.getWriter();
        if (tag) {
            out.print("false");
        } else {
            out.print("true");
        }

    }

    /**
     * 判断用户输入的验证码是否正确
     *
     * @param request
     * @param response
     * @return 返回true或者false
     * @throws IOException
     */
    @RequestMapping({"validateCode"})
    public void validateCode(HttpServletRequest request,
                             HttpServletResponse response) throws IOException {
        String code = request.getParameter("code"); //前台输入的验证码

        boolean tag = false;
        String validCode = (String) request.getSession().getAttribute(
                ValidCode.getSessionName_Randcode()); //session中的验证码
        if (code.equalsIgnoreCase(validCode)) // 判断验证码是否相同
            tag = true;

        PrintWriter out = response.getWriter();
        if (tag) {
            out.print("true");
        } else {
            out.print("false");
        }
    }

	
	/**
	 * 判断用户输入的真实姓名和身份证号是否对应
	 * 
	 * @param request
	 * @param response
	 * @return String 返回验证结果
	 * @throws IOException
	 */
//	@RequestMapping({ "verifyIdNo" })
//	@ResponseBody
//	public String verifyIdNo(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		String realName = request.getParameter("realName"); //前台输入的真实姓名
//		String idNo = request.getParameter("idNo"); //前台输入的身份证号
//		System.out.println(realName+"---------------------"+idNo);
//		
//		if (realName=="" || idNo=="") {
//			return "真实姓名或者身份证号不能为空";
//		}
//		
//		Map map = userSafeService.verifyIdNo(request, response, realName, idNo);//检查输入的姓名，身份证号是否一致
//		System.out.println(map.get("auResultCode"));
//		if(map.get("auResultCode")!=null && String.valueOf(map.get("auResultCode")).equals("FAILED")){
//			return map.get("auResultInfo").toString();//姓名，身份证号不一致 
//		}else{
//			return "success";
//		}
//	}
	
	/**
	 * 判断用户输入的真实姓名和身份证号是否对应
	 * 
	 * @param request
	 * @param response
	 * @return String 返回验证结果
	 * @throws IOException
	 */
	@RequestMapping({ "verifyIdNo" })
	@ResponseBody
	public void verifyIdNo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String realName = request.getParameter("realName"); //前台输入的真实姓名
		String idNo = request.getParameter("idNo"); //前台输入的身份证号
        LOG.info("实名认证,realName={}",realName);
		PrintWriter out = response.getWriter();
		 try {
			String idindata=(String) AppUtil.getServletContext().getAttribute("ID_INDATA_YE_NO");//实名认证开关
			if("1".equals(idindata)){

				Map map = userSafeService.verifyIdNo(request, response, realName, idNo);//检查输入的姓名，身份证号是否一致
                LOG.info("实名认证结果={}",map.get("auResultCode"));
                if(map.get("auResultCode")!=null && String.valueOf(map.get("auResultCode")).equals("FAILED")){
					out.print("false");
				} else {
					out.print("true");
				}
			}else{
				out.print("true");
			}
		} catch (Exception e) {
             LOG.error("实名认证异常 ,realName={}",realName,e);
		}

	}
}
