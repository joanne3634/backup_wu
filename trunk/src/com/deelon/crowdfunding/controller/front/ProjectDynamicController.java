package com.deelon.crowdfunding.controller.front;


import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectNews;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.backstage.TprojectNewsService;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.util.HtmlRegexpUtil;

@Controller
@RequestMapping({ "/tcproject/ProjectDynamic/" })
public class ProjectDynamicController extends BaseController{

	@Resource
	private TprojectNewsService tprojectNewsService;
	@Resource
	private TcprojectService tcprojectService;
	
	@RequestMapping({ "ProjectDynamicList" })
	@Action( description = "项目动态" )
	public ModelAndView ProjectDynamicList(HttpServletRequest request,
			HttpServletResponse response) { 
		QueryFilter filter = new QueryFilter();
		filter.addFilter("orderField", "ViewCount");
		filter.addFilter("orderSeq", "desc");
		List<TcprojectNews>  list2 = tprojectNewsService.getAllByCount(filter);
		for (TcprojectNews t:list2) {
			System.out.println(t.getPntitle());
		}
		filter = new QueryFilter();
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",10);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<TcprojectNews>  list = tprojectNewsService.getAllByTypeId(filter);
		for (TcprojectNews t:list) {
			t.setPncontent(HtmlRegexpUtil.filterHtml(t.getPncontent()));
			System.out.println(t.getPntitle());
		}
		return new ModelAndView("/crowdfunding/front/ProjectDynamic.jsp")
				.addObject("TCPList", list)
				.addObject("TCPList2", list2)
				.addObject( "page_bean", pb );
	}
	
	@RequestMapping({ "ProjectNewList" })
	@Action( description = "项目所有动态页" )
	public ModelAndView ProjectNewList(HttpServletRequest request,
			HttpServletResponse response) { 
		QueryFilter filter = new QueryFilter();
		Long projectId = Long.valueOf( RequestUtil.getLong( request, "projectId" ) );
		List<TcprojectNews>  list2 = tprojectNewsService.getAllByCount(filter);
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",10);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		filter.addFilter("projectId", projectId);
		List<TcprojectNews>  list = tprojectNewsService.getAllByTypeId(filter);
		for (TcprojectNews t:list) {
			t.setPncontent(HtmlRegexpUtil.filterHtml(t.getPncontent()));
		}
		 request.setAttribute( "page_bean", pb);
		return new ModelAndView("/crowdfunding/front/ProjectDynamic.jsp").addObject("TCPList", list)
				.addObject("TCPList2", list2)
				.addObject( "page_bean", pb ).addObject("projectId", projectId);
	}
	
	@ RequestMapping( { "edit" } )
	@ Action( description = "项目动态正文" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception {
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "newsId" ) );
		TcprojectNews t = tprojectNewsService.getById(pkId);
		t.setViewCount(((int)t.getViewCount()+1));
		tprojectNewsService.update(t);
		TcprojectNews tcprojectNews = null;
		QueryFilter filter = new QueryFilter();
		filter.addFilter("orderField", "ViewCount");
		filter.addFilter("orderSeq", "desc");
		List<TcprojectNews>  list2 = tprojectNewsService.getAllByCount(filter);
		if ( pkId.longValue() != 0L ){
			tcprojectNews = (TcprojectNews) this.tprojectNewsService.getByNewId( pkId );
		}else {
			tcprojectNews = new TcprojectNews();
		}
		return new ModelAndView("/crowdfunding/front/ProjectDynamicDetails.jsp")
			.addObject( "tcprojectNews", tcprojectNews )
			.addObject("TCPList2", list2)
			.addObject( "newsId", pkId );
	}
	
	@RequestMapping({ "ProjectDynamicBackList" })
	@Action( description = "项目管理项目动态" )
	public ModelAndView ProjectDynamicBackList(HttpServletRequest request,
			HttpServletResponse response) { 
		QueryFilter filter = new QueryFilter();
		TUser u = TUserUtil.getLogUser( request );
		filter.addFilter("creator", u.getUserId());
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",3);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<Tcproject> list2 = tcprojectService.getAll(filter);
		HashMap map =new HashMap();
		map.put("creator", u.getUserId());
		List<TcprojectNews>  list = tprojectNewsService.getTcprojectNewsCr(map);
		for (TcprojectNews t:list) {
			t.setPncontent(HtmlRegexpUtil.filterHtml(t.getPncontent()));
		}	
		return new ModelAndView("/crowdfunding/front/ProjectDynamicBack.jsp")
				.addObject("TCPList", list)
				.addObject("TCPList2", list2)
				.addObject("size", list2.size())
				.addObject( "page_bean", pb );
	}
	
	@ RequestMapping( { "delete" } )
	@ Action( description = "删除项目动态" )
	@ResponseBody
	public String del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "newsId" );//接受页面返回的Id
			System.out.println("----------------->"+lAryId[0]);
			this.tprojectNewsService.update_isDel( lAryId );		//通过Id删除对应数据
			return "0";		//返回页面的提示信息
		}
		catch ( Exception e )
		{
			return "1";
		}
	}
	
	@ RequestMapping( { "editProjectDynamic" } )
	@ Action( description = "编辑项目动态数据" )
	public ModelAndView editProjectDynamic( HttpServletRequest request ) throws Exception {
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "newsId" ) );
		Long projectId = Long.valueOf( RequestUtil.getLong( request, "projectId" ) );
		TcprojectNews tcprojectNews = null;
		Tcproject tcproject = (Tcproject) tcprojectService.getById(projectId);
		if ( pkId.longValue() != 0L )
			tcprojectNews = (TcprojectNews) this.tprojectNewsService.getById( pkId );
		else {
			return new ModelAndView("/crowdfunding/front/AddProjectDynamicBack.jsp")
			.addObject( "tcproject", tcproject );
		}
		return new ModelAndView("/crowdfunding/front/AddProjectDynamicBack.jsp")
			.addObject( "tcprojectNews", tcprojectNews )
			.addObject( "newsId", pkId )
			.addObject( "tcproject", tcproject );
	}
}
