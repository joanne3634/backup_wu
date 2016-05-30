package com.deelon.crowdfunding.controller.front;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.servlet.ValidCode;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TuserApplyLeader;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.backstage.TuserApplyLeaderService;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.aboutus.TUserMsgRemind;
import com.deelon.loan.model.front.TBankcard;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.service.aboutus.TUserMsgRemindService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TareaService;
import com.deelon.loan.service.front.TbankcardService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.TuserFundsService;

/*
 * Powered By [hqx]
 * Since 2013 - 2014
 * 会员中心  -- - -个人资料模块  -- controller
 */



@ Controller
@ RequestMapping( { "/crowdfunding/tcuserPersonalData/" } )
public class TuserPersonalDataController extends BaseController{
	@ Resource
	private TUserService tuserService;
	@ Resource
	private TuserSafeService tuserSafeService;
	@ Resource
	private TuserFundsService tuserFundsService;
	@ Resource
	private TareaService tareaService;
	@ Resource
	private TcprojectService tcprojectService;//项目主表
	@Resource
	private TbankcardService tbankcardService;
	
	
	@Action(description="安全中心")
	@RequestMapping({ "accountSafeCenter" })
	public ModelAndView accountSafeCenter(HttpServletRequest request,HttpServletResponse response){
		
		Long userId = TUserUtil.getLogUser(request).getUserId();
		TUser user = tuserService.getById(userId);
		TUserSafe userSafe = tuserSafeService.getUserSafeByUserId(userId);
		
		
		return new ModelAndView("/crowdfunding/front/anquanzhongxin.jsp").addObject("user", user).addObject("userSafe", userSafe);
		
		
	}
	
	@Action(description="个人中心  - 修改基本资料功能 ")
	@RequestMapping({ "editAccountData" })
	@ResponseBody
	public void editAccountData(HttpServletRequest request,
			HttpServletResponse response,TUser user,TUserSafe userSafe) throws JsonGenerationException, JsonMappingException, IOException {
		
		Long userId = TUserUtil.getLogUser(request).getUserId();
		TUser u = tuserService.getById(userId);
		TUserSafe uSafe = tuserSafeService.getUserSafeByUserId(userId);
		
		//String code = request.getParameter("code");
		//String validCode = (String)request.getSession().getAttribute(ValidCode.getSessionName_Randcode());
        //if ((validCode == null) || (org.apache.commons.lang.StringUtils.isEmpty(code)) || (!validCode.equals(code)))
       // {
        //	logger.info("验证码输入有误");
       // 	this.writeObjectToClient("验证码驶入有误", response);
       // }
		
		//修改 TUserSafe 数据
		uSafe.setEmail(userSafe.getEmail());
		uSafe.setMobile(userSafe.getMobile());
		
		//修改 TUser 数据
		System.out.println(user.getRemarks());
		u.setRemarks(user.getRemarks());
		if("2".equals(u.getGroupId())){ //投资
			u.setProvincesId(user.getProvincesId());
			u.setCityId(user.getCityId());
			if(u.getIsCompany() == 1){ //机构投资
				u.setContactName(user.getContactName());
			}else{
				u.setRealName(user.getRealName());
			}
		}else{   //创业者
			u.setRealName(user.getRealName());
		}
		u.setPersonalAddress(user.getPersonalAddress());
		
		try {
			tuserService.update(u);
			tuserSafeService.update(uSafe);
			this.writeObjectToClient("修改成功", response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	@Action(description="个人中心  - 修改登录密码功能跳转页面")
	@RequestMapping({ "changeAccountPwdPage" })
	public ModelAndView changeAccountPwdPage(HttpServletRequest request,
			HttpServletResponse response) {
		
		return new ModelAndView("/crowdfunding/front/changePwd.jsp");
	}
	
	@Action(description="个人中心  - 修改登录密码功能")
	@RequestMapping({ "changeAccountPwd" })
	@ResponseBody
	public void changeAccountPwd(HttpServletRequest request,
			HttpServletResponse response) throws UserException, JsonGenerationException, JsonMappingException, IOException {
		String beforePwd = request.getParameter("beforePwd");   //原始密码
		String newPwd = request.getParameter("newPwd");			//新密码
		String reNewPwd = request.getParameter("reNewPwd");		//确认密码
		Long userId = TUserUtil.getLogUser(request).getUserId();  //当前用户Id
		

		String result = tuserService.updateLoginPwd(userId, beforePwd, newPwd, reNewPwd);
		
		this.writeObjectToClient(result, response);
	}
	@Action(description="个人中心  - 修改交易密码功能跳转页面")
	@RequestMapping({ "changeAccountTradingPwdPage" })
	public ModelAndView changeAccountTradingPwdPage(HttpServletRequest request,
			HttpServletResponse response) {
		
		return new ModelAndView("/crowdfunding/front/changeTradingPwd.jsp");
	}
	
	@Action(description="个人中心  - 修改交易密码功能")
	@RequestMapping({ "changeAccountTradingPwd" })
	@ResponseBody
	public void changeAccountTradingPwd(HttpServletRequest request,
			HttpServletResponse response) throws UserException, JsonGenerationException, JsonMappingException, IOException {
		String beforePwd = request.getParameter("beforePwd");   //原始密码
		String newPwd = request.getParameter("newPwd");			//新密码
		String reNewPwd = request.getParameter("reNewPwd");		//确认密码
		Long userId = TUserUtil.getLogUser(request).getUserId();  //当前用户Id
		

		String result = tuserService.updateTradePwd(userId, beforePwd, newPwd, reNewPwd);
		
		this.writeObjectToClient(result, response);
	}
	
	
	
	@Action(description="个人中心首页")
	@RequestMapping({ "myAccount" })
	public ModelAndView myAccount(HttpServletRequest request,
			HttpServletResponse response) {
		TUser u = TUserUtil.getLogUser(request);
		TUser tuser = tuserService.getById(u.getUserId());  //用户
		TUserSafe userSafe = tuserSafeService.getUserSafeByUserId(u.getUserId());  //安全
		TUserFunds tuserFunds = tuserFundsService.getByUserId(u.getUserId()); //资金
		List<TBankcard> list = tbankcardService.getTBankcardByUserId(u.getUserId());  //是否绑定了银行卡
		long safePlan = 0;
		//获取省级地区
		QueryFilter query = new QueryFilter();
		query.addFilter("parentId", 1);
		query.addFilter("orderField", "order_code");
		query.addFilter("orderSeq", "desc");
		List<Tarea> arealist = tareaService.getAll(query);
		
		request.setAttribute("tuser", tuser);
		request.setAttribute("userSafe", userSafe);
		request.setAttribute("arealist", arealist);
		request.setAttribute("tuserFunds", tuserFunds);
		if(list.size() > 0){
			request.setAttribute("isbindkcard", "isbindkcard");
		}
		if(userSafe!=null){
			if(userSafe.getBindEmail() == 1){ //进度条显示
				safePlan += 25;
			}
			if(userSafe.getBindIdNo() == 1){ 
				safePlan += 25;
			}
			if(userSafe.getBindMobile() == 1){ 
				safePlan += 25;
			}
			if(!"".equals(userSafe.getA1())){ 
				safePlan += 25;
			}
		}
		request.setAttribute("safePlan", safePlan);  //根据绑定信息来显示进度条
		if("1".equals(u.getGroupId())){   //创业者
			if(StringUtil.isNotEmpty(request.getParameter("personal"))){
				//待处理，创业者修改个人信息
				return new ModelAndView("/crowdfunding/front/investorCenterIndex.jsp");
			}
			Tcproject tcproject = null;
			String projectId = request.getParameter("projectId");
			if(StringUtil.isEmpty(projectId)){
				projectId = "0";
				query = new QueryFilter();
				query.addFilter("creator", tuser.getUserId());
				List<Tcproject> lists =  tcprojectService.getAll(query);
				if(null!=lists&&lists.size()>0){
					for(Tcproject project:lists){//if用户有多个项目，则编辑只能选择最新的，且未完成融资的项目
					//	if("7".endsWith(project.getPstateId())||"1".endsWith(project.getPstateId())||"2".endsWith(project.getPstateId())||"3".endsWith(project.getPstateId())){
						if("9".endsWith(project.getPstateId())||"0".endsWith(project.getPstateId())||"1".endsWith(project.getPstateId())||"3".endsWith(project.getPstateId())){
							if(Long.valueOf(projectId).compareTo(project.getProjectId())<0){
								projectId = project.getProjectId()+"";
								tcproject = project;
							}
						} 
					}
					if(projectId.equals("0")){//如果没有申请中的项目，则进入到编辑新项目的页面
						return new ModelAndView("redirect:/crowdfunding/tcproject/editorTcproject.ht");
					}
				}else{
					return new ModelAndView("redirect:/crowdfunding/tcproject/editorTcproject.ht");
				}
			}else{
				projectId = request.getParameter("projectId");
				tcproject = tcprojectService.getById(Long.parseLong(projectId));
			}
			tcprojectService.getProjcteDetail(request,projectId);
			//如果是房产类型则跳到房产的页面
			if("3".equals(tcproject.getPtypeId())){
				return new ModelAndView("/crowdfunding/front/entrepreneurCenterIndexHouse.jsp").addObject("tcproject", tcproject);
			}
			return new ModelAndView("/crowdfunding/front/entrepreneurCenterIndex.jsp").addObject("tcproject", tcproject);
		}else {// 投资者
			if(StringUtil.isNotEmpty(request.getParameter("personal"))){
				return new ModelAndView("/crowdfunding/front/investorCenterIndex.jsp");
			}
			//String url ="/crowdfunding/front/investorCenterIndex.jsp";//现在投资者默认跳转到项目管理菜单列表
			//return new ModelAndView("/crowdfunding/front/investorCenterIndex.jsp");
			return new ModelAndView("redirect:/crowdfunding/front/tcprojectinvest/getProjectLeadAndVote.ht");
		}	
	}

}

