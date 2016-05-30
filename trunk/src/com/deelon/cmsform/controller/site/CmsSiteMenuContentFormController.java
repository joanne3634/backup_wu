/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */


package com.deelon.cmsform.controller.site;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.cmsform.service.site.CmsSiteMenuContentService;
import com.deelon.core.annotion.Action;
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.platform.model.system.SysAuditModelType;

@ Controller
@ RequestMapping( { "/cmsform/site/cmssitemenucontent/" } )
@Action(ownermodel=SysAuditModelType.CMSSITEMENU_MANAGEMENT)
public class CmsSiteMenuContentFormController extends BaseFormController{
	
	   @Resource
	   private CmsSiteMenuContentService cmsSiteMenuContentService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新CmsSiteMenuContent",execOrder=ActionExecOrder.BEFORE,detail="添加或更新CmsSiteMenuContent")
	   public void save(HttpServletRequest request, HttpServletResponse response, CmsSiteMenuContent cmsSiteMenuContent, BindingResult bindResult) throws Exception
	   {
		  /* String ifPublish=request.getParameter( "ifPublish" ); 
		   if(ifPublish != null && !"".equals(ifPublish) && !"undefined".equals(ifPublish)){
			   if("1".equals(ifPublish)){
				   cmsSiteMenuContent.setContentIfPublish(1);
			   }
			   if("0".equals(ifPublish)){
				   cmsSiteMenuContent.setContentIfPublish(0);
			   }
		   }*/
		   ResultMessage resultMessage = validForm("cmsSiteMenuContent", cmsSiteMenuContent, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (cmsSiteMenuContent.getSiteMenuContentId() == null){
		    	 cmsSiteMenuContent.setSiteMenuContentId(Long.valueOf(UniqueIdUtil.genId()));
		         this.cmsSiteMenuContentService.add(cmsSiteMenuContent);
			       
		         resultMsg = getText("保存成功", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1,"siteMenuContentId",cmsSiteMenuContent.getSiteMenuContentId());
		     }else{
		       this.cmsSiteMenuContentService.update(cmsSiteMenuContent);
		       
		       resultMsg = getText("更新成功", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1,"siteMenuContentId",cmsSiteMenuContent.getSiteMenuContentId());
		       }
	   }
	   
	   @ModelAttribute
	   protected CmsSiteMenuContent getFormObject(@RequestParam("siteMenuContentId") Long siteMenuContentId, Model model)  throws Exception
	   {
	     this.logger.debug("enter CmsSiteMenuContent getFormObject here....");
	     CmsSiteMenuContent cmsSiteMenuContent = null;
	     if (siteMenuContentId != null){
	    	 cmsSiteMenuContent = (CmsSiteMenuContent)this.cmsSiteMenuContentService.getById(siteMenuContentId);	    	 
	     } else {
	    	 cmsSiteMenuContent = new CmsSiteMenuContent(); 
	     }
	     return cmsSiteMenuContent;
	   }
}

