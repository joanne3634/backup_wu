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
 * @version 友情链接
 */
@Controller
@RequestMapping({ "/loan/aboutus/" })
public class LinksController {
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "LinksList" })
	@Action( description = " 友情链接分页" )
	public ModelAndView MediaReportList(HttpServletRequest request,
			HttpServletResponse response) { 
		QueryFilter filter = new QueryFilter();
		filter.addFilter("menu_path", "YQLJ"); //传入友情链接栏目编码YQLJ
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",5);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<CmsSiteMenuContent>  list = cmsSiteMenuContentService.getBySqlKeyAll(filter, CmsSiteMenuContent.class, "getMenuid");
		 request.setAttribute( "page_bean", pb );
		return new ModelAndView("/loan/aboutus/LinksList.jsp").addObject(
				"cms", list).addObject( "page_bean", pb );
	}

}
