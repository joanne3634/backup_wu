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
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
/**
 * 
 * @author Administrator
 *  @version 媒体报道
 */
@Controller
@RequestMapping({ "/site/MediaReport/" })
public class MediaReportController extends BaseController {
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "MediaReportList" })
	@Action( description = " 媒体报道分页显示" )
	public ModelAndView MediaReportList(HttpServletRequest request,
			HttpServletResponse response) { 
		QueryFilter filter = new QueryFilter();
		filter.addFilter("menu_path", "MTBD"); 
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",5);
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<CmsSiteMenuContent>  list = cmsSiteMenuContentService.getBySqlKeyAll(filter, CmsSiteMenuContent.class, "getMenuid");
		 request.setAttribute( "page_bean", pb );
		return new ModelAndView("/loan/aboutus/MediaReportList.jsp").addObject(
				"cms", list).addObject( "page_bean", pb );
	}

	@RequestMapping({ "MediaReportDetails" })
	@Action( description = " 媒体报道详情" )
	public ModelAndView MediaReportDetails(HttpServletRequest request,
			HttpServletResponse response) {
		long id=Long.parseLong(request.getParameter("id"));
		CmsSiteMenuContent cms=cmsSiteMenuContentService.getById(id);//根据媒体报道id查询媒体报道详情
		return new ModelAndView("/loan/aboutus/MediaReportDetails.jsp").addObject("cms",cms);
	}
}
