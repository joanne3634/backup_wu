package com.deelon.crowdfunding.controller.front;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;















import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteConfig;
import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectComments;
import com.deelon.crowdfunding.model.backstage.TcprojectNews;
import com.deelon.crowdfunding.service.backstage.TcprojectCommentsService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.backstage.TprojectNewsService;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TUserService;
import com.fr.report.core.A.l;

@Controller
@RequestMapping({ "/tcproject/ProjectComments/" })
public class ProjectCommentsController extends BaseFormController{

	@Resource
	private TcprojectCommentsService tcprojectCommentsService;
	@Resource
	private TcprojectService tcprojectService;
	@Resource
	private TUserService tUserService;
	
	@RequestMapping({ "ProjectCommentsicList" })
	@Action( description = "项目评论" )
	public ModelAndView ProjectDynamicList(HttpServletRequest request,
			HttpServletResponse response) { 
		QueryFilter filter = new QueryFilter();
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",4);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		TUser u = TUserUtil.getLogUser( request );
		List<Tcproject> list = tcprojectService.getProjectByUserId(u.getUserId());
		 request.setAttribute( "page_bean", pb);
		return new ModelAndView("/crowdfunding/front/ProjectComments.jsp")
				.addObject("TPCList", list)
				.addObject( "page_bean", pb )
				.addObject( "size", list.size());
	}
	
	@RequestMapping({ "ProjectCommentsDetails" })
	@Action( description = "项目评论详情" )
	public ModelAndView ProjectCommentsicDetails(HttpServletRequest request,
			HttpServletResponse response) { 
		QueryFilter filter = new QueryFilter();
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",2);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		Long commentsId = Long.valueOf( RequestUtil.getLong( request, "commentsId" ) );
		TcprojectComments tcprojectComments = tcprojectCommentsService.getById(commentsId);
		List<TcprojectComments> list = tcprojectCommentsService.getByCommentsId(filter,commentsId);
		TUser user = tUserService.getById(tcprojectComments.getCreator());
		request.setAttribute( "page_bean", pb);
		return new ModelAndView("/crowdfunding/front/ProjectCommentsDetails.jsp")
				.addObject("TPCList", list)
				.addObject("tcprojectComments", tcprojectComments)
				.addObject( "page_bean", pb )
				.addObject( "user", user );
	}
	
	@RequestMapping({ "ProjectCommentsReply" })
	@Action( description = "项目评论回复" )
	@ResponseBody
	public String ProjectCommentsReply(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			Long commentsId = Long.valueOf( RequestUtil.getLong( request, "commentsId" ) );
			Long projectId = Long.valueOf( RequestUtil.getLong( request, "projectId" ) );
			String content = RequestUtil.getString( request, "pccontent" );
			TcprojectComments tcprojectComments = new TcprojectComments();
			tcprojectComments.setCommentsId(UniqueIdUtil.genId());
			tcprojectComments.setProjectId(projectId);
			tcprojectComments.setPctypeID(2);
			tcprojectComments.setPcparentD(commentsId);
			tcprojectComments.setPccontent(content);
			TUser u = TUserUtil.getLogUser( request );
			tcprojectComments.setCreator(u.getUserId());
			tcprojectComments.setCreteTime(new Date());
			tcprojectCommentsService.add(tcprojectComments);
			return "0";
		} catch (Exception e) {
			e.printStackTrace();
			return "1";
		}
	}

	@ RequestMapping( { "delete" } )
	@ Action( description = "删除项目评论" )
	@ResponseBody
	public String del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "commentsId" );//接受页面返回的Id
			this.tcprojectCommentsService.delByIds( lAryId );		//通过Id删除对应数据
			return "0";		//返回页面的提示信息
		}
		catch ( Exception e )
		{
			return "1";
		}
	}
}
