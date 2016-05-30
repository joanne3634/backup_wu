package com.deelon.loan.controller.sysManager;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.BeanUtils;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.ExceptionUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.controller.front.view.ProjectDetailView;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectRisk;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserAuditMat;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TriskCompany;
import com.deelon.loan.service.front.TUserAuditMatService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TprojectRiskService;
import com.deelon.loan.service.front.TriskCompanyService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.platform.model.system.SysAuditModelType;
import com.deelon.platform.model.system.SysUser;

@Controller
@RequestMapping({"/loan/sysManager/preliminaryAudit/"})
@Action(ownermodel=SysAuditModelType.PRELIMINARYAUDIT)
public class PreliminaryAuditListController extends BaseController {

	@Resource
	private TprojectService tprojectService;
	@Resource
	private TUserService tUserService;
	@Resource
	private TUserAuditMatService tuserAuditMatService;
	@Resource
	private TprojectRiskService tprojectRiskService;
	@Resource
	private TuserFundsService TuserFundsService;
	@Resource
	private TriskCompanyService triskCompanyService;
	
	@Action(description="初审借款页面")
	@RequestMapping({"list"})
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		QueryFilter queryFilter=	new QueryFilter(request,"projectId");
//		queryFilter.
		Map<String,Object> map=queryFilter.getFilters();
		String endDate=(String)map.get("endDate");
		if(StringUtil.isNotEmpty(endDate)){
			queryFilter.addFilter("endDate", endDate+" 23:59:59");
		}
		String beginDate=(String)map.get("beginDate");
		if(StringUtil.isNotEmpty(beginDate)){
			queryFilter.addFilter("beginDate", beginDate+" 00:00:00");
		}
		
		List<TProject> list =tprojectService.getAllProtWaitingAudit(queryFilter);
		try {
			return getAutoView().addObject("ListVo", list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	@Action(description="用户资料")
	@RequestMapping({"edit"})
	  public ModelAndView edit(HttpServletRequest request,HttpServletResponse response)
	    throws Exception {
		String userId=request.getParameter("userId");
		TUser proUser = tUserService.getUserInfoForDetail(Long.valueOf(userId));//.getUserById(project.getPapplicant());
		if(proUser==null){
			proUser=new TUser();
		}
		
		//用户审核材料
		List<TUserAuditMat> listVo=tuserAuditMatService.getAuditFileByUserId(Long.valueOf(userId));
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(listVo!=null&&listVo.size()>0){
			for (TUserAuditMat t : listVo) {
				if(t.getCheckTime()!=null){
					t.setCheckTimeS(sdf.format(t.getCheckTime()));
				}
				
			}
		}
		
		ProjectDetailView pdv = new ProjectDetailView();
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
				
				  String returnUrl = RequestUtil.getPrePage(request);
		return getAutoView().addObject("pdv", pdv).addObject("ListVo", listVo).addObject("returnUrl", returnUrl);
	}
	
	@Action(description="流标说明")
	 @RequestMapping({"BrakRmark"})
	public ModelAndView BrakRmark(HttpServletRequest request, HttpServletResponse response) throws Exception{
		   String projectId=request.getParameter("projectId");
		 return getAutoView().addObject("ProjectId", projectId);
	}
	
	@Action(description="设置担保金比例 页面")
	 @RequestMapping({"get"})
	  public ModelAndView get(HttpServletRequest request, HttpServletResponse response)
	    throws Exception{
				 String projectId=request.getParameter("projectId");
				 String loanMoney=request.getParameter("loanMoney");
				 TriskCompany triskCompany=triskCompanyService.getDefaultRiskcom();
				 TProjectRisk tprojectRisk= tprojectRiskService.getTProjectRiskByProId(Long.valueOf(projectId));
				 /*if(tprojectRisk!=null){
					 if(tprojectRisk.getPrrisk()!=null){
						 tprojectRisk.setPrrisk(prrisk);
					 }
				 }*/
	    return getAutoView().addObject("TProjectRisk", tprojectRisk).addObject("loanMoney", loanMoney).addObject("TriskCompany", triskCompany);
	  }
	 
	@Action(description="设置标的类型页面")
	 @RequestMapping({"credit"})
	  public ModelAndView credit(HttpServletRequest request, HttpServletResponse response)
			  throws Exception{
		 String projectId=request.getParameter("projectId");
		 
		 TProject pro=tprojectService.getPro_clerkByProId(Long.valueOf(projectId));
		
		 return getAutoView().addObject("TProject", pro);
	 }
	 
	 
	@Action(description="表的类型页面保存")
	 @RequestMapping({"savePlateFormDate"})
	  public void savePlateFormDate(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 String typeId=request.getParameter("typeId");//标的类型
		 String prateOut=request.getParameter("prateOut");//担保比例
		 String pclerkId=request.getParameter("pclerkId");
		 String projectId=request.getParameter("projectId");
		 
	
		 ResultMessage message = new ResultMessage(1, "操作成功！");
		 PrintWriter writer = response.getWriter();
		 try {
			 TProject pro=tprojectService.getById(Long.valueOf(projectId));
			 pro.setPtypeId(typeId);
			 if(StringUtil.isNotEmpty(prateOut)){//借出利率,投资利率
				 pro.setPrateOut(new BigDecimal(prateOut));
			 }
			 if(StringUtil.isNotEmpty(pclerkId)){
				 
				 pro.setPclerk(pclerkId);
			 }
			 //系统自动评定用户的认证等级
			 TUserFunds tu=TuserFundsService.getTUserFundsByUserId(pro.getPapplicant());
			 if(tu.getCreditIn()>=0&&tu.getCreditIn()<=99){
				 pro.setPcertifiLevel("HR");
			 }else if(tu.getCreditIn()>=100&&tu.getCreditIn()<=109){
				 pro.setPcertifiLevel("E");
			 }else if(tu.getCreditIn()>=110&&tu.getCreditIn()<=119){
				 pro.setPcertifiLevel("D");
			 }else if(tu.getCreditIn()>=120&&tu.getCreditIn()<=129){
				 pro.setPcertifiLevel("C");
			 }else if(tu.getCreditIn()>=130&&tu.getCreditIn()<=144){
				 pro.setPcertifiLevel("B");
			 }else if(tu.getCreditIn()>=145&&tu.getCreditIn()<=159){
				 pro.setPcertifiLevel("A");
			 }else if(tu.getCreditIn()>=160){
				 pro.setPcertifiLevel("AA");
			 }
			 
			 tprojectService.update(pro);
		} catch (Exception e) {
			 String msg = ExceptionUtil.getExceptionMessage(e);
		        message = new ResultMessage(0, msg);
		}
		 writer.print(message);
	 }
	 
	 //流标修改
	 @RequestMapping({"saveBreak"})
	 @ResponseBody
	  public Map<String,Object> saveBreak(HttpServletRequest request, HttpServletResponse response,
			  String pbreakRemark,String projectId)
	    throws Exception {
		 try {
			 
			 Long[] lAryId = RequestUtil.getLongAryByStr(projectId);
		//    delByIds(lAryId,pbreakRemark);
		    Map<String,Object> map=new HashMap<String,Object>();  
		    	/*if (BeanUtils.isEmpty(lAryId)) {
			      return  map.put("msg", "数据操作失败!");;
			    }*/
			    for (Long id : lAryId){
			    	TProject t=tprojectService.getTProjectById(id);
			    		t.setPstatusId("8");//招标阶段未满标
			    		t.setPbreakRemark(pbreakRemark);
			    		t.setPbreakTimes(t.getPbreakTimes()+1);
			    		t.setPisBreak((short)1);//流标
			    		t.setUpdatetime(new Date());
			    		t.setPisFull((short)0);
			    		tprojectService.update(t);
			    }
		    map.put("msg", "数据操作成功!");
	        return map;
		} catch (Exception e) {
			   Map<String,Object> map=new HashMap<String,Object>();  
				 map.put("msg", "数据操作失败!");
			return 	map;
		}
		 
	  }
	 @Action(description="担保金比例修改保存")
	 @RequestMapping({"saveDate"})
	  public void saveDate(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 String prrisk=request.getParameter("prrisk");//借款金额
		 String prriskRate=request.getParameter("prriskRate");//担保比例
		 String riskId_id=request.getParameter("riskId_id");
		 String pradvice_id=request.getParameter("pradvice_id");
		 String prcompay=request.getParameter("prcompay");
		 ResultMessage message = new ResultMessage(1, "操作成功！");
		 PrintWriter writer = response.getWriter();
		 try{
			 TProjectRisk tpro=tprojectRiskService.getById(Long.valueOf(riskId_id));
			 tpro.setPradvice(pradvice_id);
			
			 if(StringUtil.isNotEmpty(prrisk))
				 tpro.setPrrisk(new BigDecimal(prrisk));
			 if(StringUtil.isNotEmpty(prriskRate))
				 tpro.setPrriskRate(new BigDecimal(prriskRate));
			 if(StringUtil.isNotEmpty(prcompay))
				 tpro.setPrcompay(Long.valueOf(prcompay));
			 tprojectRiskService.update(tpro);
	      } catch (Exception e){
	        String msg = ExceptionUtil.getExceptionMessage(e);
	        message = new ResultMessage(0, msg);
	        e.printStackTrace();
	      }
		 writer.print(message);
	  }
	 @RequestMapping({"updates"})
	 @ResponseBody
	 @Action(description="初审贷款", execOrder=ActionExecOrder.BEFORE, detail="初审贷款")
	  public Map<String,Object> save(HttpServletRequest request, HttpServletResponse response,String applyIds,String pstatusId,String agOrdisag){
		 SysUser su=ContextUtil.getCurrentUser();
			String roles=su.getRoles(); //,批量操作时 用到
			
		 try {
			 Long[] lAryId = RequestUtil.getLongAryByStr(applyIds);
			 if(StringUtil.isNotEmpty(agOrdisag)){
				 if(agOrdisag.equals("agree")){//同意请求
					 if(StringUtil.isNotEmpty(pstatusId)){
						 if(pstatusId.equals("1")){//初申请的,担保审核人员的操作,
							 
							 delByIds(lAryId,"2");//将项目状态改为担保审核操作
						 }else if(pstatusId.equals("2")){//平台审核人员的操作,
							 delByIds(lAryId,"3");//将项目状态改为平台审核操作
						 }
					 }else{
						 if(agOrdisag.equals("agree")){//同意请求
							 if(roles.contains("bpm_DANBAO_SHENHE_RENYUAN")){//担保审核人元操作,批量操作时 
								 //初申请的,担保审核人员的操作,
									 
									 delByIds(lAryId,"2");//将项目状态改为担保审核操作
								 
							 }else if(roles.contains("bpm_PINGTAI_SHENHE_RENYUAN")){//平台审核人员操作
								 //平台审核人员的操作,
									 delByIds(lAryId,"3");//将项目状态改为平台审核操作
							 }
						 }else if(agOrdisag.equals("disagree")){
							 delByIds(lAryId,"8");//流标
						 }
					 }
				 }else if(agOrdisag.equals("disagree")){//不同意
					 delByIds(lAryId,"8");//流标
				 }
			 }
		    Map<String,Object> map=new HashMap<String,Object>();  
		 map.put("msg", "数据操作成功!");
	        return map;
		} catch (Exception e) {
			   Map<String,Object> map=new HashMap<String,Object>();  
				 map.put("msg", "数据操作失败!");
			return 	map;
		}
		 
	  }
	 
	 private void delByIds(Long[] lAryId,String pstatusId){
		 try {
//			 Long user_id=ContextUtil.getCurrentUser().getUserId();
			    if (BeanUtils.isEmpty(lAryId)) {
			      return;
			    }
			    GregorianCalendar gc=new GregorianCalendar(); 
			    for (Long id : lAryId){
			    	
			    	TProject t=tprojectService.getTProjectById(id);
			    	t.setPstatusId(pstatusId);
			   
			    	if(pstatusId.equals("3")){//平台审核通过
			    		t.setPopenDate(new Date());//开标
			    		//根据用户设定的最大招标时间计算招标结束时间
			    		if(t.getPopenDate()!=null)
			    		gc.setTime(t.getPopenDate());
			    		
			    		gc.add(5, t.getPopenDays());
			    		t.setPcloseDate(gc.getTime());//招标结束日期
			    		
			    	}
			    	if(pstatusId.equals("8")){//流标
			    		t.setPbreakTimes(t.getPbreakTimes()+1);
			    		t.setPisFull((short)0);//未满标
			    	}
			  //  	t.setPlateDays(0);
			    	tprojectService.update(t);
			    }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	 }
}
