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
 * @author Administrator
 *@version合作机构
 * 
 */

 
@Controller
@RequestMapping({ "/site/CooperatingAgency/" })
public class CooperatingAgencyController {
	
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "CooperatingAgencyList" })
	@ Action( description = "合作机构分页显示" )
	public ModelAndView MediaReportList(HttpServletRequest request,
			HttpServletResponse response) {  
		QueryFilter filter = new QueryFilter();
		filter.addFilter("menu_path", "HZJG"); //传入合作机构栏目编码"HZJG"
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",16);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<CmsSiteMenuContent>  list = cmsSiteMenuContentService.getBySqlKeyAll(filter, CmsSiteMenuContent.class, "getMenuid");
		 request.setAttribute( "page_bean", pb );
		return new ModelAndView("/loan/aboutus/CooperatingAgencyList.jsp").addObject(
				"cms", list).addObject( "page_bean", pb );
	}
}
