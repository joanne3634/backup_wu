/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.controller.backstage;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.DateFormatUtil;
import com.deelon.core.util.DateUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectInvestService;

@ Controller
@ RequestMapping( { "/crowdfunding/backstage/tcprojectinvest/" } )
public class TcprojectInvestController extends BaseController{
	
	@ Resource
	private TcprojectInvestService tcprojectInvestService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看询价审核TcprojectInvest分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		QueryFilter qf = new QueryFilter(request, "tcprojectInvestItem");
		qf.addFilter("piisCancel", "0");//没有撤销的投资记录
		/*if(!StringUtil.isEmpty(request.getParameter("Q_piinvestTime_DL"))){
			qf.addFilter("piinvestTimeBegin", DateUtil.parseDate(request.getParameter("Q_piinvestTime_DL")+" 00:00:00"));
			qf.addFilter("piinvestTimeEnd", DateUtil.parseDate(request.getParameter("Q_piinvestTime_DL")+" 23:59:59"));
		} */
		if(!StringUtil.isEmpty(request.getParameter("Q_piinvestTimeS_DL")) && !StringUtil.isEmpty(request.getParameter("Q_piinvestTimeE_DL"))){
			qf.addFilter("piinvestTimeBegin", DateUtil.parseDate(request.getParameter("Q_piinvestTimeS_DL")+" 00:00:00"));
			qf.addFilter("piinvestTimeEnd", DateUtil.parseDate(request.getParameter("Q_piinvestTimeE_DL")+" 23:59:59"));
		} 
		
		List<TcprojectInvest> list = this.tcprojectInvestService.getAll(qf); 
		ModelAndView mv = getAutoView().addObject( "tcprojectInvestList", list );
		return mv;
	}
	@ RequestMapping( { "toPayInvestMoneyList" } )
	@ Action( description = "查看待付款TcprojectInvest分页列表")
	public ModelAndView toPayInvestMoneyList( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		QueryFilter qf = new QueryFilter(request, "tcprojectInvestItem");
		qf.addFilter("piisCancel", "0");//没有撤销的投资记录
		qf.addFilter("piisCheck", "1");//已经被项目方审核通过的
		qf.addFilter("piisPay", "0");//还未付款的
		List<TcprojectInvest> list = this.tcprojectInvestService.getAll(qf);
		return new ModelAndView("/crowdfunding/backstage/toPayInvestMoneyList.jsp")
				.addObject("tcprojectInvestList",list);
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看TcprojectInvest数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "investId" );
		TcprojectInvest tcprojectInvest = (TcprojectInvest) this.tcprojectInvestService.getById( Long.valueOf( pkId ) );
		String preurl = "";
		if("1".equals(request.getParameter("list"))){
			preurl = "list";
		}else if("2".equals(request.getParameter("list"))) {//投资人支付查询
			preurl="paidlist";
		}else{
				preurl = "paylist";
		}

		return getAutoView().addObject( "tcprojectInvest", tcprojectInvest ).addObject("preurl", preurl);
	}
	
	@ RequestMapping( { "paylist" } )
	@ Action( description = "查看单个项目投资人付款TcprojectInvest分页列表")
	public ModelAndView paylist( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		QueryFilter qf = new QueryFilter(request, "tcprojectInvestItem");
		qf.addFilter("projectId", request.getParameter("project"));//投资项目id
		qf.addFilter("piisCancel", "0");//没有撤销的投资记录
		if(!StringUtil.isEmpty(request.getParameter("Q_pipayTime_DL"))){
			qf.addFilter("pipayTimeBegin", DateUtil.parseDate(request.getParameter("Q_pipayTime_DL")+" 00:00:00"));
			qf.addFilter("pipayTimeEnd", DateUtil.parseDate(request.getParameter("Q_pipayTime_DL")+" 23:59:59"));
		} 
		List<TcprojectInvest> list = this.tcprojectInvestService.getAll(qf); 
		ModelAndView mv = getAutoView().addObject( "tcprojectInvestList", list ).addObject("preurl", "/loan/sysManager/tcproject/list.ht");
		return mv;
	}

	@ RequestMapping( { "paidlist" } )
	@ Action( description = "查看已付款的TcprojectInvest分页列表")
	public ModelAndView paidlist( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		QueryFilter qf = new QueryFilter(request, "tcprojectInvestItem");
		qf.addFilter("piisCancel", "0");//没有撤销的投资记录
		qf.addFilter("piisCheck", "1");//已经被项目方审核通过的
		qf.addFilter("piisPay", "1");//已付款的
		if(!StringUtil.isEmpty(request.getParameter("Q_pipayTime_DL"))){
			qf.addFilter("pipayTimeBegin", DateUtil.parseDate(request.getParameter("Q_pipayTime_DL")+" 00:00:00"));
			qf.addFilter("pipayTimeEnd", DateUtil.parseDate(request.getParameter("Q_pipayTime_DL")+" 23:59:59"));
		}
		List<TcprojectInvest> list = this.tcprojectInvestService.getAll(qf);
		request.setAttribute("paidlist","paidlist");
		return new ModelAndView("/crowdfunding/backstage/tcprojectinvestList.jsp")
				.addObject("tcprojectInvestList",list);
	}
	@RequestMapping({ "getInvestDetailLeadById" })
	@Action(description = "查看投资信息")
	public ModelAndView getInvestDetailLeadById(HttpServletRequest request) {
		String investId = request.getParameter("investId");
		TcprojectInvest tcprojectInvest=null;
		List<TcprojectInvest> tcprojectInvestList= tcprojectInvestService.getInvestDetailById(investId);
		if(tcprojectInvestList!=null && tcprojectInvestList.size()>0){
			tcprojectInvest = tcprojectInvestList.get(0);
		}
		return new ModelAndView("/crowdfunding/front/investLeadDetail.jsp")
		.addObject("tcprojectInvest",tcprojectInvest);
	}
	@RequestMapping({ "getInvestDetailFollowById" })
	@Action(description = "查看投资信息")
	public ModelAndView getInvestDetailFollowById(HttpServletRequest request) {
		String investId = request.getParameter("investId");
		TcprojectInvest tcprojectInvest=null;
		List<TcprojectInvest> tcprojectInvestList= tcprojectInvestService.getInvestDetailById(investId);
		if(tcprojectInvestList!=null && tcprojectInvestList.size()>0){
			tcprojectInvest = tcprojectInvestList.get(0);
		}
		return new ModelAndView("/crowdfunding/front/investFollowDetail.jsp")
		.addObject("tcprojectInvest",tcprojectInvest);
	}
}

