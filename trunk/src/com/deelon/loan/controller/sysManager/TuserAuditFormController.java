package com.deelon.loan.controller.sysManager;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.crowdfunding.model.backstage.TcuserAudit;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.TuserCredit;
import com.deelon.loan.model.sysManager.TuserAudit;
import com.deelon.loan.service.front.TuserCreditService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.TuserAuditService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.platform.model.system.Demension;



@ Controller
@ RequestMapping( { "/loan/sysManager/tuseraudit/" } )
public class TuserAuditFormController extends BaseFormController{
	
	   @Resource
	   private TuserAuditService tuserAuditService;
	   @Resource
	   private TuserSafeService tuserSafeService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新TuserAudit")
	   public void save(HttpServletRequest request, HttpServletResponse response, TcuserAudit tuserAudit,TUserSafe tuserSafe, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tuserAudit", tuserAudit, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tuserAudit.getUserId() == null){
		    	 tuserAudit.setUserId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tuserAuditService.add(tuserAudit);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		    	 TcuserAudit ua = this.tuserAuditService.getById(tuserAudit.getUserId());
		    	 ua.setContactName(tuserAudit.getContactName());
		    	 ua.setIsCompany(tuserAudit.getIsCompany());
		    	 ua.setRemarks(tuserAudit.getRemarks());
		    	 ua.setPersonalAddress(tuserAudit.getPersonalAddress());
		       this.tuserAuditService.update(ua);
		       TUserSafe u = this.tuserSafeService.getById(tuserSafe.getSafeId());
		       if(u.getBindIdNo() != 1){
		    	   u.setIdNo(tuserSafe.getIdNo());
		    	   u.setReallname(tuserSafe.getReallname());
		       }
		       if(u.getBindEmail() != 1){
		    	   u.setEmail(tuserSafe.getEmail());
		       }
		       if(u.getBindMobile() != 1){
		    	   u.setMobile(tuserSafe.getMobile());
		       }
		       this.tuserSafeService.update(u);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected TcuserAudit getFormObject(@RequestParam("userId") Long userId, Model model)  throws Exception
	   {
	     this.logger.debug("enter TuserAudit getFormObject here....");
	     TcuserAudit tuserAudit = null;
	     if (userId != null)
	    	 tuserAudit = (TcuserAudit)this.tuserAuditService.getById(userId);
	     else {
	    	 tuserAudit = new TcuserAudit();
	     }
	     return tuserAudit;
	   }
	   
	   
	   
	   @RequestMapping({"tuserAudit"})
	   @Action(description="审核投资人基本信息  ")
	   public void tuserAudit(HttpServletRequest request, HttpServletResponse response) throws Exception
	   {

		    String status = request.getParameter("status");
		    String userId = request.getParameter("userId");
		    
		    TcuserAudit userAudit = this.tuserAuditService.getById(Long.valueOf(userId));
		    userAudit.setIsCheck(Integer.valueOf(status)); 
		    userAudit.setCheckTime(new Date());
		    userAudit.setChecker(ContextUtil.getCurrentUserId().longValue());
		    this.tuserAuditService.update(userAudit);
		    String resultMsg = getText("record.updated", new Object[] { "数据" });
		    writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }


