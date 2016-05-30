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
import com.deelon.core.page.PageBean;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;

/**
 * 
 * @author Administrator
 *  @version 团队介绍
 */
@Controller
@RequestMapping({ "/site/TeamIntroduction/" })
public class TeamIntroductionController {
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "TeamIntroductionList" })
	@Action( description = " 团队介绍分页显示" )
	public ModelAndView MediaReportList(HttpServletRequest request,
			HttpServletResponse response) { /*
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenuId("TDJS");  */
		
		QueryFilter filter = new QueryFilter();
		filter.addFilter("menu_path", "TDJS"); //传入团队介绍栏目编码TDJS
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",6);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<CmsSiteMenuContent>  list = cmsSiteMenuContentService.getBySqlKeyAll(filter, CmsSiteMenuContent.class, "getMenuid");
		 request.setAttribute( "page_bean", pb );
		return new ModelAndView("/loan/aboutus/TeamIntroductionList.jsp").addObject(
				"cms", list).addObject( "page_bean", pb );
	}
}
