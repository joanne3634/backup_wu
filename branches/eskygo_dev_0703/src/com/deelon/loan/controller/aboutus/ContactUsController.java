package com.deelon.loan.controller.aboutus;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.service.site.CmsSiteMenuContentService;
import com.deelon.core.annotion.Action;

/**
 * @author Administrator
 *@version  联系我们
 * 
 */
@Controller
@RequestMapping({ "/site/ContactUs/" })
public class ContactUsController {
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "ContactUsList" })
	@ Action( description = " 联系我们查询" )
	public ModelAndView ContactUsList(HttpServletRequest request,
			HttpServletResponse response) { 
		//List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenuId("LXWM");  //通过联系我们的编码LXWM查询联系我们
		return new ModelAndView("/loan/aboutus/ContactUsList.jsp");
	}
}