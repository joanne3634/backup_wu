/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.controller.backstage;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.service.system.DemensionService;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.service.front.TareaService;

@ Controller
@ RequestMapping( { "/loan/backstage/tarea/" } )
public class TareaController extends BaseController{
	
	@ Resource
	private TareaService tareaService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tarea分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		String parentId=request.getParameter("parentId");
		String Q_areaName_S = request.getParameter("Q_areaName_S");
		String Q_areaZip_S = request.getParameter("Q_areaZip_S");
		String Q_areaCode_S = request.getParameter("Q_areaCode_S");
		String Q_isRecommended_S = request.getParameter("Q_isRecommended_S");
		QueryFilter queryFiler = new QueryFilter(request, "tareaItem");
		//queryFiler.addFilter("parentId", parentId);
		//if("".equals(Q_areaName_S) && "".equals(Q_areaZip_S) && "".equals(Q_areaCode_S) && "".equals(Q_isRecommended_S)){
			//queryFiler.addFilter("parentId", 1);
		//}	
		List<Tarea> list = this.tareaService.getAll(queryFiler);
		ModelAndView mv = getAutoView().addObject( "tareaList", list );
		return mv;
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "listM" } )
	@ Action( description = "查看Tarea分页列表")
	public ModelAndView listM( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		String parentId=request.getParameter("parentId");
		String areaId=request.getParameter("areaId");
		QueryFilter queryFiler = new QueryFilter(request, "tareaItem");
		queryFiler.addFilter("parentId", parentId);
		queryFiler.addFilter("areaId", areaId);
		List<Tarea> list = this.tareaService.getAll();
		ModelAndView mv = getAutoView().addObject( "tareaList", list );
		return mv;
	}
	
	@ RequestMapping( { "del" } )
	@ Action( description = "删除Tarea数据")
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "areaId" );
			this.tareaService.delByIds( lAryId );
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
	@ Action( description = "编辑Tarea数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "areaId" ) );
		Tarea tarea = null;
		if ( pkId.longValue() != 0L )
			tarea = (Tarea) this.tareaService.getById( pkId );
		else
		{
			tarea = new Tarea();
		}
		QueryFilter queryFiler = new QueryFilter();
		queryFiler.addFilter("Tarea_level", "1,2");
		List<Tarea> list = tareaService.getAll(queryFiler);  //显示省份和市区的下拉
		
		
		return getAutoView().addObject( "tarea", tarea ).addObject( "areaId", pkId ).addObject("tareaList", list);
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tarea数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "areaId" );
		Tarea tarea = (Tarea) this.tareaService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tarea", tarea );
	}
	
	/**
	 *跳转到树的页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "tree" } )
	@ Action( description = "查看CmsSiteMenu树列表" )
	public ModelAndView tree( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		return getAutoView();
	}
	
	/**
	 * 获得区域树
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@ RequestMapping( { "getTareaMenuTree" } )
	@ ResponseBody
	public Object getTareaMenuTree( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{   
		String parentId = RequestUtil.getString( request, "parentId" );
		QueryFilter qf = new QueryFilter( request, false );
		List<Long> curUserRole = new ArrayList();
		qf.addFilter( "parentId", parentId );
		return tareaService.getAll( qf );
	}
}

