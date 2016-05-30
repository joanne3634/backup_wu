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
 *@version  法律政策		
 * 
 */
@Controller
@RequestMapping({ "/loan/LegalPolicy/" })
public class LegalPolicy {
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "LegalPolicyList" })
	@Action( description = " 取出法律政策信息" )
	public ModelAndView JoinUsList(HttpServletRequest request,HttpServletResponse response) {
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenuId("FLZC");   
		return new ModelAndView("/loan/aboutus/LegalPolicyList.jsp").addObject(
				"cms", list);
	}
}
