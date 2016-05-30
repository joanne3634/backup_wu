/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.controller.sysManager;

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

import com.deelon.loan.model.sysManager.TprojectAuction;
import com.deelon.loan.service.sysManager.TprojectAuctionService;

@ Controller
@ RequestMapping( { "/loan/sysManager/tprojectauction/" } )
public class TprojectAuctionFormController extends BaseFormController{
	
	   @Resource
	   private TprojectAuctionService tprojectAuctionService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新TprojectAuction")
	   public void save(HttpServletRequest request, HttpServletResponse response, TprojectAuction tprojectAuction, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tprojectAuction", tprojectAuction, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tprojectAuction.getAuctionId() == null){
		    	 tprojectAuction.setAuctionId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tprojectAuctionService.add(tprojectAuction);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tprojectAuctionService.update(tprojectAuction);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected TprojectAuction getFormObject(@RequestParam("auctionId") Long auctionId, Model model)  throws Exception
	   {
	     this.logger.debug("enter TprojectAuction getFormObject here....");
	     TprojectAuction tprojectAuction = null;
	     if (auctionId != null)
	    	 tprojectAuction = (TprojectAuction)this.tprojectAuctionService.getById(auctionId);
	     else {
	    	 tprojectAuction = new TprojectAuction();
	     }
	     return tprojectAuction;
	   }
}

