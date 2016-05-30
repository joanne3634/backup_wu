/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.controller.sysManager;

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
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.sysManager.Tinfotemplatparam;
import com.deelon.loan.service.sysManager.TinfotemplatparamService;

@ Controller
@ RequestMapping( { "/loan/sysManager/tinfotemplatparam/" } )
public class TinfotemplatparamFormController extends BaseFormController{
	
	   @Resource
	   private TinfotemplatparamService tinfotemplatparamService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新Tinfotemplatparam")
	   public void save(HttpServletRequest request, HttpServletResponse response, Tinfotemplatparam tinfotemplatparam, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tinfotemplatparam", tinfotemplatparam, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tinfotemplatparam.getInfoTemplatParamId() == null){
		    	 tinfotemplatparam.setCreator(ContextUtil.getCurrentUserId());
		    	 tinfotemplatparam.setCreateTime(new Date());
		    	 tinfotemplatparam.setInfoTemplatParamId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tinfotemplatparamService.add(tinfotemplatparam);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tinfotemplatparamService.update(tinfotemplatparam);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected Tinfotemplatparam getFormObject(@RequestParam("infoTemplatParamId") Long infoTemplatParamId, Model model)  throws Exception
	   {
	     this.logger.debug("enter Tinfotemplatparam getFormObject here....");
	     Tinfotemplatparam tinfotemplatparam = null;
	     if (infoTemplatParamId != null)
	    	 tinfotemplatparam = (Tinfotemplatparam)this.tinfotemplatparamService.getById(infoTemplatParamId);
	     else {
	    	 tinfotemplatparam = new Tinfotemplatparam();
	     }
	     return tinfotemplatparam;
	   }
}

