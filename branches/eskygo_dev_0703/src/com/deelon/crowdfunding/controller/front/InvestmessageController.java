package com.deelon.crowdfunding.controller.front;

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
import com.deelon.crowdfunding.model.backstage.TcprojectNews;
import com.deelon.loan.util.HtmlRegexpUtil;

/**
 * 
 * @author Administrator
 *  @version 投资资讯
 */
@Controller
@RequestMapping({ "/site/Investmessage/" })
public class InvestmessageController {
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "InvestmessageList" })
	@Action( description = "投资资讯分页显示" )
	public ModelAndView IndustryInformationList(HttpServletRequest request,
			HttpServletResponse response) {
		QueryFilter filter = new QueryFilter();
		filter.addFilter("menu_path", "HYZX");//传入投资资讯栏目编码HYZX
		List<CmsSiteMenuContent>  list1 = cmsSiteMenuContentService.getBySqlKeyAll(filter, CmsSiteMenuContent.class, "getMenuid");//调用getMenuid方法
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",10);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<CmsSiteMenuContent>  list2 = cmsSiteMenuContentService.getBySqlKeyAll(filter, CmsSiteMenuContent.class, "getMenuid");//调用getMenuid方法
		for (CmsSiteMenuContent t:list2) {
			t.setContentText(HtmlRegexpUtil.filterHtml(t.getContentText()));
		}
		request.setAttribute( "page_bean", pb );
		return new ModelAndView("/crowdfunding/front/InvestmessageList.jsp")
			.addObject("cms", list1).addObject("cms2", list2).addObject( "page_bean", pb );
	}
	
	@RequestMapping({ "InvestmessageDetails" })
	@Action( description = " 行业资讯详情" )
	public ModelAndView CompanyNewsDetails(HttpServletRequest request,
			HttpServletResponse response) { 
		long id=Long.parseLong(request.getParameter("id"));
		CmsSiteMenuContent cms=cmsSiteMenuContentService.getById(id);//根据行业资讯id查询行业资讯详情
		QueryFilter filter = new QueryFilter();
		filter.addFilter("menu_path", "HYZX");//传入投资资讯栏目编码HYZX
		List<CmsSiteMenuContent>  list = cmsSiteMenuContentService.getBySqlKeyAll(filter, CmsSiteMenuContent.class, "getMenuid");//调用getMenuid方法
		return new ModelAndView("/crowdfunding/front/InvestmessageDetails.jsp")
				.addObject("cms",cms)
				.addObject("CmsSiteMenuContent",list);
	}
}
