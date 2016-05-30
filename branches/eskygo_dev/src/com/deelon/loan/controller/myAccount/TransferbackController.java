package com.deelon.loan.controller.myAccount;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.page.PageBean;
import com.deelon.core.util.DateFormatUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.servlet.ValidCode;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.controller.front.view.ProjectDetailView;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserCompany;
import com.deelon.loan.model.front.TUserFamily;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.sysManager.TprojectAuction;
import com.deelon.loan.model.sysManager.TprojectTransfer;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.front.TuserCompanyService;
import com.deelon.loan.service.front.TuserFamilyService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.sysManager.TprojectAuctionService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.loan.service.sysManager.TprojectTransferService;

@Controller
@RequestMapping({ "/myAccount/" })
public class TransferbackController extends BaseController {
	@ Resource
	private TprojectInvestService tProjectInvestService;
	@ Resource
	private TprojectTransferService tprojectTransferService;
	@ Resource
	private UserInfoService userInfoService;
	@Autowired
	private TprojectService tprojectService;
	@Autowired
	private TUserService tUserService;
	@Autowired
	private TuserCompanyService companyService;
	@Autowired
	private TuserFamilyService familyService;
	@Autowired
	private TprojectAuctionService auctionService;
	/**
	 * 添加申请债权转让的记录
	 * @param request
	 * @param projectTransfer
	 * @return
	 */
	@RequestMapping({ "addTransferInfo" })
	@ResponseBody
	public Object addTransfer(HttpServletRequest request,TprojectTransfer projectTransfer) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		List<TProjectInvest> invests = tProjectInvestService.getmyCanTransfers(projectTransfer.getInvestId(),null,null,user.getUserId(),null);
		if(invests.get(0).getTransferId()>0){
			projectTransfer.setTransferId(invests.get(0).getTransferId());
		}
		return tprojectTransferService.addTransferApply(request.getParameter("transferpwd"), projectTransfer,user);
	}
	/**
	 * 债权转让后台列表的跳转和数据查询展现控制
	 * @param request
	 * @return
	 */
	@RequestMapping({ "transferback" })
	public ModelAndView transferback(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb=new  PageBean(page, pageSize);
		request.setAttribute("status", request.getParameter("status"));
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		request.setAttribute( "applyName", request.getParameter("applyName"));
		request.setAttribute( "pname", request.getParameter("pname"));
		if("b1".equals(request.getParameter("status"))){
			request.setAttribute("projectInvests", tProjectInvestService.getmyCanTransfers(null,request.getParameter("applyName"),request.getParameter("pname"),user.getUserId(),pb));//查询可以转让的债权
		}else if("b2".equals(request.getParameter("status"))){
			request.setAttribute("projectInvestings", tProjectInvestService.getmyTransferings("1",request.getParameter("applyName"),request.getParameter("pname"),user.getUserId(),null,pb));//查询转让中的债权
		}else if("b3".equals(request.getParameter("status"))){
			request.setAttribute("projectInvestover", tProjectInvestService.getmyTransferings("over",request.getParameter("applyName"),request.getParameter("pname"),user.getUserId(),null,pb));//查询转让结束的债权
		}else if("b4".equals(request.getParameter("status"))){
			request.setAttribute("projectInvested", tProjectInvestService.getmyTransferings("3",request.getParameter("applyName"),request.getParameter("pname"),user.getUserId(),null,pb));//查询转让失败的债权
		}else{
			request.setAttribute("projectInvests", tProjectInvestService.getmyCanTransfers(null,request.getParameter("applyName"),request.getParameter("pname"),user.getUserId(),pb));//查询可以转让的债权
		}
		return new ModelAndView("loan/myAccount/transferback.jsp");
	}
	/**
	 * 债权转让前台显示页面跳转控制
	 * @param request
	 * @return
	 */
	@RequestMapping({ "transfer" })
	public ModelAndView transfer(HttpServletRequest request) {
		 List<TProject> projects = tprojectService.getAllLoanByWhere(null,null);
			if(projects!=null&&projects.size()>0){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
				if(projects.get(0).getPupdateTime()!=null)
					request.setAttribute("lastUpdateTime", sdf.format(projects.get(0).getPupdateTime()));
				else
					request.setAttribute("lastUpdateTime", sdf.format(new Date()));
				
			}
		return new ModelAndView("loan/myAccount/transfer.jsp");
	}
	/**
	 * 债权转让列表展现控制
	 * @param request
	 * @return
	 */
	@RequestMapping({ "transferList" })
	public ModelAndView transferList(HttpServletRequest request) {
		QueryFilter queryFilter = new QueryFilter(request);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		queryFilter.addFilter("nowtime", dateFormat.format(new Date()));
		
		Object openDateBelowObj = queryFilter.getFilters().get("openDateBelow");
		if(openDateBelowObj!=null){
			int day = Integer.parseInt(openDateBelowObj.toString());
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -day);
			queryFilter.getFilters().put("openDateBelow", dateFormat.format(cal.getTime()));
		}
		Object openDateAboveObj = queryFilter.getFilters().get("openDateAbove");
		if(openDateAboveObj!=null){
			int day = Integer.parseInt(openDateAboveObj.toString());
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -day);
			queryFilter.getFilters().put("openDateAbove", dateFormat.format(cal.getTime()));
		}
		
		int page = RequestUtil.getInt(request, "current_page", 1);
	    int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb=new  PageBean(page, pageSize);
		queryFilter.setPageBean(pb);
		
		List<TprojectTransfer> list = tprojectTransferService.getBySqlKeyAll(queryFilter, TprojectTransfer.class, "getAllFront");
		if(list!=null){ //取头像图片
			for(TprojectTransfer tprojectTransfer:list){
				Date closeDate = tprojectTransfer.getCloseDate();
				String remainTime = "--";
				if(closeDate==null){
					tprojectTransfer.setRemainTime(remainTime);
					continue;
				}
				long time = closeDate.getTime() - new Date().getTime();
				time = time/1000;
				long days = time/(60*60*24);
				long hour = (time % (60*60*24))/(60*60);
				long min = (time % (60*60))/60;
				remainTime = days+"天"+hour+"小时"+min+"分";
				tprojectTransfer.setRemainTime(remainTime);
			}
		}
	         
		return new ModelAndView("loan/myAccount/transferList.jsp").addObject("tprojectTransferList", list).addObject( "page_bean", pb );
	}
	/**
	 * 竞标会员账户列表展示页面控制
	 * @param request
	 * @return
	 */
	@RequestMapping({ "auctionback" })
	public ModelAndView auctionback(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb=new  PageBean(page, pageSize);
		request.setAttribute("status", request.getParameter("status"));
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		request.setAttribute( "applyName", request.getParameter("applyName"));
		request.setAttribute( "pname", request.getParameter("pname"));
		if("b1".equals(request.getParameter("status"))){
			request.setAttribute("projectInvestings", tProjectInvestService.getmyTransferings("1",request.getParameter("applyName"),request.getParameter("pname"),null,user.getUserId(),pb));//查询转让中的债权
		}else if("b2".equals(request.getParameter("status"))){
			request.setAttribute("projectInvested", tProjectInvestService.getmyTransferings("2",request.getParameter("applyName"),request.getParameter("pname"),null,user.getUserId(),pb));//查询转让失败的债权
		}else{
			request.setAttribute("projectInvestings", tProjectInvestService.getmyTransferings("1",request.getParameter("applyName"),request.getParameter("pname"),null,user.getUserId(),pb));//查询可以转让的债权
		}
		return new ModelAndView("loan/myAccount/auctionback.jsp");
	}
	/**
	 * 竞标前台页面控制
	 * @param request
	 * @return
	 */
	@RequestMapping({ "auction" })
	public ModelAndView auction(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		TUserFunds tuf=userInfoService.getUserFundsInfo(user.getUserId());//.getAvailable();
		if(tuf!=null&&tuf.getAvailable()!=null){
			request.setAttribute("canUse", String.valueOf(tuf.getAvailable()));
			request.setAttribute("total", String.valueOf(tuf.getBalance()));
		}else{
			request.setAttribute("canUse","0.0");
		} 
		TprojectTransfer tt = tprojectTransferService.getTprojectTransferInfo(request.getParameter("transferId"));
		request.setAttribute("loanTotal", tt.getClaimsSum());
		request.setAttribute("priceLow", tt.getUpsetPrice());
		request.setAttribute("type", tt.getAuctionWay());
		if("1".equals(tt.getAuctionWay())){
			request.setAttribute("highestPrice", tt.getHightestPrice());
		}
		request.setAttribute("transferId", tt.getTransferId());
		request.setAttribute("closeDate", request.getParameter("closeDate"));
		return new ModelAndView("loan/myAccount/auction.jsp");
	}
	/**
	 * 竞标会员撤销其竞标记录的请求控制
	 * @param request
	 * @return
	 */
	@RequestMapping({ "cancelauction" })
	@ResponseBody
	public Object cancelauction(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		JSONObject json = new JSONObject();
		try {
			tprojectTransferService.cacelTransferAciton(Long.parseLong(request.getParameter("transferId")), user.getUserId());
			json.put("result", "撤销竞标记录成功.");
		}catch (Exception e) {
			json.put("result", "撤销数据失败，系统异常.");
		}
		return json;
	}
	/**
	 * 债权转让记录详情前台展现
	 * @param request
	 * @return
	 */
	@RequestMapping({ "transferDetails" })
	public ModelAndView transferDetails(HttpServletRequest request) {
		long transferId = RequestUtil.getLong(request, "transferId");
		if(transferId!=0){
			TprojectTransfer transfer = tprojectTransferService.getById(transferId);
			request.setAttribute("transfer", transfer); //转让信息
			request.setAttribute("endTime", DateFormatUtil.format(transfer.getCloseDate(),"yyyy/MM/dd HH:mm:ss"));
			request.setAttribute("nowTime", DateFormatUtil.format(new Date(),"yyyy/MM/dd HH:mm:ss"));
			if(transfer!=null){
				TProject project = tprojectService.getById(transfer.getProjectId());
				TProject tproject = tprojectService.getProjectByIdandUserId(transfer.getProjectId(),project.getPapplicant());
				request.setAttribute("loanTime", project.getPdeadline()-(null==transfer.getPrCurrent()? 0:transfer.getPrCurrent()));
				request.setAttribute("project", project); //工程信息
				if(project !=null){
					TUser bUser = tUserService.getById(project.getPapplicant()); //借款用户信息
					request.setAttribute("bUser", bUser);
					List<TProjectInvest> invests = tProjectInvestService.getTprojectInvestByProId(project.getProjectId(), null);
					request.setAttribute("invests", invests); //投资记录
//					QueryFilter userilter = new QueryFilter();
//					userilter.addFilter("userId", project.getPapplicant());
//					
//					List<TUserCompany> userCompanyList = companyService.getAll(userilter);
//					TUserCompany userCompany = null;
//					if(userCompanyList!=null && userCompanyList.size()>0){
//						userCompany = userCompanyList.get(0);
//					}
//					request.setAttribute("userCompany", userCompany); //借款用户公司信息
//					
//					List<TUserFamily> userFamilyList = familyService.getAll(userilter);
//					TUserFamily userFamily = null;
//					if(userFamilyList!=null && userFamilyList.size()>0){
//						userFamily = userFamilyList.get(0);
//					}
//					request.setAttribute("userFamily", userFamily); //贷款用户家庭信息
					ProjectDetailView pdv = new ProjectDetailView();
					// 借款标的金额信息
					pdv.setProjectId(tproject.getProjectId()+"");
					pdv.setLoan(String.valueOf(tproject.getPloan()));
					pdv.setRateOut(String.valueOf(tproject.getPrateOut()));
					pdv.setComplete(tproject.getPcomplete()+"");
					pdv.setRepayWay(tproject.getPrepayWay());
					pdv.setpName(tproject.getPname());
					pdv.setDeadline(String.valueOf(tproject.getPdeadline()));
					pdv.setLoanReal(String.valueOf(tproject.getPloanReal()));
					pdv.setIsbreakNum(tproject.getIsbreakNum());
					pdv.setSuccessNum(tproject.getSuccessNum());
					pdv.setProDesc(tproject.getPdesc());
					
					if(project.getPminInvest()==null)
						pdv.setPminInvest("100");
					else
						pdv.setPminInvest(project.getPminInvest()+"");
					//System.out.println(project.getPloan());
					//System.out.println(project.getPloanReal());
					
					// 计算还需金额
					String payLoan = String.valueOf(project.getPloan().subtract(
							project.getPloanReal()));

					pdv.setPayLoan(payLoan);
					TUser proUser = tUserService.getUserInfoForDetail(project.getPapplicant());
					// 贷款用户的详细信息
					if(null!=proUser){
						pdv.setFiledId(proUser.getFiledId());
						pdv.setUserId(String.valueOf(proUser.getUserId()));
						pdv.setLoginName(proUser.getLoginName());
						pdv.setUserName(proUser.getRealName());
						pdv.setAge(String.valueOf(proUser.getAge()));
						pdv.setSchool(proUser.getSchool());
						pdv.setEdu(proUser.getEdu());
						pdv.setMarriage(proUser.getFMarriage());
						pdv.setCpyTrade(proUser.getCIndustry());
						pdv.setCpySize(proUser.getCSize());
						pdv.setPost(proUser.getCDeptName());
						pdv.setWorkCity(proUser.getCAddress());
						pdv.setWorkTime(proUser.getCWorkYears());
						pdv.setSalary(proUser.getCIncomeScope());
						pdv.setIsBuyCar(proUser.getFIsBuyCar());
						pdv.setIsBuyCarLoan(proUser.getFisCarLoan() + "");
						pdv.setIsHouse(proUser.getFHouse());
						pdv.setIsHouseLoan(proUser.getFisHouseLoan() + "");
						pdv.setCreditIn(proUser.getCreditIn());
						pdv.setCreditOut(proUser.getCreditOut());
					}
					request.setAttribute("pdv", pdv);
				}
				
				List<TprojectAuction> auctions = auctionService.getByTransferId(transfer.getTransferId());
				if(auctions!=null){
					request.setAttribute("auctionCount", auctions.size()); //总竞拍数
				}else{
					request.setAttribute("auctionCount", 0); //总竞拍数
				}
				request.setAttribute("auctions", auctions); //竞拍列表
			}
		}
		return new ModelAndView("loan/myAccount/transferDetails.jsp");
	}
	/**
	 * 竞标新增记录请求控制
	 * @param transferAction
	 * @param request
	 * @return
	 */
	@RequestMapping({ "addTransferAction" })
	@ResponseBody
	public Object addTransferAction(TprojectAuction transferAction,HttpServletRequest request) {
		JSONObject json = new JSONObject();
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		String code = request.getParameter("validCode");
		String validCode = (String)request.getSession().getAttribute(ValidCode.getSessionName_Randcode());
        if ((validCode == null) || (org.apache.commons.lang.StringUtils.isEmpty(code)) || (!validCode.equalsIgnoreCase(code)))
        {
        	json.put("result","验证码输入有误");
        	return json;
        }
        //取得模块和操作名称存入日志
        String modelName = request.getParameter("ModelName");
        String actionName = request.getParameter("ActionName");
        
		return tprojectTransferService.addorupdateTprojectAction(request,transferAction,request.getParameter("transferpwd"), user, request.getParameter("type"),Integer.valueOf(modelName),Integer.valueOf(actionName));
	}
	/**
	 * 检查用户是否存在竞标记录的请求控制
	 * @param transferAction
	 * @param request
	 * @return
	 */
	@RequestMapping({ "checkTransferAction" })
	@ResponseBody
	public Object checkTransferAction(TprojectAuction transferAction,HttpServletRequest request) {
		JSONObject json = new JSONObject();
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		List<TprojectAuction> olds = tprojectTransferService.getTprojectAuctionExsit(transferAction.getTransferId(), user.getUserId());
		if(null!=olds&&olds.size()>0){
			json.put("result", "此债权转让您已经有竞标信息存在，请确定是否继续竞标。如果继续将撤销你上次投标信息以本次投标为准。");
			return json;
		}
		return json;
	}
	
}
