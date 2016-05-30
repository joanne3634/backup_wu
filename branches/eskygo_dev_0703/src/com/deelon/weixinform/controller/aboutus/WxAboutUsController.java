package com.deelon.weixinform.controller.aboutus;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 关于我们
 * @author qin
 *
 */
@Controller
@RequestMapping({"/weixin/wxaboutus/"})
public class WxAboutUsController {

	@RequestMapping({ "aboutUs" })
	public ModelAndView aboutUs() {
		return new ModelAndView("/weixinform/aboutus/message.jsp");
	}
	
	/**
	 * 帮助中心
	 * @return
	 */
	@RequestMapping({ "aboutHelp" })
	public ModelAndView aboutHelp(){
		return new ModelAndView("/weixinform/aboutus/aboutHelp.jsp");
	}
}
