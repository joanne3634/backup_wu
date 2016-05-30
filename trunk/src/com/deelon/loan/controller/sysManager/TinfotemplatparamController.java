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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.loan.model.sysManager.Tinfotemplatparam;
import com.deelon.loan.service.sysManager.TinfotemplatparamService;

@ Controller
@ RequestMapping( { "/loan/sysManager/tinfotemplatparam/" } )
public class TinfotemplatparamController extends BaseController{
	
	@ Resource
	private TinfotemplatparamService tinfotemplatparamService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tinfotemplatparam分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List list = this.tinfotemplatparamService.getAll(new QueryFilter(request, "tinfotemplatparamItem"));
		ModelAndView mv = getAutoView().addObject( "tinfotemplatparamList", list );
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除Tinfotemplatparam数据")
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "infoTemplatParamId" );
			this.tinfotemplatparamService.delByIds( lAryId );
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
	@ Action( description = "编辑Tinfotemplatparam数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		return getAutoView();
	}
	@ RequestMapping( { "edit2" } )
	@ Action( description = "编辑Tinfotemplatparam数据")
	public ModelAndView edit2( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "infoTemplatParamId" ) );
		Tinfotemplatparam tinfotemplatparam = null;
		if ( pkId.longValue() != 0L )
			tinfotemplatparam = (Tinfotemplatparam) this.tinfotemplatparamService.getById( pkId );
		else
		{
			tinfotemplatparam = new Tinfotemplatparam();
		}
		return getAutoView().addObject( "tinfotemplatparam", tinfotemplatparam ).addObject( "infoTemplatParamId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tinfotemplatparam数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		List<Tinfotemplatparam> list = tinfotemplatparamService.getBySqlKeyAll(new QueryFilter(request), Tinfotemplatparam.class, "getByComboId");
		Tinfotemplatparam tinfotemplatparam = null;
		if(list.size()>0)
			tinfotemplatparam = list.get(0);
		else
			tinfotemplatparam = new Tinfotemplatparam();
		return getAutoView().addObject( "tinfotemplatparam", tinfotemplatparam );
	}
	
	@RequestMapping({"getAllByInfoTemplatId"})
	@ResponseBody
	@ Action( description = "异步查询，根据模板ID查询所有相关模板参数")
	public Object getAllByInfoTemplatId(HttpServletRequest request){
		List<Tinfotemplatparam> list = tinfotemplatparamService.getAll(new QueryFilter(request));
		return list;
	}
	
	@RequestMapping("delById")
	@ResponseBody
	@ Action( description = "通过ID异步删除")
	public Object delById(HttpServletRequest request){
		ResultMessage message = null;
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "infoTemplatParamId" );
			this.tinfotemplatparamService.delByIds( lAryId );
			message = new ResultMessage( 1, "删除数据成功" );
		}
		catch ( Exception e )
		{
			message = new ResultMessage( 0, "删除数据失败" );
		}
		return message;
	}
}

