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
 *@version  本金保障		
 * 
 */
@Controller
@RequestMapping({ "/loan/ThePrincipalProtection/" })
public class ThePrincipalProtectionController {
 
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;
	
	@RequestMapping({ "ThePrincipalProtection" })
	@Action( description = " 取出本金保障 " )
	public ModelAndView JoinUsList(HttpServletRequest request,HttpServletResponse response) {
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenuId("BJBZ");   
		return new ModelAndView("/loan/aboutus/ThePrincipalProtection.jsp").addObject(
				"cms", list);
	} 
}
