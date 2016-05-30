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
 * @version 通知公告
 */

@Controller
@RequestMapping({ "/loan/aboutus/" })
public class NoticeController {

	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "NoticeList" })
	@Action( description = " 通知公告分页显示" )
	public ModelAndView MediaReportList(HttpServletRequest request,
			HttpServletResponse response) { 
		QueryFilter filter = new QueryFilter();
		filter.addFilter("menu_path", "TZGG"); //传入通知公告栏目编码GSXW
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",5);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<CmsSiteMenuContent>  list = cmsSiteMenuContentService.getBySqlKeyAll(filter, CmsSiteMenuContent.class, "getMenuid");
		 request.setAttribute( "page_bean", pb );
		return new ModelAndView("/loan/aboutus/NoticeList.jsp").addObject(
				"cms", list).addObject( "page_bean", pb );
	}

	@RequestMapping({ "NoticeDetails" })
	@Action( description = " 通知公告分页显示" ) 
	public ModelAndView MediaReportDetails(HttpServletRequest request,
			HttpServletResponse response) {
		long id = Long.parseLong(request.getParameter("id"));
		CmsSiteMenuContent cms = cmsSiteMenuContentService.getById(id);//通过通知公告ID查询通知公告详情
		return new ModelAndView("/loan/aboutus/NoticeDetails.jsp").addObject(
				"cms", cms);
	}
}
