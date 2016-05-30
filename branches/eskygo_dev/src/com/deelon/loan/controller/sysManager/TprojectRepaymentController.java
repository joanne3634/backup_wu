package com.deelon.loan.controller.sysManager;

import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TprojectRepaymentDao;
import com.deelon.loan.model.front.TProjectRepayment;
import com.deelon.loan.service.sysManager.TprojectService;
@ Controller
@ RequestMapping( { "/loan/sysManager/tprojectRepayment/" } )
public class TprojectRepaymentController extends BaseController{
	@ Resource
	private TprojectRepaymentDao tprojectRepaymentDao;
	@Autowired
	private TprojectService tProjectService;
	
	@ RequestMapping( { "list" } )
	@ Action( description = "查看Tproject分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List<TProjectRepayment> list = this.tprojectRepaymentDao.getAll(new QueryFilter(request, "tprojectRepaymentItem"));
		ModelAndView mv = getAutoView().addObject( "tprojectRepaymentList", list ).addObject("queryParam",request.getQueryString());
		return mv;
	}
	
	@ RequestMapping( { "repayment" } )
	@ ResponseBody
	public JSONObject repayment( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		String projectId = request.getParameter("projectId");
		String repaymentId = request.getParameter("repaymentId");
		String paypwd = request.getParameter("pwd");
		return tProjectService.repaymenting(projectId,repaymentId,paypwd,null);
	}
}