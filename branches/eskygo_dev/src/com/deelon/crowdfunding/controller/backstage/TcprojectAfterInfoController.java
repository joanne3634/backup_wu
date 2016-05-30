package com.deelon.crowdfunding.controller.backstage;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.model.backstage.TcprojectAfter;
import com.deelon.crowdfunding.service.backstage.TcprojectAfterService;
import com.deelon.crowdfunding.service.backstage.TcprojectAttachmentService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;

@Controller
@RequestMapping({ "/crowdfunding/tcprojectAfterInfo/" })
public class TcprojectAfterInfoController  extends BaseController{
	@Autowired
	private TcprojectService tcprojectService;
	@Autowired
	private TcprojectAfterService tcprojectAfterService;
	@Autowired
	TcprojectAttachmentService tcprojectAttachmentService;
	
	@ RequestMapping( { "list" } )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		QueryFilter queryFilter = new QueryFilter(request, "tprojectAfterItem");
		Map map = queryFilter.getFilters();
		String paTypeId = (String)map.get("paTypeId");
		List<TcprojectAfter> list = tcprojectAfterService.getProjectAfter(queryFilter);
		ModelAndView mv = new ModelAndView("crowdfunding/backstage/tcprojectAfterInfoList.jsp")
		.addObject( "tcprojectAfterList", list )
		.addObject( "paTypeId", paTypeId );
		return mv;
	}
	
	@ RequestMapping( { "del" } )
	@ Action( description = "删除tcprojectAfter数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "afterId" );
			this.tcprojectAfterService.delByIds( lAryId );
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
	@ Action( description = "编辑tcprojectAfter数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "afterId" ) );
		String type = request.getParameter("type");
		TcprojectAfter tcprojectAfter = null;
		if ( pkId.longValue() != 0L )
			tcprojectAfter = tcprojectAfterService.getById( pkId );
		else
		{
			tcprojectAfter = new TcprojectAfter();
		}
		return  new ModelAndView("crowdfunding/backstage/tcprojectAfterInfoEdit.jsp")
				.addObject( "tcprojectAfter", tcprojectAfter )
				.addObject( "afterId", pkId );
	}

	@ RequestMapping( { "get" } )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "afterId" );
		TcprojectAfter tcprojectAfter = tcprojectAfterService.getById( pkId );
		return new ModelAndView("crowdfunding/backstage/tcprojectAfterInfoGet.jsp")
				.addObject( "tcprojectAfter", tcprojectAfter );
	}

}
