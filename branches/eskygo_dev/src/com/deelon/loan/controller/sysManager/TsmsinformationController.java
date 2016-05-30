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
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.sysManager.TsmsinformationService;


import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@ Controller
@ RequestMapping( { "/loan/sysManager/tsmsinformation/" } )
public class TsmsinformationController extends BaseController{
	
	@ Resource
	private TsmsinformationService tsmsinformationService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tsmsinformation分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List<Tsmsinformation> list = this.tsmsinformationService.getAll(new QueryFilter(request, "tsmsinformationItem"));
		ModelAndView mv = getAutoView().addObject( "tsmsinformationList", list );
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除Tsmsinformation数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "infoId" );
			this.tsmsinformationService.delByIds( lAryId );
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
	@ Action( description = "编辑Tsmsinformation数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "infoId" ) );
		Tsmsinformation tsmsinformation = null;
		if ( pkId.longValue() != 0L )
			tsmsinformation = (Tsmsinformation) this.tsmsinformationService.getById( pkId );
		else
		{
			tsmsinformation = new Tsmsinformation();
		}
		return getAutoView().addObject( "tsmsinformation", tsmsinformation ).addObject( "infoId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tsmsinformation数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "infoId" );
		Tsmsinformation tsmsinformation = (Tsmsinformation) this.tsmsinformationService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tsmsinformation", tsmsinformation );
	}
}

