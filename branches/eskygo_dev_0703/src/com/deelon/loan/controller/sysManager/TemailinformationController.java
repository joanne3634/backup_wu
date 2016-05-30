package com.deelon.loan.controller.sysManager;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */




import com.deelon.core.annotion.Action;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.sysManager.Temailinformation;
import com.deelon.loan.service.sysManager.TemailinformationService;
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
@ RequestMapping( { "/loan/sysManager/temailinformation/" } )
public class TemailinformationController extends BaseController{
	
	@ Resource
	private TemailinformationService temailinformationService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看Temailinformation分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List list = this.temailinformationService.getAll(new QueryFilter(request, "temailinformationItem"));
		ModelAndView mv = getAutoView().addObject( "temailinformationList", list );
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除Temailinformation数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "infoId" );
			this.temailinformationService.delByIds( lAryId );
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
	@ Action( description = "编辑Temailinformation数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "infoId" ) );
		Temailinformation temailinformation = null;
		if ( pkId.longValue() != 0L )
			temailinformation = (Temailinformation) this.temailinformationService.getById( pkId );
		else
		{
			temailinformation = new Temailinformation();
		}
		return getAutoView().addObject( "temailinformation", temailinformation ).addObject( "infoId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Temailinformation数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "infoId" );
		Temailinformation temailinformation = (Temailinformation) this.temailinformationService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "temailinformation", temailinformation );
	}
}

