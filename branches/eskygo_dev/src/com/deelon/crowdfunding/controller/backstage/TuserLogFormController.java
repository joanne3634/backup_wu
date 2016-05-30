package com.deelon.crowdfunding.controller.backstage;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



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
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.loan.model.TuserLog;
import com.deelon.loan.service.operationLog.TuserLogService;





@ Controller
@ RequestMapping( { "/crowdfunding/backstage/tuserlog/" } )
public class TuserLogFormController extends BaseFormController{
	
	   @Resource
	   private TuserLogService tuserLogService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新TuserLog")
	   public void save(HttpServletRequest request, HttpServletResponse response, TuserLog tuserLog, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tuserLog", tuserLog, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tuserLog.getLoginLogId() == null){
		    	 tuserLog.setLoginLogId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tuserLogService.add(tuserLog);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tuserLogService.update(tuserLog);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected TuserLog getFormObject(@RequestParam("loginLogId") Long loginLogId, Model model)  throws Exception
	   {
	     this.logger.debug("enter TuserLog getFormObject here....");
	     TuserLog tuserLog = null;
	     if (loginLogId != null)
	    	 tuserLog = (TuserLog)this.tuserLogService.getById(loginLogId);
	     else {
	    	 tuserLog = new TuserLog();
	     }
	     return tuserLog;
	   }
}

