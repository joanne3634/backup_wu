package com.deelon.loan.controller.front;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping({ "/home/" })
public class HomeController {

	/**
	 * 跳转主页
	 * 
	 * @return
	 */
	@RequestMapping({ "index.ht" })
	public ModelAndView home() {
		return new ModelAndView("/loan/front/index.jsp");
	}
	
	@RequestMapping({ "memberCenter" })
	public ModelAndView memberCenter(){
		return new ModelAndView("/loan/front/memberCenter.jsp");
	}
	
	@RequestMapping({ "securityCenter" })
	public ModelAndView securityCenter(){
		return new ModelAndView("/loan/front/securityCenter.jsp");
	}
	
	
	
}
