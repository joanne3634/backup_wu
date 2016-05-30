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
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectInvestService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.service.system.DemensionService;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@ Controller
@ RequestMapping( { "/loan/sysManager/tcproject/" } )
public class TcprojectController extends BaseController{
	
	@ Resource
	private TcprojectService tcprojectService;
	@ Resource
	private TcprojectInvestService tcprojectInvestService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tcproject分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List list = this.tcprojectService.getAll(new QueryFilter(request, "tcprojectItem"));
		List<Tcproject> tcProjectList = this.tcprojectService.getAll();
		ModelAndView mv = getAutoView().addObject( "tcprojectList", list ).addObject("tcProjectList", tcProjectList);
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除Tcproject数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "projectId" );
			this.tcprojectService.delByIds( lAryId );
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
	@ Action( description = "编辑Tcproject数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "projectId" ) );
		Tcproject tcproject = null;
		if ( pkId.longValue() != 0L )
			tcproject = (Tcproject) this.tcprojectService.getById( pkId );
		else
		{
			tcproject = new Tcproject();
		}
		return getAutoView().addObject( "tcproject", tcproject ).addObject( "projectId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tcproject数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "projectId" );
		Tcproject tcproject = (Tcproject) this.tcprojectService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tcproject", tcproject );
	}
	
	
	@ RequestMapping( { "getInvest" } )
	@ Action( description = "查看TcprojectInvest数据")
	public ModelAndView getInvest( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "projectId" );
		QueryFilter queryFilter = new QueryFilter(request);
		queryFilter.addFilter("projectId", pkId);
		List list = this.tcprojectInvestService.getAll(queryFilter);
		TcprojectInvest tcprojectInvest = null;
		if(list.size() >0){
			tcprojectInvest = (TcprojectInvest) list.get(0);
		}
		
		return new ModelAndView("/loan/sysManager/tcprojectinvestGet.jsp").addObject( "tcprojectInvest", tcprojectInvest );
	}
}

