package com.deelon.loan.controller.front;


import java.io.IOException;
import java.math.BigDecimal;
import java.net.InetAddress;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.controller.front.view.ProjectDetailView;
import com.deelon.loan.dao.sysManager.TprojectRepaymentDao;
import com.deelon.loan.exception.ProjectException;
import com.deelon.loan.model.aboutus.TUserMsgRemind;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserAuditMat;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.front.TUserAuditMatService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.front.TuserTaskcompleteService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.operationLog.TuserLogService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.platform.model.system.SysAuditModelType;
import com.fr.base.core.UUID;
import com.ibm.db2.jcc.am.re;

@Controller
@RequestMapping({ "/project/" })
@Action(ownermodel = SysAuditModelType.USER_MANAGEMENT)
public class ProjectController extends BaseFormController{

	@Autowired
	private TprojectService tProjectService;
	
	@Autowired
	private TprojectRepaymentDao tProjectRepayService;

	@Autowired
	private TUserService tUserService;

	@Autowired
	private TuserSafeService tuserSafeService;

	@Autowired
	private UserInfoService userInfoService;
	
	@Resource
	private TprojectInvestService tprojectInvestService;
	@Resource
	private TUserAuditMatService tuserAuditMatService;
	
	@Resource
	private TuserTaskcompleteService tuserTaskcompleteService;

	@Resource
	private TuserLogService tuserLogService;
	
	/**
	 * 保存借款项目
	 * 
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping({ "saveProject" })
	public ModelAndView saveTProject(TProject project,HttpServletRequest request) throws Exception {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		project.setPstatusId("1");//新申请  状态下的贷款
		project.setPtypeId("");
		project.setPcertifiLevel("");
		project.setPclerk("");
		project.setPloanReal(new BigDecimal(0));
		project.setPrateOut(new BigDecimal(0));
		project.setPcomplete(0);
		project.setPbided(0);
		project.setPviewed(0);
		project.setPapplicant(user.getUserId());
		project.setPapplicationTime(new Date());
		project.setPupdateTime(new Date());
		project.setPhavedPay(new Short("0"));
		project.setPauditPlatform(new Short("0"));
		project.setPisFull(new Short("0"));
		project.setPisBreak(new Short("0"));
		project.setPbreakTimes(0);
		project.setPisSetup(new Short("0"));
		project.setPisLate(new Short("0"));
		project.setPlateDays(0);
		project.setPisPayOff(new Short("0"));
		project.setPsumPayBack(new BigDecimal(0));
		project.setPsumInterest(new BigDecimal(0));
		project.setPsumHavedPay(new BigDecimal(0));
		project.setPsumLate(new BigDecimal(0));
		project.setPsumLateHavedPay(new BigDecimal(0));
		project.setPdel(new Short("0"));
		project.setPrateOut(project.getPrateIn().subtract(new BigDecimal(AppUtil.getServletContext().getAttribute("RATEIN_RATEOUT").toString())));
		if(null==project.getPloan()||StringUtil.isEmpty(project.getPname())||StringUtil.isEmpty(project.getPrepayWay())){//如果新增的项目关键信息为空则不插入数据库
			return null;
		}else{
			tProjectService.saveorUpdateProject(project);
			return new ModelAndView("redirect:/loan/myAccount/myaccountPage.ht");
		}
	}


	
	
	
	/**
	 * 获取借款还款管理列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "myinprojects" })
	public ModelAndView myinprojects(HttpServletRequest request) {
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
		request.setAttribute("projects", tProjectService.getmyinProjects(null,null,"7",user.getUserId(),pb));//已还完
		request.setAttribute("projectsi", tProjectService.getmyinProjects(null,null,"6",user.getUserId(),pb));//还款中
		return new ModelAndView("/loan/front/myprojects.jsp");
	}
	/**
	 * 获取借款还款详细期列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "projectRepayment" })
	public ModelAndView myprojectRepayment(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		request.setAttribute("projects", tProjectRepayService.getBySqlKey("getByProjectId", Long.parseLong(request.getParameter("projectId"))));
		return new ModelAndView("/loan/front/myprojectRempayments.jsp");
	}
	/**
	 * 获取我的借款管理列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "repayment" })
	@ResponseBody  
	public Object repayment(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		String projectId = request.getParameter("projectId");
		String repaymentId = request.getParameter("repaymentId");
		String paypwd = request.getParameter("pwd");
		return tProjectService.repaymenting(projectId,repaymentId,paypwd,user);
	}
	/**
	 * 获取我的借款管理列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "myallinprojects" })
	public ModelAndView myallinprojects(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb=new  PageBean(page, pageSize);
		List<TProject> list = tProjectService.getmyinProjects(null,null,request.getParameter("status"),user.getUserId(),pb);
		request.setAttribute("projects", list);
		request.setAttribute("status", request.getParameter("status"));
		if(null!=list&&list.size()>0){
			request.setAttribute("counts", list.get(0).getCounts());
			request.setAttribute("sumLoan", list.get(0).getSumLoan());
		}else{
			request.setAttribute("counts", "0");
			request.setAttribute("sumLoan", "0.00");
		}
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		return new ModelAndView("/loan/front/myallprojects.jsp");
	}
	/**
	 * 获取我的借款管理列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "ajaxallinprojects" })
	@ResponseBody  
	public Object ajaxallinprojects(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb=new  PageBean(page, pageSize);
		List<TProject> list = tProjectService.getmyinProjects(null,null,request.getParameter("status"),user.getUserId(),pb);
		JSONArray jsons = new JSONArray();
		if(null!=list&&list.size()>0){
		}else{
			JSONObject json = new JSONObject();
			json.put("counts", "0");
			json.put("sumLoan", "0.00");
			jsons.add(json);
		}
		DecimalFormat df = new DecimalFormat("0.000");
		for(TProject p:list){
			JSONObject json = new JSONObject();
			json.put("pname", p.getPname());
			json.put("ploan", df.format(p.getPloan()));
			json.put("prateIn", df.format(p.getPrateIn()));
			json.put("pcloaseDateStr", p.getPcloaseDateStr()==null?"":p.getPcloaseDateStr());
			json.put("popenDateStr", p.getPopenDateStr()==null?"":p.getPopenDateStr());
			json.put("projectId", p.getProjectId());
			json.put("productsLoanId", p.getProductsLoanId());
			json.put("pstatusId", p.getPstatusId());
			json.put("counts", p.getCounts());
			json.put("sumLoan", df.format(p.getSumLoan()));
			jsons.add(json);
		}
		return jsons;
	}
	/**
	 * 获取我的借款申请列表数据
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "myapprojects" })
	public ModelAndView myapprojects(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb=new  PageBean(page, pageSize);
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		request.setAttribute("projects", tProjectService.getmyinProjects(request.getParameter("start"), request.getParameter("end"),request.getParameter("status"),user.getUserId(),pb));
		return new ModelAndView("/loan/front/myapprojects.jsp");
	}
	/**
	 * 获取我的借款申请列表数据
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "myloanstatistics" })
	public ModelAndView myloanstatistics(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		request.setAttribute("projects", tProjectService.getmyLoanStatistics("(5,6,7)",user.getUserId()));//对借款成功的借款记录统计
		return new ModelAndView("/loan/front/myloanstatistics.jsp");
	}
	/**
	 * 投标
	 * 理财用户投资借款标
	 * 
	 * @return
	 * @throws ProjectException
	 * @throws NumberFormatException
	 * @throws IOException
	 */
	@RequestMapping({ "bidProject" })
	@ResponseBody
	public String bidProject(HttpServletRequest request,
			HttpServletResponse response) throws NumberFormatException,
			 Exception {
		
		
		String projectId = request.getParameter("projectId");//项目id
		String money = request.getParameter("loan");//投资金额
		//String taskId = request.getParameter("taskId");   //新手任务Id
		String toke = request.getParameter("token_id");//
	    String serverToken = (String) request.getSession(false).getAttribute("token");
		
        TUser user=getSessionUser(request);
        
		
		try {
			if(user!=null){
				if(StringUtil.isNotEmpty(toke)){
					if(toke.equals(serverToken)){
						request.getSession(false).removeAttribute("token");
						long userId = user.getUserId();
						tProjectService.bidProject(userId, Long.valueOf(projectId),money,"1");
						
						long count = tprojectInvestService.getProjectInvestCount(userId);   //完成投标次数
						if(count == 10){    //已达到投标10次，  符合新手任务条件
							tuserTaskcompleteService.viweAddcredit(userId, 3);		
						}
						String serverToken2 = (String) request.getSession(false).getAttribute("token");
						System.out.println(serverToken2+"=========================================================");
						//如果成功 则 插入操作记录
						tuserLogService.recordUserOperation(userId, 3, 3, 1, 1, money,request);
						return "投资成功!";
					}else{
						return "重复提交";
					}
				}else{
					return "系统异常!";
				}
			}else{//session过期,重新登录
				 response.sendRedirect(request.getContextPath() + "/loginWeb.jsp");
			}
		} catch (Exception e) {
			// TODO: handle exception
		//	throw e;
			//如果失败 则 插入操作记录
			tuserLogService.recordUserOperation(user.getUserId(), 3, 3, 1, 2, "操作失败",request);
			return e.getMessage();
		}
		
		return null;
	}

	/**
	 * 获取借款项目的详细信息
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "showProjectDetail" })
	public ModelAndView showProjectDetail(HttpServletRequest request) {
		String taskId = request.getParameter("taskId");   //新手任务Id
		String projectId = request.getParameter("projectId");
		String applicationId = request.getParameter("applicationId");
		TProject project = tProjectService.getProjectByIdandUserId(Long
				.valueOf(projectId),Long.valueOf(applicationId));
		if(project==null){
			project=new TProject();
		}
		TUser proUser = tUserService.getUserInfoForDetail(project.getPapplicant());//.getUserById(project.getPapplicant());
		if(proUser==null){
			proUser=new TUser();
		}
		
		//用户审核材料
		List<TUserAuditMat> listVo=tuserAuditMatService.getAuditFileByUserId(project.getPapplicant());
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(listVo!=null&&listVo.size()>0){
			for (TUserAuditMat t : listVo) {
				if(t.getCheckTime()!=null){
					t.setCheckTimeS(sdf.format(t.getCheckTime()));
				}
				
			}
		}
		
		
		
		/*TUserFamily userFamily = userInfoService.getUserFamilyByUserId(project
				.getPapplicant());
		if(userFamily==null){
			userFamily=new TUserFamily();
		}*/
		/*TUserCompany userCompany = userInfoService
				.getUserCompanyByUserId(project.getPapplicant());
		if(userCompany==null){
			userCompany=new TUserCompany();
		}*/

		ProjectDetailView pdv = new ProjectDetailView();
		// 借款标的金额信息
		pdv.setProjectId(projectId);
		pdv.setLoan(String.valueOf(project.getPloan()));
		pdv.setRateOut(String.valueOf(project.getPrateOut()));
		pdv.setComplete(project.getPcomplete()+"");
		pdv.setRepayWay(project.getPrepayWay());
		pdv.setpName(project.getPname());
		pdv.setDeadline(String.valueOf(project.getPdeadline()));
		pdv.setLoanReal(String.valueOf(project.getPloanReal()));
		pdv.setIsbreakNum(project.getIsbreakNum());
		pdv.setSuccessNum(project.getSuccessNum());
		pdv.setProDesc(project.getPdesc());
		
		if(project.getPminInvest()==null)
			pdv.setPminInvest("100");
		else
			pdv.setPminInvest(project.getPminInvest()+"");
		
		// 计算还需金额
		String payLoan = String.valueOf(project.getPloan().subtract(
				project.getPloanReal()).setScale(2, BigDecimal.ROUND_HALF_UP));

		pdv.setPayLoan(payLoan);
		// 获取可用金额
			
			TUserFunds tuf=userInfoService.getUserFundsInfo(getSessionUser(request).getUserId());//.getAvailable();
			if(tuf!=null&&tuf.getAvailable()!=null){
				
				pdv.setCanUseLoan(String.valueOf(tuf.getAvailable().setScale(2, BigDecimal.ROUND_HALF_UP)));
			}else{
				pdv.setCanUseLoan("0.0");
			}

		// 贷款用户的详细信息
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
		System.out.println(proUser.getFIsBuyCar());
		pdv.setIsBuyCarLoan(proUser.getFisCarLoan() + "");
		pdv.setIsHouse(proUser.getFHouse());
		pdv.setIsHouseLoan(proUser.getFisHouseLoan() + "");
		pdv.setCreditIn(proUser.getCreditIn());
		pdv.setCreditOut(proUser.getCreditOut());
		TUser user = getSessionUser(request);
		request.setAttribute("pdv", pdv);
		request.setAttribute("user", user);
		
		
		//分页加参数
				/*int page = RequestUtil.getInt(request, "current_page", 1);
			    int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
				PageBean pb=new  PageBean(page, pageSize);
				
				request.setAttribute( "page_bean", pb);*///分页参数传入页面
		
		//是不是每加载一次 tproject中的浏览量 就+1  pyg 8/15
		
		
		//
		request.getSession().setAttribute("token", UUID.randomUUID().toString());
		
		return new ModelAndView("/loan/myAccount/showProjectDetail.jsp").addObject("ListVo", listVo).addObject("taskId", taskId);//.addObject("ListPro", listPro);
	}
	
	//public
	
	@RequestMapping({"investList"})
	public ModelAndView investList(HttpServletRequest request){
		String projectId = request.getParameter("projectId");
		
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
	    int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb=new  PageBean(page, pageSize);
		
		//项目的投标记录
				List<TProjectInvest> listPro=tprojectInvestService.getTprojectInvestByProId(Long.valueOf(projectId),pb);
				if(listPro!=null&&listPro.size()>0){
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
					for (TProjectInvest p : listPro) {
						if(p.getPiBidTime()!=null){
							p.setPiBidTimeStr(sdf.format(p.getPiBidTime()));
						}
						if(StringUtil.isNotEmpty(p.getRealName())){
							if(p.getRealName().length()>2){
								p.setRealName(p.getRealName().substring(0,1)+"****"+p.getRealName().substring(2,p.getRealName().length()));
							}else{
								p.setRealName(p.getRealName().substring(0,1)+"****"+p.getRealName().substring(1,p.getRealName().length()));
							}
						}
						if(p.getPiAmount()!=null){
							p.setPiAmount(p.getPiAmount().setScale(2, BigDecimal.ROUND_HALF_UP));
						}
					}
				}
				request.setAttribute( "page_bean", pb);//分页参数传入页面
				request.setAttribute("ListPro", listPro);
				return new ModelAndView("/loan/myAccount/tenderRecordList.jsp").addObject("ListPro", listPro).addObject("projectId", projectId);
	}
	/**
	 * 搜索借款列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "getTenderProjectsByCnd" })
	public ModelAndView getTenderProjectsByCnd(HttpServletRequest request) {
		String pType = request.getParameter("pType");
		int pDeadlineMin = Integer
				.valueOf(request.getParameter("pDeadlineMin"));
		int pDeadlineMax = Integer
				.valueOf(request.getParameter("pDeadlineMax"));
		String pCertifiLevel = request.getParameter("pCertifiLevel");

		List<TProject> projects = tProjectService.searchTenderProject(pType,
				pDeadlineMin, pDeadlineMax, pCertifiLevel);
		request.setAttribute("projects", projects);

		return new ModelAndView("/loan/front/WYLC.jsp");
	}

	


	private TUser getSessionUser(HttpServletRequest request) {
		return (TUser) request.getSession().getAttribute("user");
	}
	
}
