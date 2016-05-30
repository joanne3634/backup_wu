package com.deelon.loan.controller.aboutus;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteMenu;
import com.deelon.cmsform.service.site.CmsSiteMenuService;
import com.deelon.core.annotion.Action;

/**
 * 
 * @author Administrator
 *  @version 新手入门
 */
@Controller
@RequestMapping({ "/loan/aboutus/" })
public class HouseholdFinanceGuideController {
	
	@Resource
	private CmsSiteMenuService cmsSiteMenuService;
	
	@RequestMapping({ "HouseholdFinanceGuideList" })
	@Action( description = " 新手入门列表" )
	public ModelAndView AboutUs(HttpServletRequest request,
			HttpServletResponse response) { 
		List<CmsSiteMenu> list=cmsSiteMenuService.getMenuPath("XSRM"); //根据新手入门的栏目代码XSRM查询新手入门信息  
		return new ModelAndView("/loan/aboutus/HouseholdFinanceGuideList.jsp").addObject("list",list);
	}
}
