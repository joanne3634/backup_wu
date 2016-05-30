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
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.service.sysManager.TprojectService;

@ Controller
@ RequestMapping( { "/loan/sysManager/tproject/" } )
public class TprojectController extends BaseController{
	@ Resource
	private TprojectService tprojectService;
	
	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tproject分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List<TProject> list = this.tprojectService.getAll(new QueryFilter(request, "tprojectItem"));
		ModelAndView mv = getAutoView().addObject( "tprojectList", list ).addObject("queryParam",request.getQueryString());
		return mv;
	}


	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tproject数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "projectId" );
		TProject tproject = (TProject) this.tprojectService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tproject", tproject );
	}
	
}

