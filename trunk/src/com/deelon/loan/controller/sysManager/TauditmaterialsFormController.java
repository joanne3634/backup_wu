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
import com.deelon.loan.model.sysManager.Tauditmaterials;
import com.deelon.loan.service.sysManager.TauditmaterialsService;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.model.system.SysAuditModelType;

@ Controller
@ RequestMapping( { "/loan/sysManager/tauditmaterials/" } )
@Action(ownermodel=SysAuditModelType.TAUDITMATERIALS)
public class TauditmaterialsFormController extends BaseFormController{
	
	   @Resource
	   private TauditmaterialsService tauditmaterialsService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新Tauditmaterials", execOrder=ActionExecOrder.BEFORE, detail="添加或更新Tauditmaterials")
	   public void save(HttpServletRequest request, HttpServletResponse response, Tauditmaterials tauditmaterials, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tauditmaterials", tauditmaterials, bindResult, request);	
		   String isType = request.getParameter("isType");
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		   
		     tauditmaterials.setTypeId("0");
		     tauditmaterials.setIsType(Integer.parseInt(isType));
		     
		     String resultMsg = null;
		     if (tauditmaterials.getMaterialsId() == null){
		    	 tauditmaterials.setMaterialsId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tauditmaterialsService.add(tauditmaterials);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tauditmaterialsService.update(tauditmaterials);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected Tauditmaterials getFormObject(@RequestParam("materialsId") Long materialsId, Model model)  throws Exception
	   {
	     this.logger.debug("enter Tauditmaterials getFormObject here....");
	     Tauditmaterials tauditmaterials = null;
	     if (materialsId != null)
	    	 tauditmaterials = (Tauditmaterials)this.tauditmaterialsService.getById(materialsId);
	     else {
	    	 tauditmaterials = new Tauditmaterials();
	     }
	     return tauditmaterials;
	   }
}

