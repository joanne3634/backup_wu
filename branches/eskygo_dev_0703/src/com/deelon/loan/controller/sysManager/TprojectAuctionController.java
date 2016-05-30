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
import com.deelon.loan.model.sysManager.TprojectAuction;
import com.deelon.loan.service.sysManager.TprojectAuctionService;

@ Controller
@ RequestMapping( { "/loan/sysManager/tprojectauction/" } )
public class TprojectAuctionController extends BaseController{
	
	@ Resource
	private TprojectAuctionService tprojectAuctionService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看TprojectAuction分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List list = this.tprojectAuctionService.getAll(new QueryFilter(request, "tprojectAuctionItem"));
		ModelAndView mv = getAutoView().addObject( "tprojectAuctionList", list );
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除TprojectAuction数据")
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "auctionId" );
			this.tprojectAuctionService.delByIds( lAryId );
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
	@ Action( description = "编辑TprojectAuction数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "auctionId" ) );
		TprojectAuction tprojectAuction = null;
		if ( pkId.longValue() != 0L )
			tprojectAuction = (TprojectAuction) this.tprojectAuctionService.getById( pkId );
		else
		{
			tprojectAuction = new TprojectAuction();
		}
		return getAutoView().addObject( "tprojectAuction", tprojectAuction ).addObject( "auctionId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看TprojectAuction数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "auctionId" );
		TprojectAuction tprojectAuction = (TprojectAuction) this.tprojectAuctionService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tprojectAuction", tprojectAuction );
	}
}

