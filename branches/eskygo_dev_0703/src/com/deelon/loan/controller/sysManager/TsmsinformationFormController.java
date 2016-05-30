package com.deelon.loan.controller.sysManager;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */




import java.util.Date;

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
import com.deelon.core.util.DateFormatUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.sysManager.TsmsinformationService;


@ Controller
@ RequestMapping( { "/loan/sysManager/tsmsinformation/" } )
public class TsmsinformationFormController extends BaseFormController{
	
	   @Resource
	   private TsmsinformationService tsmsinformationService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新Tsmsinformation")
	   public void save(HttpServletRequest request, HttpServletResponse response, Tsmsinformation tsmsinformation, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tsmsinformation", tsmsinformation, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }	     
		     String resultMsg = null;
		     tsmsinformation.setCreator(ContextUtil.getCurrentUserId().longValue());
		     if (tsmsinformation.getInfoId() == null){
		    	 tsmsinformation.setInfoId(Long.valueOf(UniqueIdUtil.genId()));
		    	 tsmsinformation.setCreateTime(new Date());
		         this.tsmsinformationService.add(tsmsinformation);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tsmsinformationService.update(tsmsinformation);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected Tsmsinformation getFormObject(@RequestParam("infoId") Long infoId, Model model)  throws Exception
	   {
	     this.logger.debug("enter Tsmsinformation getFormObject here....");
	     Tsmsinformation tsmsinformation = null;
	     if (infoId != null)
	    	 tsmsinformation = (Tsmsinformation)this.tsmsinformationService.getById(infoId);
	     else {
	    	 tsmsinformation = new Tsmsinformation();
	     }
	     return tsmsinformation;
	   }
}

