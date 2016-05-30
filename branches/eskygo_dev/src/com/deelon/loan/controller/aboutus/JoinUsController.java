package com.deelon.loan.controller.aboutus;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.cmsform.service.site.CmsSiteMenuContentService;
import com.deelon.core.annotion.Action;

/**
 * @author Administrator
 *@version  诚聘英才		
 * 
 */
@Controller
@RequestMapping({ "/site/JoinUs/" })
public class JoinUsController {
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "JoinUsList" })
	@Action( description = " 取出诚聘英才信息" )
	public ModelAndView JoinUsList(HttpServletRequest request,
			HttpServletResponse response) { 
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenuId("CPYC");  
		return new ModelAndView("/loan/aboutus/JoinUsList.jsp").addObject(
				"cms", list);
	}
}
