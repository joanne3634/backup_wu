/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.controller.backstage;

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
import com.deelon.platform.model.system.Demension;

import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.service.front.TareaService;

@ Controller
@ RequestMapping( { "/loan/backstage/tarea/" } )
public class TareaFormController extends BaseFormController{
	
	   @Resource
	   private TareaService tareaService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新Tarea")
	   public void save(HttpServletRequest request, HttpServletResponse response, Tarea tarea, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tarea", tarea, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tarea.getAreaId() == null){
		    	 tarea.setAreaId(Long.valueOf(UniqueIdUtil.genId()));
		    	 tarea.setHelpCode("001");
		         this.tareaService.add(tarea, Tarea.class);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tareaService.update(tarea, Tarea.class);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected Tarea getFormObject(@RequestParam("areaId") Long areaId, Model model)  throws Exception
	   {
	     this.logger.debug("enter Tarea getFormObject here....");
	     Tarea tarea = null;
	     if (areaId != null)
	    	 tarea = (Tarea)this.tareaService.getById(areaId);
	     else {
	    	 tarea = new Tarea();
	     }
	     return tarea;
	   }
}

