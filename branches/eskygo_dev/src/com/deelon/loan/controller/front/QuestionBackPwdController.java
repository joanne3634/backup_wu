package com.deelon.loan.controller.front;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.service.front.TuserSafeService;

@ Controller
@ RequestMapping({"/loan/front/"})
public class QuestionBackPwdController extends BaseController {
	
	@Resource
	private TuserSafeService tuserSafeService;
	
	@Action(description="进入密保页面")
	@RequestMapping({"questionBackPwdPage"})
	public ModelAndView questionBackPwdPage(HttpServletRequest request, HttpServletResponse response,@RequestParam("uid") String uid){
		try {
			TUserSafe u=tuserSafeService.queryTUserSafeByuserId(uid);
			request.setAttribute("TUserSafe", u);
		return new ModelAndView("/loan/front/questionBackPwd.jsp").addObject("UID", uid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Action(description="校验密保")
	@RequestMapping({"validationQA"})
	public String validationQA(HttpServletRequest request, HttpServletResponse response){
		String question_1=request.getParameter("question_1");
		String question_2=request.getParameter("question_2");
		String question_3=request.getParameter("question_3");
		String userId=request.getParameter("UID");
		boolean flag1=true;
		boolean flag2=true;
		boolean flag3=true;
		try {
			
			//先判断回答的是否都正确,正确则跳转到修改密码页面//不正确则返回页面重新回答
				if(StringUtil.isNotEmpty(userId)){
					TUserSafe u=tuserSafeService.queryTUserSafeByuserId(userId);
					if(StringUtil.isNotEmpty(question_1)){
						String q1=question_1.trim();
						if(q1.equals(u.getA1())){
							flag1=true;
						}else{
							flag1=false;
						}
					}
					if(StringUtil.isNotEmpty(question_2)){
						String q2=question_2.trim();
						if(q2.equals(u.getA2())){
							flag2=true;
						}else{
							flag2=false;
						}
					}
					if(StringUtil.isNotEmpty(question_3)){
						String q3=question_3.trim();
						if(q3.equals(u.getA3())){
							flag3=true;
						}else{
							flag3=false;
						}
					}
					
					if(flag1&&flag2&&flag3){//跳转到修改密码页面
						response.sendRedirect(request.getContextPath() + "/loan/front/modifyPwdPage.ht?uid="+u.getUserId());
					}else{//返回页面重新回答
//						questionBackPwdPage(request,response,u.getUserId()+"");
						String Err_1="";
						String Err_2="";
						String Err_3="";
						if(!flag1){
							
							Err_1="111";
						}
						if(!flag2){
							
							Err_2="111";
						}
						if(!flag3){
							
							Err_3="111";
						}
						response.sendRedirect(request.getContextPath() + "/loan/front/questionBackPwdPage2.ht?uid="+u.getUserId()+"&Err_1="+Err_1+"&Err_2="+Err_2+"&Err_3="+Err_3+"&question_1="+question_1+"&question_2="+question_2+"&question_3="+question_3);
					}
				}
		
		
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	@Action(description="回答问题找回密码")
	@RequestMapping({"questionBackPwdPage2"})
	public ModelAndView questionBackPwdPage2(HttpServletRequest request, HttpServletResponse response){
		String err_1=request.getParameter("Err_1");
		String err_2=request.getParameter("Err_2");
		String err_3=request.getParameter("Err_3");
		
		String question_1=request.getParameter("question_1");
		String question_2=request.getParameter("question_2");
		String question_3=request.getParameter("question_3");
		
		String uid=request.getParameter("uid");
		
		try {
			TUserSafe u=tuserSafeService.queryTUserSafeByuserId(uid);
			
			request.setAttribute("TUserSafe", u);
			request.setCharacterEncoding("GBK");
			response.setContentType("text/html;charset=UTF-8");
			request.setAttribute("Err_1", err_1);
			request.setAttribute("Err_2", err_2);
			request.setAttribute("Err_3", err_3);
			request.setAttribute("EQ_Val", "");
			request.setAttribute("question_1", question_1);
			request.setAttribute("question_2", question_2);
			request.setAttribute("question_3", question_3);
		return new ModelAndView("/loan/front/questionBackPwd.jsp").addObject("UID", uid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
