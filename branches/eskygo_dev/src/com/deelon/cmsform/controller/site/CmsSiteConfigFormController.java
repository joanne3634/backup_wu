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

import com.deelon.cmsform.model.site.CmsSiteConfig;
import com.deelon.cmsform.service.site.CmsSiteConfigService;
import com.deelon.core.annotion.Action;
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.platform.model.system.SysAuditModelType;

@Controller				  
@RequestMapping( { "/cmsform/site/cmssiteconfig/" } )
@Action(ownermodel=SysAuditModelType.CMSSITECONFIG_MANAGEMENT)
public class CmsSiteConfigFormController extends BaseFormController{
	 
	   @Resource
	   private CmsSiteConfigService cmsSiteConfigService; 
	   
	   @RequestMapping({"save"})
	   @Action(description="添加或更新CmsSiteConfig", execOrder=ActionExecOrder.BEFORE, detail="添加或更新CmsSiteConfig")
	   public void save(HttpServletRequest request, HttpServletResponse response, CmsSiteConfig cmsSiteConfig, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("cmsSiteConfig", cmsSiteConfig, bindResult, request);		     
		     if (resultMessage.getResult() == 0) { 
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (cmsSiteConfig.getSiteConfigId() == null){
		    	 cmsSiteConfig.setSiteConfigId(Long.valueOf(UniqueIdUtil.genId()));
		         this.cmsSiteConfigService.add(cmsSiteConfig);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);		       
		     }else{
		       this.cmsSiteConfigService.update(cmsSiteConfig);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
		   //  String path=cmsSiteConfig.getSiteDirPath();
		    // path=path+cmsSiteConfig.getSiteCode()+"\\"+cmsSiteConfig.getSiteTemplet()+"\\";
		    // FileUtil.createFolderFile(path); 
	   }
	   
	   @ModelAttribute
	   protected CmsSiteConfig getFormObject(@RequestParam("siteConfigId") Long SiteConfigId, Model model)  throws Exception
	   {
	     this.logger.debug("enter CmsSiteConfig getFormObject here...."); 
	     CmsSiteConfig cmsSiteConfig = null;
	     if (SiteConfigId != null)
	    	 cmsSiteConfig = (CmsSiteConfig)this.cmsSiteConfigService.getById(SiteConfigId);
	     else {
	    	 cmsSiteConfig = new CmsSiteConfig();
	     }
	     return cmsSiteConfig;
	   }
}

