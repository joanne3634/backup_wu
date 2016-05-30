package com.deelon.crowdfunding.controller.backstage.projectfunding;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.loan.service.front.TareaService;
/**
 * 所有的众筹项目
 * @author verry
 *
 */
@Controller
@RequestMapping( { "/crowdfunding/backstage/allProject/" } )
public class AllProjectController extends BaseController {
	@Resource
	private TcprojectService tcprojectService;
	@Autowired
	private TareaService tareaService;
	
	@RequestMapping( { "list" } )
	@Action( description = "查看Tproject分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		
		List<Tcproject> list = tcprojectService.getAll(new QueryFilter(request, "projectId"));
		ModelAndView mv = getAutoView().addObject( "tprojectList", list ).addObject("list", tareaService.getbyParentId(1));;
		return mv;
	}

}
