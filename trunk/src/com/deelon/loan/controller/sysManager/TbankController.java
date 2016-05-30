package com.deelon.loan.controller.sysManager;




import com.deelon.core.annotion.Action;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.sysManager.Tbank;
import com.deelon.loan.service.sysManager.TbankService;
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
@ RequestMapping( { "/loan/sysManager/tbank/" } )
public class TbankController extends BaseController{
	
	@ Resource
	private TbankService tbankService;

	/**
	 * 列表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tbank分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List list = this.tbankService.getAllOther(new QueryFilter(request, "tbankItem"));
		ModelAndView mv = getAutoView().addObject( "tbankList", list );
		return mv;
	}

	/**
	 * 删
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@ RequestMapping( { "del" } )
	@ Action( description = "删除Tbank数据")
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "bankId" );
			this.tbankService.delByIds( lAryId );
			message = new ResultMessage( 1, "删除数据成功" );
		}
		catch ( Exception e )
		{
			message = new ResultMessage( 0, "删除数据失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}

	/**
	 * 跳编辑页面
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑Tbank数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "bankId" ) );
		
		Tbank tbank = null;
		if ( pkId.longValue() != 0L )
			tbank = (Tbank) this.tbankService.getById( pkId );
		else
		{
			tbank = new Tbank();
		}
		return getAutoView().addObject( "tbank", tbank ).addObject( "bankId", pkId );
	}
	
	/**
	 * 跳编辑页面
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "add" } )
	@ Action( description = "编辑Tbank数据")
	public ModelAndView add( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "bankId" ) );
		
		Tbank tbank = null;
		if ( pkId.longValue() != 0L )
			tbank = (Tbank) this.tbankService.getById( pkId );
		else
		{
			tbank = new Tbank();
		}
		return new ModelAndView("/loan/sysManager/tbankAdd.jsp").addObject( "tbank", tbank ).addObject( "bankId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tbank数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "bankId" );
		Tbank tbank = (Tbank) this.tbankService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tbank", tbank );
	}
}

