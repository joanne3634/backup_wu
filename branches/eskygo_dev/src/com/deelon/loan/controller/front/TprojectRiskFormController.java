


package com.deelon.loan.controller.front;

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
import com.deelon.core.util.FileUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TProjectRisk;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.front.TprojectRiskService;

@Controller				  
@RequestMapping( { "/site/tprojectRisk/" } )
public class TprojectRiskFormController extends BaseFormController{
	 
	   @Resource
	   private TprojectRiskService tprojectRiskService; 
	   
	   /**
	    * 编辑和添加的保存功能
	 * @param request
	 * @param response
	 * @param tprojectRisk
	 * @param bindResult
	 * @throws Exception
	 */
	@RequestMapping({"save"})
	   @Action(description="添加或更新CmsSiteConfig")
	   public void save(HttpServletRequest request, HttpServletResponse response, TProjectRisk tprojectRisk, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tprojectRisk", tprojectRisk, bindResult, request);		     
		     if (resultMessage.getResult() == 0) { 
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tprojectRisk.getRiskId()== null){
		    	 tprojectRisk.setRiskId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tprojectRiskService.add(tprojectRisk);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);		       
		     }else{
		       this.tprojectRiskService.update(tprojectRisk);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
		   //  String path=cmsSiteConfig.getSiteDirPath();
		    // path=path+cmsSiteConfig.getSiteCode()+"\\"+cmsSiteConfig.getSiteTemplet()+"\\";
		    // FileUtil.createFolderFile(path); 
	   }
	   
	   @ModelAttribute
	   protected TProjectRisk getFormObject(@RequestParam("riskId") Long riskId, Model model)  throws Exception
	   {
	     this.logger.debug("enter tprojectRisk getFormObject here...."); 
	     TProjectRisk tprojectRisk = null;
	     if (riskId != null)
	    	 tprojectRisk = (TProjectRisk)this.tprojectRiskService.getById(riskId);
	     else {
	    	 tprojectRisk = new TProjectRisk();
	     }
	     return tprojectRisk;
	   }
}

