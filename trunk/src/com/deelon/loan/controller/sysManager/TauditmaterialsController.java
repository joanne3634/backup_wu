/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.controller.sysManager;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.sysManager.Tauditmaterials;
import com.deelon.loan.service.sysManager.TauditmaterialsService;
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
@ RequestMapping( { "/loan/sysManager/tauditmaterials/" } )
public class TauditmaterialsController extends BaseController{
	
	@ Resource
	private TauditmaterialsService tauditmaterialsService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tauditmaterials分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List list = this.tauditmaterialsService.getAll(new QueryFilter(request, "tauditmaterialsItem"));
		ModelAndView mv = getAutoView().addObject( "tauditmaterialsList", list );
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除Tauditmaterials数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "materialsId" );
			this.tauditmaterialsService.delByIds( lAryId );
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
	@ Action( description = "编辑Tauditmaterials数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "materialsId" ) );
		Tauditmaterials tauditmaterials = null;
		if ( pkId.longValue() != 0L )
			tauditmaterials = (Tauditmaterials) this.tauditmaterialsService.getById( pkId );
		else
		{
			tauditmaterials = new Tauditmaterials();
		}
		return getAutoView().addObject( "tauditmaterials", tauditmaterials ).addObject( "materialsId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tauditmaterials数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "materialsId" );
		Tauditmaterials tauditmaterials = (Tauditmaterials) this.tauditmaterialsService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tauditmaterials", tauditmaterials );
	}
}

