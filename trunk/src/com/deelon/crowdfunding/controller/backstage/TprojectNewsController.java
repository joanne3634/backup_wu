package com.deelon.crowdfunding.controller.backstage;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */




import com.deelon.core.annotion.Action;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;



import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectNews;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.backstage.TprojectNewsService;



import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@ Controller
@ RequestMapping( { "/loan/sysManager/tprojectnews/" } )
public class TprojectNewsController extends BaseController{
	
	@ Resource
	private TprojectNewsService tprojectNewsService;
	
	@ Resource
	private TcprojectService tcprojectService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看TprojectNews分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		QueryFilter queryFilter = new QueryFilter(request, "tprojectNewsItem");
		String type = request.getParameter("type");  //项目类型   1 项目动态  2项目披露
		if(type !=null){
			queryFilter.addFilter("pntypeId", type);
		}
		queryFilter.addFilter("isDel", 0);	
		List<TcprojectNews> list = this.tprojectNewsService.getAll(queryFilter);
		//List<Tcproject> tcProjectList = this.tcprojectService.getAll();
		ModelAndView mv = getAutoView().addObject( "tprojectNewsList", list ).addObject("type", type);
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除TprojectNews数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "newsId" );
			this.tprojectNewsService.delByIds( lAryId );
			message = new ResultMessage( 1, "删除数据成功" );
		}
		catch ( Exception e )
		{
			message = new ResultMessage( 0, "删除数据失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}

	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑TprojectNews数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "newsId" ) );
		String type = request.getParameter("type");  //项目类型   1 项目动态  2项目披露
		TcprojectNews tprojectNews = null;
		if ( pkId.longValue() != 0L )
			tprojectNews = (TcprojectNews) this.tprojectNewsService.getById( pkId );
		else
		{
			tprojectNews = new TcprojectNews();
		}
		List<Tcproject> tcProjectList = this.tcprojectService.getAll();
		return getAutoView().addObject( "tprojectNews", tprojectNews ).addObject( "newsId", pkId ).addObject("tcProjectList", tcProjectList).addObject("type", type);
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看TprojectNews数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "newsId" );
		TcprojectNews tprojectNews = (TcprojectNews) this.tprojectNewsService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tprojectNews", tprojectNews );
	}
	
	
	
	
	
	
	//设置是否显示在前台
	@ RequestMapping( { "delShow" } )
	@ Action( description = "设置是否显示在前台状态" )
	public void delShow( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "newsId" );
			this.tprojectNewsService.update_isDel(lAryId);
			message = new ResultMessage( 1, "删除成功" );
		}
		catch ( Exception e )
		{
			message = new ResultMessage( 0, "删除失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}
}

