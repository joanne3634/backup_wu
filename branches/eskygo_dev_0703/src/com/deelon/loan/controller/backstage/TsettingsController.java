/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.controller.backstage;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
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

import com.deelon.loan.model.backstage.TSettings;
import com.deelon.loan.service.backstage.TSettingsService;

@ Controller
@ RequestMapping( { "/loan/backstage/tsettings/" } )
public class TsettingsController extends BaseController{
	
	@ Resource
	private TSettingsService tsettingsService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tsettings分页列表"  )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List list = this.tsettingsService.getAll(new QueryFilter(request, "tsettingsItem"));
		ModelAndView mv = getAutoView().addObject( "tsettingsList", list ).addObject("queryParam",request.getQueryString());
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除Tsettings数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "settingsId" );
			this.tsettingsService.delByIds( lAryId );
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
	@ Action( description = "编辑Tsettings数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "settingsId" ) );
		String typeId = String.valueOf( RequestUtil.getString( request, "typeId" ) );
		if(StringUtil.isEmpty(typeId)){
			typeId = String.valueOf( RequestUtil.getString( request, "Q_typeId_S" ) );
		}
		TSettings tsettings = null;
		if ( pkId.longValue() != 0L )
			tsettings = (TSettings) this.tsettingsService.getById( pkId );
		else
		{
			tsettings = new TSettings();
		}
		return getAutoView().addObject( "tsettings", tsettings ).addObject( "settingsId", pkId ).addObject("typeId",typeId);
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tsettings数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "settingsId" );
		TSettings tsettings = (TSettings) this.tsettingsService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tsettings", tsettings );
	}
	
	@ RequestMapping( { "updateOrderID" } )
	@ Action( description = "对Tsettings数据进行排序" )
	public void updateOrderID( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		String preUrl = RequestUtil.getPrePage( request );
		TSettings settings = new TSettings();
		Long[] settingsName=RequestUtil.getLongAryByStr(request,"settingsname");
		for (int i = 0;i<settingsName.length;i++) {
			settings.setSettingsId(settingsName[i]);
			settings.setOrderId(i+1);
			System.out.println("--->"+settings.getSetCode()+"--->"+settings.getOrderId());
			tsettingsService.updatePaiXu(settings);
		}
		response.sendRedirect(preUrl);
	}
}

