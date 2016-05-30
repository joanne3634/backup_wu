/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.controller.sysManager;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSONArray;
import com.deelon.core.annotion.Action;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.sysManager.Tinfotemplat;
import com.deelon.loan.model.sysManager.Tinfotemplatparam;
import com.deelon.loan.service.sysManager.TinfotemplatService;
import com.deelon.loan.service.sysManager.TinfotemplatparamService;

@ Controller
@ RequestMapping( { "/loan/sysManager/tinfotemplat/" } )
public class TinfotemplatFormController extends BaseFormController{
	
	   @Resource
	   private TinfotemplatService tinfotemplatService;
	   @ Resource
	   private TinfotemplatparamService tinfotemplatparamService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新Tinfotemplat")
	   public void save(HttpServletRequest request, HttpServletResponse response, Tinfotemplat tinfotemplat, BindingResult bindResult, String infotemplatparams) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tinfotemplat", tinfotemplat, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tinfotemplat.getInfoTemplateId() == null){
		    	 
		    	 Long infoTemplateId = UniqueIdUtil.genId();
		    	 tinfotemplat.setInfoTemplateId(infoTemplateId);
		    	 tinfotemplat.setCreator(ContextUtil.getCurrentUserId());
		    	 tinfotemplat.setCreateTime(new Date());
		         this.tinfotemplatService.add(tinfotemplat);
		         if(StringUtil.isNotEmpty(infotemplatparams)){
		        	 List<Tinfotemplatparam> params = JSONArray.parseArray(infotemplatparams, Tinfotemplatparam.class);
		        	 if(params !=null && params.size()>0){
		        		 for(Tinfotemplatparam param : params){
		        			 param.setInfoTemplatParamId(UniqueIdUtil.genId());
		        			 param.setInfoTemplatId(infoTemplateId);
		        			 param.setCreator(ContextUtil.getCurrentUserId());
		        			 param.setCreateTime(new Date());
		        			 tinfotemplatparamService.add(param);
		        		 }
		        	 }
		         }
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tinfotemplatService.update(tinfotemplat);
		       if(StringUtil.isNotEmpty(infotemplatparams)){
		        	 List<Tinfotemplatparam> params = JSONArray.parseArray(infotemplatparams, Tinfotemplatparam.class);
		        	 if(params !=null && params.size()>0){
		        		 for(Tinfotemplatparam param : params){
		        			 param.setInfoTemplatParamId(UniqueIdUtil.genId());
		        			 param.setInfoTemplatId(tinfotemplat.getInfoTemplateId());
		        			 param.setCreator(ContextUtil.getCurrentUserId());
		        			 param.setCreateTime(new Date());
		        			 tinfotemplatparamService.add(param);
		        		 }
		        	 }
		         }
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected Tinfotemplat getFormObject(@RequestParam("infoTemplateId") Long infoTemplateId, Model model)  throws Exception
	   {
	     this.logger.debug("enter Tinfotemplat getFormObject here....");
	     Tinfotemplat tinfotemplat = null;
	     if (infoTemplateId != null)
	    	 tinfotemplat = (Tinfotemplat)this.tinfotemplatService.getById(infoTemplateId);
	     else {
	    	 tinfotemplat = new Tinfotemplat();
	     }
	     return tinfotemplat;
	   }
}

