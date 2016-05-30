package com.deelon.loan.controller.sysManager;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


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
import com.deelon.loan.model.sysManager.Temailinformation;
import com.deelon.loan.service.sysManager.TemailinformationService;
import com.deelon.platform.model.system.Demension;


@ Controller
@ RequestMapping( { "/loan/sysManager/temailinformation/" } )
public class TemailinformationFormController extends BaseFormController{
	
	   @Resource
	   private TemailinformationService temailinformationService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新Temailinformation")
	   public void save(HttpServletRequest request, HttpServletResponse response, Temailinformation temailinformation, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("temailinformation", temailinformation, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     temailinformation.setCreator(ContextUtil.getCurrentUserId().longValue());
		     String resultMsg = null;
		     if (temailinformation.getInfoId() == null){
		    	 temailinformation.setInfoId(Long.valueOf(UniqueIdUtil.genId()));
		    	 temailinformation.setCreateTime(new Date());
		         this.temailinformationService.add(temailinformation);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.temailinformationService.update(temailinformation);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected Temailinformation getFormObject(@RequestParam("infoId") Long infoId, Model model)  throws Exception
	   {
	     this.logger.debug("enter Temailinformation getFormObject here....");
	     Temailinformation temailinformation = null;
	     if (infoId != null)
	    	 temailinformation = (Temailinformation)this.temailinformationService.getById(infoId);
	     else {
	    	 temailinformation = new Temailinformation();
	     }
	     return temailinformation;
	   }
}

