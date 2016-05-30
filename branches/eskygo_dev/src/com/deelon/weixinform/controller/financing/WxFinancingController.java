package com.deelon.weixinform.controller.financing;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.page.PageBean;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.controller.front.view.ProjectDetailView;
import com.deelon.loan.dao.sysManager.TprojectRepaymentDao;
import com.deelon.loan.exception.ProjectException;
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
import com.fr.base.core.UUID;

/**
 * 我要理财
 * 参考ProjectController(showProjectDetail,bidProject)
 * @author qin
 *
 */
@Controller
@RequestMapping({"/weixin/wxfinancing"})
public class WxFinancingController {
	
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
	 * 跳转到投资流程界面
	 * @return
	 */
	@RequestMapping({ "wxinvestPage" })
	public ModelAndView wxinvestPage() {
		return new ModelAndView("/weixinform/financing/investFlow.jsp");
	}
	
	/**
	 * 跳转到理财项目列表
	 * @return
	 */
	@RequestMapping({ "wxfinancingPage" })
	public ModelAndView wxfinancingPage(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		/*if(null == getSessionUser(request)){
			response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
			return null;
		}*/
		
		String sort = request.getParameter("sort");
		String typeId=request.getParameter("typeId");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sort", sort);
		map.put("typeId", typeId);
	         
		List<TProject> projects = tProjectService.wxgetAllLoanByWhere(map,null);
		/**/
		request.setAttribute("projects", projects);
		request.setAttribute("sort", sort);
		request.setAttribute("typeId", typeId);
		return new ModelAndView("/weixinform/financing/project.jsp");
	}
	
	/**
	 * 获取投资项目的详细信息
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "showProjectDetail" })
	public ModelAndView showProjectDetail(HttpServletRequest request, HttpServletResponse response) throws Exception{

		if(null == getSessionUser(request)){
			response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
			return null;
		}
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
		System.out.println(project.getPloan());
		System.out.println(project.getPloanReal());
		
		// 计算还需金额
		String payLoan = String.valueOf(project.getPloan().subtract(
				project.getPloanReal()));

		pdv.setPayLoan(payLoan);
		// 获取可用金额
			
			TUserFunds tuf=userInfoService.getUserFundsInfo(getSessionUser(request).getUserId());//.getAvailable();
			if(tuf!=null&&tuf.getAvailable()!=null){
				
				pdv.setCanUseLoan(String.valueOf(tuf.getAvailable()));
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
		
		//项目的投标记录
		List<TProjectInvest> listPro=tprojectInvestService.getTprojectInvestByProId(Long.valueOf(projectId),null);
		if(listPro!=null&&listPro.size()>0){
			SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
			for (TProjectInvest p : listPro) {
				if(p.getPiBidTime()!=null){
					p.setPiBidTimeStr(sdf1.format(p.getPiBidTime()));
				}
				if(StringUtil.isNotEmpty(p.getRealName())){
					if(p.getRealName().length()>2){
						p.setRealName(p.getRealName().substring(0,1)+"****"+p.getRealName().substring(2,p.getRealName().length()));
					}else{
						p.setRealName(p.getRealName().substring(0,1)+"****"+p.getRealName().substring(1,p.getRealName().length()));
					}
				}
			}
		}
		
		request.getSession().setAttribute("token", UUID.randomUUID().toString());
		
		return new ModelAndView("/weixinform/financing/details.jsp").addObject("ListVo", listVo).addObject("ListPro", listPro);
	}
	
	/**
	 * 获取前端用户实体
	 * @param request
	 * @return
	 */
	private TUser getSessionUser(HttpServletRequest request) {
		return (TUser) request.getSession().getAttribute("user");
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
			Exception, IOException {

		if(null == getSessionUser(request)){
			response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
			return null;
		}
		
		String projectId = request.getParameter("projectId");//项目id
		String money = request.getParameter("loan");//投资金额
		//String taskId = request.getParameter("taskId");   //新手任务Id
		String toke = request.getParameter("token_id");//
	    String serverToken = (String) request.getSession(false).getAttribute("token");
		
	    long userId = getSessionUser(request).getUserId();
		try {
			if(StringUtil.isNotEmpty(toke)){
				if(toke.equals(serverToken)){
					
					request.getSession(false).removeAttribute("token");
					tProjectService.bidProject(userId, Long.valueOf(projectId),money,"1");
					
					long count = tprojectInvestService.getProjectInvestCount(userId);   //完成投标次数
					if(count == 10){    //已达到投标10次，  符合新手任务条件
						tuserTaskcompleteService.viweAddcredit(userId, 3);		
					}
					  String serverToken2 = (String) request.getSession(false).getAttribute("token");
					  System.out.println(serverToken2+"=========================================================");
					//如果成功 则 插入操作记录
						tuserLogService.recordUserOperation(userId, 3, 3, 2, 1, money,request);
					return "投资成功!";
				}else{
					return "重复提交";
				}
			}else{
				return "系统异常!";
			}
		} catch (Exception e) {
			// TODO: handle exception
		//	throw e;
			//如果失败 则 插入操作记录
			tuserLogService.recordUserOperation(userId, 3, 3, 2, 2, "操作失败",request);
			return e.getMessage();
		}
	}
	
	/**
	 * 跳转到本金保障页面
	 * @return
	 */
	@RequestMapping({"safeguardPage"})
	public ModelAndView safeguardPage(){
		return new ModelAndView("/weixinform/financing/safeguard.jsp");
	}
	
}
