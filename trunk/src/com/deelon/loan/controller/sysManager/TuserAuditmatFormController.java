package com.deelon.loan.controller.sysManager;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */




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
import com.deelon.loan.model.front.TUserAuditMat;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.TuserCredit;
import com.deelon.loan.service.front.TUserAuditMatService;
import com.deelon.loan.service.front.TuserCreditService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.model.system.SysAuditModelType;


@ Controller
@ RequestMapping( { "/loan/sysManager/tuserauditmat/" } )
@Action(ownermodel=SysAuditModelType.TUSERAUDITMAT)
public class TuserAuditmatFormController extends BaseFormController{
	
	   @Resource
	   private TUserAuditMatService tuserAuditmatService;

	   @Resource
	   private TuserCreditService tuserCreditService;
	   @Resource
	   private TuserFundsService tuserFundsService;
	   @RequestMapping({"save"})
	   @Action(description="添加或更新TuserAuditmat", execOrder=ActionExecOrder.BEFORE, detail="添加或更新TuserAuditmat")
	   public void save(HttpServletRequest request, HttpServletResponse response, TUserAuditMat tuserAuditmat, BindingResult bindResult) throws Exception
	   {
		   
		   //信誉度
		   //int pass =tuserAuditmat.getIsPass();
		   //if(pass==1){
			   
			 //  TuserCredit tuserCredit =new TuserCredit();
			 //  tuserCredit.setUserId(tuserAuditmat.getUserId());
			   //上传资料
			 //  tuserCredit.setTypeId(1);
			//   tuserCredit.setKeyId((long)tuserAuditmat.getAuditMatId());
			//   tuserCredit.setCreditAdd(5);
			 //  tuserCredit.setDescription("上传资料审核通过");
			//   Date date =new Date();
			//   tuserCredit.setCreateTime(date);
			//   tuserCreditService.saveTuserCredit(tuserCredit);
			   //t_userFunds表
			//	TUserFunds tuserFunds=tuserFundsService.getfundsCredit(tuserAuditmat.getUserId());
			//	String groupId =tuserFunds.getUser().getGroupId();
			//	int creditOut =tuserFunds.getCreditOut();
			//	int creditIn =tuserFunds.getCreditIn();
				//1.out 2.in
			//	if("1".equals(groupId)){
			//		tuserFunds.setCreditOut(creditOut+5);
			//		tuserFundsService.update(tuserFunds);
			//	}else if("2".equals(groupId)){
			//		tuserFunds.setCreditIn(creditIn+5);
			///		tuserFundsService.update(tuserFunds);
			//	}

		  // }
		   ResultMessage resultMessage = validForm("tuserAuditmat", tuserAuditmat, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tuserAuditmat.getAuditMatId() == null){
		    	 //tuserAuditmat.setAuditMatId(Integer.valueOf(UniqueIdUtil.genId()));
		         this.tuserAuditmatService.add(tuserAuditmat);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		    	 tuserAuditmat.setChecker(ContextUtil.getCurrentUserId().longValue());
		    	 tuserAuditmat.setCheckTime(new Date());
		    	 this.tuserAuditmatService.update(tuserAuditmat);
		    	 resultMsg = getText("record.updated", new Object[] { "数据" });
		    	 writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected TUserAuditMat getFormObject(@RequestParam("auditMatId") Long auditMatId, Model model)  throws Exception
	   {
	     this.logger.debug("enter TuserAuditmat getFormObject here....");
	     TUserAuditMat tuserAuditmat = null;
	     if (auditMatId != null)
	    	 tuserAuditmat = (TUserAuditMat)this.tuserAuditmatService.getById(auditMatId);
	     else {
	    	 tuserAuditmat = new TUserAuditMat();
	     }
	     return tuserAuditmat;
	   }
}

