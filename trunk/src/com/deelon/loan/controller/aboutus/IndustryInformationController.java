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
 *  @version 行业资讯
 */
@Controller
@RequestMapping({ "/site/IndustryInformation/" })
public class IndustryInformationController {
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "IndustryInformationList" })
	@Action( description = " 行业资讯分页显示" )
	public ModelAndView IndustryInformationList(HttpServletRequest request,
			HttpServletResponse response) {
		QueryFilter filter = new QueryFilter();
		filter.addFilter("menu_path", "HYZX"); //传入行业资讯栏目编码HYZX
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",5);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<CmsSiteMenuContent>  list = cmsSiteMenuContentService.getBySqlKeyAll(filter, CmsSiteMenuContent.class, "getMenuid");//调用getMenuid方法
		 request.setAttribute( "page_bean", pb );
		return new ModelAndView("/loan/aboutus/IndustryInformationList.jsp").addObject(
				"cms", list).addObject( "page_bean", pb );
	}
	
	@RequestMapping({ "IndustryInformationDetails" })
	@Action( description = " 行业资讯详情" )
	public ModelAndView CompanyNewsDetails(HttpServletRequest request,
			HttpServletResponse response) { 
		long id=Long.parseLong(request.getParameter("id"));
		CmsSiteMenuContent cms=cmsSiteMenuContentService.getById(id);//根据行业资讯id查询行业资讯详情
		return new ModelAndView("/loan/aboutus/IndustryInformationDetails.jsp").addObject("cms",cms);
	}
}
