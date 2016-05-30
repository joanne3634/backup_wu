


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
import com.deelon.loan.service.front.TmoneymoveService;

@Controller				  
@RequestMapping( { "/loan/front/tmoneymove" } )
public class TmoneymoveFormController extends BaseFormController{
	 
	   @Resource
	   private TmoneymoveService tmoneymoveService; 
	   
	   /**编辑和添加的保存
	 * @param request
	 * @param response
	 * @param tmoneymove
	 * @param bindResult
	 * @throws Exception
	 */
	@RequestMapping({"save"})
	   @Action(description="添加或更新CmsSiteConfig")
	   public void save(HttpServletRequest request, HttpServletResponse response, TMoneymove tmoneymove, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tmoneymove", tmoneymove, bindResult, request);		     
		     if (resultMessage.getResult() == 0) { 
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		    
		     this.tmoneymoveService.update(tmoneymove);
		     resultMsg = getText("record.updated", new Object[] { "数据" });
		     writeResultMessage(response.getWriter(), resultMsg, 1);
		     
		   //  String path=cmsSiteConfig.getSiteDirPath();
		    // path=path+cmsSiteConfig.getSiteCode()+"\\"+cmsSiteConfig.getSiteTemplet()+"\\";
		    // FileUtil.createFolderFile(path); 
	   }
	   
	   @ModelAttribute
	   protected TMoneymove getFormObject(@RequestParam("moneyMoveId") Long moneyMoveId, Model model)  throws Exception
	   {
	     this.logger.debug("enter tmoneymove getFormObject here...."); 
	     TMoneymove tmoneymove = null;
	     if (moneyMoveId != null)
	    	 tmoneymove = (TMoneymove)this.tmoneymoveService.getById(moneyMoveId);
	     else {
	    	 tmoneymove = new TMoneymove();
	     }
	     return tmoneymove;
	   }
}

