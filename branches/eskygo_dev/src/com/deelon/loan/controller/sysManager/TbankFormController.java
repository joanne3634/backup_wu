package com.deelon.loan.controller.sysManager;

import java.util.Date;
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
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.loan.model.sysManager.Tbank;
import com.deelon.loan.service.sysManager.TbankService;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.model.system.SysAuditModelType;


@ Controller
@ RequestMapping( { "/loan/sysManager/tbank/" } )
@Action(ownermodel=SysAuditModelType.BANK_MANAGEMENT)
public class TbankFormController extends BaseFormController{
	
	   @Resource
	   private TbankService tbankService;

	   /**
	    * 编辑和添加保存
	 * @param request
	 * @param response
	 * @param tbank
	 * @param bindResult
	 * @throws Exception
	 */
	@RequestMapping({"save"})
	   @Action(description="添加或更新Tbank",execOrder=ActionExecOrder.BEFORE,detail="添加或更新Tbank")
	   public void save(HttpServletRequest request, HttpServletResponse response, Tbank tbank, BindingResult bindResult) throws Exception
	   {
			//未没有上级银行的赋值-0
			if(tbank.getParentId()==null){
				tbank.setParentId(0l);
			}
		    ResultMessage resultMessage = validForm("tbank", tbank, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tbank.getBankId() == null){
		    	 tbank.setBankId(Long.valueOf(UniqueIdUtil.genId()));
		    	//添加创建人和创建时间
		    	 Long currentUserId = ContextUtil.getCurrentUserId();
		    	 tbank.setCreator(currentUserId);
		    	 Date date =new Date();
		    	 tbank.setCreateTime(date);
		         this.tbankService.add(tbank);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		    	//添加创建人和创建时间
		    	 Long currentUserId = ContextUtil.getCurrentUserId();//.getCurrentUser().getUserId();
		    	 tbank.setCreator(currentUserId);
		    	 Date date =new Date();
		    	 tbank.setCreateTime(date);
			     this.tbankService.update(tbank);
			     resultMsg = getText("record.updated", new Object[] { "数据" });
			     writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected Tbank getFormObject(@RequestParam("bankId") Long bankId, Model model)  throws Exception
	   {
	     this.logger.debug("enter Tbank getFormObject here....");
	     Tbank tbank = null;
	     if (bankId != null)
	    	 tbank = (Tbank)this.tbankService.getById(bankId);
	     else {
	    	 tbank = new Tbank();
	     }
	     return tbank;
	   }
}

