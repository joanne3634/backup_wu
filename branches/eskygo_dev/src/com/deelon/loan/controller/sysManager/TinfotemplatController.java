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
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.service.system.DemensionService;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.loan.model.sysManager.Tinfotemplat;
import com.deelon.loan.model.sysManager.Tinfotemplatparam;
import com.deelon.loan.service.sysManager.TinfotemplatService;
import com.deelon.loan.service.sysManager.TinfotemplatparamService;

@ Controller
@ RequestMapping( { "/loan/sysManager/tinfotemplat/" } )
public class TinfotemplatController extends BaseController{
	
	@ Resource
	private TinfotemplatService tinfotemplatService;
	@ Resource
	private TinfotemplatparamService tinfotemplatparamService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tinfotemplat分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List list = this.tinfotemplatService.getAll(new QueryFilter(request, "tinfotemplatItem"));
		ModelAndView mv = getAutoView().addObject( "tinfotemplatList", list );
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除Tinfotemplat数据")
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "infoTemplateId" );
			this.tinfotemplatService.delByIds( lAryId );
			
			for(Long id:lAryId){ //删除模块参数
				tinfotemplatparamService.delBySqlKey("delByTemplateId", id, Tinfotemplatparam.class);
			}
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
	@ Action( description = "编辑Tinfotemplat数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "infoTemplateId" ) );
		Tinfotemplat tinfotemplat = null;
		if ( pkId.longValue() != 0L )
			tinfotemplat = (Tinfotemplat) this.tinfotemplatService.getById( pkId );
		else
		{
			tinfotemplat = new Tinfotemplat();
		}
		return getAutoView().addObject( "tinfotemplat", tinfotemplat ).addObject( "infoTemplateId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tinfotemplat数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "infoTemplateId" );
		Tinfotemplat tinfotemplat = (Tinfotemplat) this.tinfotemplatService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tinfotemplat", tinfotemplat );
	}
}

