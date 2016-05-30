package com.deelon.crowdfunding.controller.backstage;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */




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
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.platform.model.system.Demension;



@ Controller
@ RequestMapping( { "/cmsform/site/tcproject/" } )
public class TcprojectFormController extends BaseFormController{
	
	   @Resource
	   private TcprojectService tcprojectService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新Tcproject")
	   public void save(HttpServletRequest request, HttpServletResponse response, Tcproject tcproject, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tcproject", tcproject, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tcproject.getProjectId() == null){
		    	 tcproject.setProjectId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tcprojectService.add(tcproject);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tcprojectService.update(tcproject);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected Tcproject getFormObject(@RequestParam("projectId") Long projectId, Model model)  throws Exception
	   {
	     this.logger.debug("enter Tcproject getFormObject here....");
	     Tcproject tcproject = null;
	     if (projectId != null)
	    	 tcproject = (Tcproject)this.tcprojectService.getById(projectId);
	     else {
	    	 tcproject = new Tcproject();
	     }
	     return tcproject;
	   }
}

