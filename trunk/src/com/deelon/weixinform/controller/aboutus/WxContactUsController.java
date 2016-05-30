package com.deelon.weixinform.controller.aboutus;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.cmsform.service.site.CmsSiteMenuContentService;

/**
 * 联系我们
 * @author qin
 *@version  
 * 
 */
@Controller
@RequestMapping({ "/weixin/wxaboutus/" })
public class WxContactUsController {
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "contactUsList" })
	public ModelAndView contactUsList(HttpServletRequest request,
			HttpServletResponse response) { 
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenuId("LXWM");  
		return new ModelAndView("/weixinform/aboutus/relation.jsp").addObject(
				"cms", list);
	}
}