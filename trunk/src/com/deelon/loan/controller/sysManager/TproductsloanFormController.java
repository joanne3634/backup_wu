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
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.productsloan.Tproductsloan;
import com.deelon.loan.service.sysManager.TproductsloanService;
import com.deelon.platform.model.system.SysAuditModelType;

@ Controller
@ RequestMapping( { "/loan/sysManager/productloan/" } )
@Action(ownermodel=SysAuditModelType.PRODUCTSLOAN)
public class TproductsloanFormController extends BaseFormController{
	
	   @Resource
	   private TproductsloanService tproductsloanService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新Tproductsloan", execOrder=ActionExecOrder.BEFORE, detail="添加或更新Tproductsloan")
	   public void save(HttpServletRequest request, HttpServletResponse response, Tproductsloan tproductsloan, BindingResult bindResult) throws Exception
	   {
		   String preUrl = RequestUtil.getPrePage( request );
		   ResultMessage resultMessage = validForm("tproductsloan", tproductsloan, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     tproductsloan.setCreator(ContextUtil.getCurrentUser().getUserId());
	    	 tproductsloan.setCreateTime(new Date());
		     if (tproductsloan.getProductsLoanId() == null){
		    	 tproductsloan.setProductsLoanId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tproductsloanService.addproductsAndSumlist(tproductsloan);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tproductsloanService.updateproductsAndSumlist(tproductsloan);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
		     //response.sendRedirect(preUrl);
	   }
	   
	   @ModelAttribute
	   protected Tproductsloan getFormObject(@RequestParam("productsLoanId") Long productsLoanId, Model model)  throws Exception
	   {
	     this.logger.debug("enter Tproductsloan getFormObject here....");
	     Tproductsloan tproductsloan = null;
	     if (productsLoanId != null)
	    	 tproductsloan = (Tproductsloan)this.tproductsloanService.getById(productsLoanId);
	     else {
	    	 tproductsloan = new Tproductsloan();
	     }
	     return tproductsloan;
	   }
}

