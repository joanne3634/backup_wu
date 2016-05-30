package com.deelon.loan.controller.sysManager;

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
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.platform.model.system.SysAuditModelType;
import com.deelon.platform.model.system.SysUser;
@Controller
@RequestMapping({"/loan/sysManager/depositConfirm/"})
@Action(ownermodel=SysAuditModelType.DEPOSITCONFIRM)
public class DepositConfirmController extends BaseController {

	@Resource
	private TprojectService tprojectService;
	
	@RequestMapping({"list"})
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		String applyName=request.getParameter("applyName");
		String pname=request.getParameter("pname");
//		String beginDate=request.getParameter("beginDate");
//		String endDate=request.getParameter("endDate");
		String pcNo=request.getParameter("pcNo");
		String phavedPay=request.getParameter("phavedPay");
		try {
			QueryFilter queryFileter=new QueryFilter(request,"projectId");
			queryFileter.addFilter("applyName", applyName);
			queryFileter.addFilter("pname", pname);
//			queryFileter.addFilter("beginDate", beginDate);
//			queryFileter.addFilter("endDate", endDate);
			queryFileter.addFilter("pcNo", pcNo);
			queryFileter.addFilter("phavedPay", phavedPay);
			
			Map<String,Object> map=queryFileter.getFilters();
			String endDate=(String)map.get("endDate");
			if(StringUtil.isNotEmpty(endDate)){
				queryFileter.addFilter("endDate", endDate+" 23:59:59");
			}
			String beginDate=(String)map.get("beginDate");
			if(StringUtil.isNotEmpty(beginDate)){
				queryFileter.addFilter("beginDate", beginDate+" 00:00:00");
			}
			
			List<TProject> listVo=tprojectService.getWaitingForTheLoanList(queryFileter);
			return getAutoView().addObject("ListVo", listVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	 
	 @RequestMapping({"edit"})
	  public ModelAndView edit(HttpServletRequest request,HttpServletResponse response)
	    throws Exception {
		 String projectId=request.getParameter("projectId");
		 ResultMessage message = new ResultMessage(1, "数据加载成功！");
		 if(StringUtil.isNotEmpty(projectId)){
			 TProject p=tprojectService.getById(Long.valueOf(projectId));
		 }
		 return null;
	 }
	
	@RequestMapping({"updateLoanData"})
	@ResponseBody
	@Action(description="确认放款", execOrder=ActionExecOrder.BEFORE,detail="确认放款")
	public String updateLoanData(HttpServletRequest request,HttpServletResponse response,String arrayIds )throws Exception{
		
		try {
			 SysUser sysUser=ContextUtil.getCurrentUser();//当前系统后台审核放款用户
			
			 
			 Long[] lAryId = RequestUtil.getLongAryByStr(arrayIds);
			 for(long id:lAryId){
				//平台项目放款处理
				 tprojectService.platformPayProject(id,sysUser);
			 }
			
			 
//			Map<String,String> map=new HashMap<String,String>();
//			map.put("msg", "操作成功!");
			return  "操作成功!";
		} catch (Exception e) {
		//	e.printStackTrace();
			return e.getMessage();
		}
		
	}
	
	
	
}
