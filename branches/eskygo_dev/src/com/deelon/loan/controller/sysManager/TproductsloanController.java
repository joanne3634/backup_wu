/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.controller.sysManager;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.productsloan.Tproductsloan;
import com.deelon.loan.service.sysManager.TauditmaterialsService;
import com.deelon.loan.service.sysManager.TproductsloanService;
import com.deelon.platform.model.system.Dictionary;
import com.deelon.platform.service.system.DictionaryService;

@ Controller
@ RequestMapping( { "/loan/sysManager/productloan/" } )
public class TproductsloanController extends BaseController{
	
	@ Resource
	private TproductsloanService tproductsloanService;
	@ Resource
	private DictionaryService dicService;
	@ Resource
	private TauditmaterialsService tmaterialService;
	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tproductsloan分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List<Tproductsloan> list = this.tproductsloanService.getAll(new QueryFilter(request, "tproductsloanItem"));
		ModelAndView mv = getAutoView().addObject( "tproductsloanList", list );
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除Tproductsloan数据")
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "productsLoanId" );
			this.tproductsloanService.delByIdsAndsublist( lAryId );
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
	@ Action( description = "编辑Tproductsloan数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "productsLoanId" ) );
		Tproductsloan tproductsloan = null;
		if ( pkId.longValue() != 0L )
			tproductsloan = (Tproductsloan) this.tproductsloanService.getTproductsloanAndThingsById( pkId );
		else
		{
			tproductsloan = new Tproductsloan();
		}
		List<Dictionary> dics = dicService.getByParentId(10000001600010L);//字典表的还款类型值
		request.setAttribute("materials", tmaterialService.getAll());
		request.setAttribute("dics", dics);
		return getAutoView().addObject( "tproductsloan", tproductsloan ).addObject( "productsLoanId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tproductsloan数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "productsLoanId" );
		Tproductsloan tproductsloan = (Tproductsloan) this.tproductsloanService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tproductsloan", tproductsloan );
	}
}

