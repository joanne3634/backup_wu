package com.deelon.loan.controller.front;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.web.controller.BaseController;
@ Controller
@ RequestMapping({"/loan/front/"})
public class MobileValiCodeInController extends BaseController {

	@RequestMapping({"toMobileValiCodePage"})
	public ModelAndView toMobileValiCodePage(HttpServletRequest request, HttpServletResponse response,@RequestParam("mobileNum") String mobileNum){
		try {
		return new ModelAndView("/loan/front/mobileValiCodeIn.jsp").addObject("mobileNum", mobileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping({"valiFromMobileCode"})
	public String valiFromMobileCode(HttpServletRequest request, HttpServletResponse response,@RequestParam("moValiCode") String moValiCode,@RequestParam("mobileNum") String mobileNum){
		
		 /*String validCode = (String)request.getSession().getAttribute(ValidCode.SessionName_Randcode);
	        String code = request.getParameter("validCode");
	        if ((validCode == null) || (org.apache.commons.lang.StringUtils.isEmpty(code)) || (!validCode.equals(code)))
	        {
	          request.getSession().setAttribute("SPRING_SECURITY_LAST_EXCEPTION", "验证码不正确！");
	          throw new AccessDeniedException("验证码不正确");
	        }*/
		
		//根据手机号码查询用户 将用户id付给修改密码页面
		String user_id="1";
		
		//验证收到的验证码
		try {
			if(moValiCode.equals("aaa")){//这里暂时模拟 //跳转到修改密码页面
				response.sendRedirect(request.getContextPath() + "/loan/front/modifyPwdPage.ht?uid="+user_id);
			}else{//停留在验证页面
				request.setAttribute("Err_", "${ctx}/images/error.jpg");
				response.sendRedirect(request.getContextPath() + "/loan/front/toMobileValiCodePage.ht?mobileNum="+mobileNum);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
	        
		return null;
	}
}
