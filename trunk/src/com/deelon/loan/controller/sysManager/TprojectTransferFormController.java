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
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.model.system.SysAuditModelType;
import com.deelon.loan.model.sysManager.TprojectTransfer;
import com.deelon.loan.service.sysManager.TprojectTransferService;

@ Controller
@ RequestMapping( { "/loan/sysManager/tprojecttransfer/" } )
@Action(ownermodel=SysAuditModelType.TPROJECTTRANSFER)
public class TprojectTransferFormController extends BaseFormController{
	
	   @Resource
	   private TprojectTransferService tprojectTransferService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新TprojectTransfer", execOrder=ActionExecOrder.BEFORE, detail="添加或更新TprojectTransfer")
	   public void save(HttpServletRequest request, HttpServletResponse response, TprojectTransfer tprojectTransfer, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tprojectTransfer", tprojectTransfer, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tprojectTransfer.getTransferId() == null){
		    	 tprojectTransfer.setTransferId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tprojectTransferService.add(tprojectTransfer);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tprojectTransferService.update(tprojectTransfer);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected TprojectTransfer getFormObject(@RequestParam("transferId") Long transferId, Model model)  throws Exception
	   {
	     this.logger.debug("enter TprojectTransfer getFormObject here....");
	     TprojectTransfer tprojectTransfer = null;
	     if (transferId != null)
	    	 tprojectTransfer = (TprojectTransfer)this.tprojectTransferService.getById(transferId);
	     else {
	    	 tprojectTransfer = new TprojectTransfer();
	     }
	     return tprojectTransfer;
	   }
}

