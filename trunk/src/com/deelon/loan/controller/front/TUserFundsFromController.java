/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */


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

import com.deelon.core.annotion.Action;
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.platform.model.system.SysAuditModelType;

@ Controller
@ RequestMapping( { "/loan/front/userFunds/" } )
@Action(ownermodel=SysAuditModelType.TUSERFUNDS)
public class TUserFundsFromController extends BaseFormController{
	
	   @Resource
	   private TuserFundsService tuserFundsService;

	   @RequestMapping({"save"})
	   @ Action( description = "增加TuserFunds数据",execOrder=ActionExecOrder.BEFORE,detail="增加TuserFunds数据")
	   public void save(HttpServletRequest request, HttpServletResponse response, TUserFunds tUserFunds, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tUserFunds", tUserFunds, bindResult, request);	
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tUserFunds.getFundsId()==0){		//添加
		    	 tUserFunds.setFundsId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tuserFundsService.add(tUserFunds);
			       
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1,"fundsId",tUserFunds.getFundsId());
		     }else{									//修改
		       this.tuserFundsService.update(tUserFunds);
		       
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1,"fundsId",tUserFunds.getFundsId());
		       }
	   }
	   
	   @ModelAttribute
	   protected TUserFunds getFormObject(@RequestParam("fundsId") Long fundsId, Model model)  throws Exception
	   {
	     this.logger.debug("enter TUserFunds getFormObject here....");
	     TUserFunds cmsSiteMenuContent = null;
	     if (fundsId != null){
	    	 cmsSiteMenuContent = (TUserFunds)this.tuserFundsService.getById(fundsId);	    	 
	     } else {
	    	 cmsSiteMenuContent = new TUserFunds(); 
	     }
	     return cmsSiteMenuContent;
	   }
}

