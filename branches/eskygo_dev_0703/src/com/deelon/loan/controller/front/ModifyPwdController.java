package com.deelon.loan.controller.front;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.util.MD5Util;

@Controller
@ RequestMapping({"/loan/front/"})
public class ModifyPwdController extends BaseController {
	
	@Resource
	private TUserService tUserService;
	
	private TUser tuser;
	@Action(description="进入修改密码页面")
	@RequestMapping({"modifyPwdPage"})
	public ModelAndView modifyPwdPage(HttpServletRequest request, HttpServletResponse response,@RequestParam("uid") String uid){
		try {
		return new ModelAndView("/loan/front/modifyPwd.jsp").addObject("UID", uid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Action(description="此方法弃用")
	@RequestMapping({"updatePwd"})
	public String updatePwd(HttpServletRequest request, HttpServletResponse response,@RequestParam("newPwd") String newPwd,@RequestParam("reNewPwd") String reNewPwd){
		String uid=request.getParameter("UID");
		try {
			if(StringUtil.isNotEmpty(newPwd)&&StringUtil.isNotEmpty(reNewPwd)){
				if(newPwd.equals(reNewPwd)){
					if(tuser==null){
						tuser=new TUser();
					}
					if(StringUtil.isNotEmpty(uid)){
						
						Long ui=Long.valueOf(uid);
						tuser.setUserId(ui);
					}
					tuser.setLoginPwd(newPwd);
					int ir=tUserService.modifyPwd(tuser);
					if(ir!=0){
						String ctxPath = request.getContextPath();
						response.sendRedirect(ctxPath + "/loginWeb.jsp");
					}
				}/*else{
					 request.getSession().setAttribute("SPRING_SECURITY_LAST_EXCEPTION", "两次输入的不一致!");
				     throw new AccessDeniedException("两次输入的不一致!");
				}*/
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return null;
	}
	@Action(description="修改密码")
	@RequestMapping({"updatechangePwd"})
	@ResponseBody
	public String updatechangePwd(HttpServletRequest request, HttpServletResponse response,@RequestParam("beforePwd") String beforePwd,@RequestParam("newPwd") String newPwd,@RequestParam("reNewPwd") String reNewPwd){
		String result = "";
		try {
			TUser user = getSessionUser(request);
			if(user == null){return "0";}
			
			result = tUserService.updateLoginPwd(user.getUserId(), beforePwd, newPwd, reNewPwd);
					
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Action(description="修改交易密码")
	@RequestMapping({"updatechangeTradePwd"})
	@ResponseBody
	public String updatechangeTradePwd(HttpServletRequest request, HttpServletResponse response,@RequestParam("beforeTradePwd") String beforeTradePwd,@RequestParam("newTradePwd") String newTradePwd,@RequestParam("reNewTradePwd") String reNewTradePwd) throws IOException{
		String result = "";
		try {
			TUser user = getSessionUser(request);
			if(user == null){return "0";}
			
			result = tUserService.updateTradePwd(user.getUserId(), beforeTradePwd, newTradePwd, reNewTradePwd);
		} catch (Exception e) {
			e.printStackTrace();
		};
		return result;
	}
	@Action(description="更换密码")
	@RequestMapping({"changePwdPage"})
	public ModelAndView changePwdPage(HttpServletRequest request, HttpServletResponse response){
		try {			
		return new ModelAndView("/loan/front/changePwd.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private TUser getSessionUser(HttpServletRequest request) {
		return (TUser) request.getSession().getAttribute("user");
	}
}
