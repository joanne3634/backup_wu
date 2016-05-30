/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.controller.sysManager;

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
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.loan.model.front.TuserCredit;
import com.deelon.loan.service.front.TuserCreditService;
import com.deelon.platform.model.system.Demension;


@ Controller
@ RequestMapping( { "/cmsform/site/tusercredit/" } )
public class TuserCreditFormController extends BaseFormController{
	
	   @Resource
	   private TuserCreditService tuserCreditService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新TuserCredit")
	   public void save(HttpServletRequest request, HttpServletResponse response, TuserCredit tuserCredit, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tuserCredit", tuserCredit, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tuserCredit.getCreditId() == null){
		    	 tuserCredit.setCreditId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tuserCreditService.add(tuserCredit);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tuserCreditService.update(tuserCredit);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected TuserCredit getFormObject(@RequestParam("creditId") Long creditId, Model model)  throws Exception
	   {
	     this.logger.debug("enter TuserCredit getFormObject here....");
	     TuserCredit tuserCredit = null;
	     if (creditId != null)
	    	 tuserCredit = (TuserCredit)this.tuserCreditService.getById(creditId);
	     else {
	    	 tuserCredit = new TuserCredit();
	     }
	     return tuserCredit;
	   }
}

