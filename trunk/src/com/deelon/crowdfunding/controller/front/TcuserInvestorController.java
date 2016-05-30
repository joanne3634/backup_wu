package com.deelon.crowdfunding.controller.front;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.page.PageBean;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.servlet.ValidCode;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.TuserApplyLeader;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.backstage.TuserApplyLeaderService;
import com.deelon.loan.model.aboutus.TUserMsgRemind;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.service.aboutus.TUserMsgRemindService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TareaService;

/*
 * Powered By [hqx]
 * Since 2013 - 2014
 */



@ Controller
@ RequestMapping( { "/crowdfunding/tcuserInvestor/" } )
public class TcuserInvestorController extends BaseController{
	@ Resource
	private TUserService tuserService;
	@ Resource
	private TareaService tareaService;
	@Resource
	private TcprojectService tcprojectService;
	@ Resource
	private TUserMsgRemindService tuserMsgRemindService;
	
	@ Resource
	private TuserApplyLeaderService tuserApplyLeaderService;
	
	//投资人页面
	@ RequestMapping( { "tcuserInvestorPage" } )
	public ModelAndView tcuserInvestorPage( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		//获取省级地区
		QueryFilter query = new QueryFilter();
		query.addFilter("parentId", 1);
		query.addFilter("orderField", "order_code");
		query.addFilter("orderSeq", "desc");
		List<Tarea> arealist = tareaService.getAll(query);
		
		//推荐项
		query = new QueryFilter();
		query.addFilter("isRecommended", 1);
		query.addFilter("orderField", "order_code");
		query.addFilter("orderSeq", "desc");
		List<Tarea> areaisRecommendedlist = tareaService.getAll(query);
		
		//最新投资人
		query = new QueryFilter();
		query.addFilter("groupId", 2);  //投资人
		List<TUser> list = tuserService.getAll(query);
		
		//推荐投资人
		query = new QueryFilter();
		query.addFilter("isRecommended", 1);  
		query.addFilter("orderField", "RecommendedTime"); //根据推荐时间排序
		query.addFilter("orderSeq", "desc");   //倒序
		List<TUser> tuserisRecommendedlist = tuserService.getAll(query);
		
		//update by nicole  2015/4/22 投资人时隐藏自荐我的项目 start
		TUser u = TUserUtil.getLogUser(request);
		if(u!=null)
		{
		  TUser user = tuserService.getById(u.getUserId());
		
		  request.setAttribute( "curuser", user);//1为创业者 2为投资者
		}
		//update by nicole  2015/4/22 投资人时隐藏自荐我的项目 end
		
		/**/
		request.setAttribute("arealist", arealist);
		request.setAttribute("areaisRecommendedlist", areaisRecommendedlist);
		request.setAttribute("tuserList", list);
		request.setAttribute("tuserisRecommendedlist", tuserisRecommendedlist);
		return new ModelAndView("/crowdfunding/tuserInvestor/tuserInvestor.jsp");
	}
	
	
	//投资人列表
	@ RequestMapping( { "tcuserInvestorPageList" } )
	public ModelAndView tcuserInvestorPageList( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		//搜索条件参数
		String provincesId = request.getParameter("provincesId");
		String cityId = request.getParameter("cityId");
		String isCompanyAndLeader = request.getParameter("isCompanyAndLeader");
		String isLeader = request.getParameter("isLeader");
		String cityIds = request.getParameter("cityIds");
		
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
	    int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb = new PageBean(page, pageSize);
		QueryFilter queryFilter = new QueryFilter(request);
		queryFilter.setPageBean(pb);
		queryFilter.addFilter("groupId", 2);  //投资人
		
		//搜索条件参数         华丽的分割线 -------------------------------------------------------------------
		if(provincesId !=null){
			queryFilter.addFilter("provincesId", provincesId);  //省份
		}
		if(cityId !=null){
			queryFilter.addFilter("cityId", cityId);   //市区
		}
		if(isCompanyAndLeader !=null){
			queryFilter.addFilter("isCompany", 1);   //机构投资人
		}
		if(isLeader !=null){ //是否领投人
			queryFilter.addFilter("isLeader", isLeader);    
		}
		if(cityIds !=null){   //省份或市区
			queryFilter.addFilter("cityIds", cityIds);    
		}
		
		
		List<TUser> list = tuserService.getAll(queryFilter);
		
		//update by nicole  2015/4/22 投资人时隐藏自荐我的项目 start
		TUser u = TUserUtil.getLogUser(request);
		if(u!=null)
		{
		  TUser user = tuserService.getById(u.getUserId());
		
		  request.setAttribute( "curuser", user);//1为创业者 2为投资者
		}
		//update by nicole  2015/4/22 投资人时隐藏自荐我的项目 end
		
		/**/
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		request.setAttribute("investorList", list);
		return new ModelAndView("/crowdfunding/tuserInvestor/tuserInvestorList.jsp");
	}
	
	//投资人详情
	@ RequestMapping( { "tcuserInvestorPageDetails" } )
	public ModelAndView tcuserInvestorPageDetails( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		//参数
		String userId = request.getParameter("userId");
		
		TuserApplyLeader tuserApplyLeader = tuserApplyLeaderService.getLeaderInfoDetail(Long.valueOf(userId));
		
		request.setAttribute("tuserApplyLeader", tuserApplyLeader);
		return new ModelAndView("/crowdfunding/tuserInvestor/tuserApplyLeaderDetails.jsp");
	}
	
	//发送私信显示详情
	@ RequestMapping( { "tcuserMsgremindPageDetails" } )
	@ResponseBody
	public void tcuserMsgremindPageDetails( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		String userId = request.getParameter("userId");
		
		TUser tuser = this.tuserService.getById(Long.valueOf(userId));
		this.writeObjectToClient(tuser, response);
	}
	
	//自荐项目页面
	@ RequestMapping( { "zijianMyProjectPage" } )
	public ModelAndView zijianMyProjectPage( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		String receiverId = request.getParameter("receiverId");
		Long userId = TUserUtil.getLogUser(request).getUserId();  //当前用户Id
		TUser user = tuserService.getById(userId);
		String htmlContent = "";
		if("2".equals(user.getGroupId())){
			htmlContent = "对不起,投资人不能自荐项目!";
			request.setAttribute("htmlContent", htmlContent);
			return new ModelAndView("/crowdfunding/tuserInvestor/zijianMyProjectCapion.jsp"); 
		}else{
			//查询是否有可自荐的项目
			QueryFilter query = new QueryFilter();
			query.addFilter("creator", userId);  //项目创建人Id
			query.addFilter("popenDateEnd", new Date());   //开标时间
			query.addFilter("pcloseDateBegin", new Date()); //结束标时间
			//query.addFilter("pisCheck", 1);   //审核通过
			query.addFilter("pstateId", 3);   //3为询价众筹中
			query.addFilter("orderField", "CreateTime");  //按最新发布的项目排序
			query.addFilter("orderSeq", "desc");
			List list = tcprojectService.getAll(query);
			if(list == null || list.size() == 0){
				htmlContent = "对不起,你暂时没有审核通过的项目,<a style='color:blue;font-size:14px;' target='_parent' href=' " + request.getContextPath() + "/loan/myAccount/myaccountPage.ht'>点击这里</a>&nbsp;提交我的项目";
				request.setAttribute("htmlContent", htmlContent);
				return new ModelAndView("/crowdfunding/tuserInvestor/zijianMyProjectCapion.jsp"); 
			}else{
				TUser tuser=tuserService.getById(Long.valueOf(receiverId));
				request.setAttribute("receiverName", tuser.getLoginName());
				request.setAttribute("receiverId", receiverId);
				request.setAttribute("projectList", list);
				return new ModelAndView("/crowdfunding/tuserInvestor/zijianMyProject.jsp"); 
			}
		}
	}
	
}

