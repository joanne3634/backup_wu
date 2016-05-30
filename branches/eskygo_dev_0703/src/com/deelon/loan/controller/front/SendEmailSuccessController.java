package com.deelon.loan.controller.front;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.controller.BaseController;

@Controller
@ RequestMapping({"/loan/front/"})
public class SendEmailSuccessController extends BaseController {

	@Action(description="到发送邮件成功页面")
	@RequestMapping({"sendEmailSuc"})
	public ModelAndView sendEmailSuc(HttpServletRequest request, HttpServletResponse response,@RequestParam("email_addr") String email_addr){
		try {
		return new ModelAndView("/loan/front/sendEmailSuccess.jsp").addObject("email_addr",email_addr);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
}
