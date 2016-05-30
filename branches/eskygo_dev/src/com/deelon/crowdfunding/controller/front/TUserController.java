package com.deelon.crowdfunding.controller.front;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.page.PageBean;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.loan.model.aboutus.TUserMsgRemind;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.aboutus.TUserMsgRemindService;
import com.deelon.loan.service.front.TUserService;

/**
 * 
 * czz
 */
@Controller
@RequestMapping({ "/crowdfunding/tuser/" })
public class TUserController extends BaseController {

	@Autowired
	private TUserService tUserService;
	@Autowired
	private TcprojectService tcprojectService;
	@Autowired
	private TUserMsgRemindService tUserMsgRemindService;

	@RequestMapping({ "investorInfo" })
	public ModelAndView investorInfo(HttpServletRequest request) {
		Long projectId=RequestUtil.getLong( request, "projectId" );
		TUser tuserLead=null;
		List<TUser> tuserFollowList=null;
		
		Tcproject tcproject = null;
		if (projectId.longValue() != 0L){
			tcproject=tcprojectService.getById(projectId);
			tuserLead=tUserService.getLeadInvestor(projectId);
			tuserFollowList=tUserService.getUserByFollowProject(projectId);
		}

		return new ModelAndView("/crowdfunding/front/investorInfo.jsp")
		.addObject("tuserLead",tuserLead).addObject("tcproject",tcproject)
		.addObject("tuserFollowList",tuserFollowList);
		
	}
	
	/*@RequestMapping({ "investorInfo" })
	public ModelAndView investorInfo(HttpServletRequest request) {
		Long projectId=RequestUtil.getLong( request, "projectId" );
		List<TUser> tuserList=null;
		if (projectId.longValue() != 0L){
			tuserList=tUserService.getAllInvestorByProjectId(projectId);
		}

		return new ModelAndView("/crowdfunding/front/investorInfo.jsp")
		.addObject("tuserList",tuserList);
		
	}*/
	
	@RequestMapping({ "investorList" })
	public ModelAndView investorList(HttpServletRequest request) {
		String realName = RequestUtil.getString(request, "realName");
		String school = RequestUtil.getString(request, "school");
		
		//分页加参数
		QueryFilter filter = new QueryFilter();
		//filter.addFilter("userId", getSessionUser(request).getUserId());
		filter.addFilter("realName", realName);
		filter.addFilter("school", school);
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",3);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<TUser> investorList=tUserService.getAllInvestorList(filter);
		request.setAttribute("realName", realName);
		request.setAttribute("school", school);
		return new ModelAndView("/crowdfunding/front/investorList.jsp")
		.addObject("investorList",investorList).addObject( "page_bean", pb );
		
	}
	
	@RequestMapping({ "investorProjectList" })
	public ModelAndView investorProjectList(HttpServletRequest request) {
		//String pname = RequestUtil.getString(request, "pname");
		//String ptypeId = RequestUtil.getString(request, "ptypeId");
		
		//分页加参数
		QueryFilter filter = new QueryFilter();
		filter.addFilter("creator", TUserUtil.getLogUser(request).getUserId());
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",5);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<Tcproject> tcprojectList=tcprojectService.getProjectCr(filter);
		request.setAttribute( "page_bean", pb);//分页参数传入页面
		return new ModelAndView("/crowdfunding/front/investorProjectList.jsp")
		.addObject("tcprojectList",tcprojectList).addObject( "page_bean", pb );
		
	}
	
	@RequestMapping({ "investorDetail" })
	public ModelAndView investorDetail(HttpServletRequest request) {
		Long userId=RequestUtil.getLong( request, "userId" );
		TUser tuser=null;
		if (userId.longValue() != 0L){
			tuser=tUserService.getById(userId);
		}

		return new ModelAndView("/crowdfunding/front/investorDetail.jsp")
		.addObject("tuser",tuser);
		
	}
	
	
	/*
	 * 发私信对话框
	 
	@RequestMapping({ "sendMsgDialog" })
	public ModelAndView sendMsgDialog(HttpServletRequest request) {
		Long userId=RequestUtil.getLong( request, "userId" );
		TUser tuser=null;
		if (userId.longValue() != 0L){
			tuser=tUserService.getById(userId);
		}

		return new ModelAndView("/crowdfunding/front/sendMsgDialog.jsp")
		.addObject("tuser",tuser);
		
	}
	
	
	 * 发送内容
	 
	@RequestMapping({ "sendMsgContent" })
	public ModelAndView sendMsgContent(HttpServletRequest request,HttpServletResponse response ) throws Exception{
		Long userId=RequestUtil.getLong( request, "userId" );
		String msgContent=RequestUtil.getString( request, "msgContent" );
		String result="0";
		try{
			TUserMsgRemind tUserMsgRemind = new TUserMsgRemind();
			Long id = Long.valueOf(UniqueIdUtil.genId());
			tUserMsgRemind.setMsgRemindId(id);
			tUserMsgRemind.setTypeId(1);
			tUserMsgRemind.setSenderId(getSessionUser(request).getUserId());
			tUserMsgRemind.setSendTime(new Date());
			tUserMsgRemind.setContent(msgContent);
			tUserMsgRemind.setReceiverId(userId);
			tUserMsgRemind.setStateId(0);

			tUserMsgRemindService.add(tUserMsgRemind);
			result="1";
		}catch(Exception e){
			e.printStackTrace();
		}
		response.getWriter().write(result);
		return null;
		
	}*/
	

	
	
}
