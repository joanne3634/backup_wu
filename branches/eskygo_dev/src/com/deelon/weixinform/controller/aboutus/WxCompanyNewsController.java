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
import com.deelon.core.page.PageBean;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
/**
 * 公司新闻
 * @author Administrator
 *  @version 
 */
@Controller
@RequestMapping({ "/weixin/wxaboutus/" })
public class WxCompanyNewsController {
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	/**
	 * 公司新闻列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping({ "companyNewsList" })
	public ModelAndView companyNewsList(HttpServletRequest request,
			HttpServletResponse response) {  
		/*list =  cmsSiteMenuContentService.getMenuId("GSXW");*/
		QueryFilter filter = new QueryFilter();
		filter.addFilter("menu_path", "GSXW"); 
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",5);
		PageBean pb=new  PageBean(page, pageSize); 
		//filter.setPageBean(pb);
		List<CmsSiteMenuContent>  list = cmsSiteMenuContentService.getBySqlKeyAll(filter, CmsSiteMenuContent.class, "getMenuid");
		 //request.setAttribute( "page_bean", pb );
		return new ModelAndView("/weixinform/aboutus/companyNewsList.jsp").addObject("cms", list);//.addObject( "page_bean", pb );
	}
	
	/**
	 * 新闻详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping({ "companyNewsDetails" })
	public ModelAndView companyNewsDetails(HttpServletRequest request,
			HttpServletResponse response) { 
		long id=Long.parseLong(request.getParameter("id"));
		CmsSiteMenuContent cms=cmsSiteMenuContentService.getById(id);
		return new ModelAndView("/weixinform/aboutus/companyNewsDetails.jsp").addObject("cms",cms);
	}
}
