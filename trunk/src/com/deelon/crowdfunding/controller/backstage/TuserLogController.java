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

import com.deelon.loan.model.TuserLog;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.operationLog.TuserLogService;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@ Controller
@ RequestMapping( { "/crowdfunding/backstage/tuserlog/" } )
public class TuserLogController extends BaseController{
	
	@ Resource
	private TuserLogService tuserLogService;
	@ Resource
	private TUserService tcuserService;

	@SuppressWarnings("rawtypes")
	@ RequestMapping( { "list" } )
	@ Action( description = "查看TuserLog分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List<TuserLog> list = this.tuserLogService.getAll(new QueryFilter(request, "tuserLogItem"));
		List userList = this.tcuserService.getAll();
		ModelAndView mv = getAutoView().addObject( "tuserLogList", list ).addObject("userList", userList);
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除TuserLog数据")
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "loginLogId" );
			this.tuserLogService.delByIds( lAryId );
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
	@ Action( description = "编辑TuserLog数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "loginLogId" ) );
		TuserLog tuserLog = null;
		if ( pkId.longValue() != 0L )
			tuserLog = (TuserLog) this.tuserLogService.getById( pkId );
		else
		{
			tuserLog = new TuserLog();
		}
		return getAutoView().addObject( "tuserLog", tuserLog ).addObject( "loginLogId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看TuserLog数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "loginLogId" );
		TuserLog tuserLog = (TuserLog) this.tuserLogService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tuserLog", tuserLog );
	}
}

