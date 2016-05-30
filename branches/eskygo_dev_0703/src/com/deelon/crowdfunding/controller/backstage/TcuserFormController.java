/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.controller.backstage;

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
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TuserSafeService;

@ Controller
@ RequestMapping( { "/crowdfunding/TCUser/tcuser/" } )
public class TcuserFormController extends BaseFormController{
	
	   @Resource
	   private TUserService tuserService;
	   
	   @Resource
	   private TuserSafeService tuserSafeService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新Tuser")
	   public void save(HttpServletRequest request, HttpServletResponse response, TUser tuser, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tuser", tuser, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tuser.getUserId() == 0L){
		    	 tuser.setUserId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tuserService.add(tuser);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tuserService.update(tuser);
		       TUserSafe tUserSafe = new TUserSafe();
		       tUserSafe.setUserId(tuser.getUserId());
		       tUserSafe.setIdNo(tuser.getIdNo());
		       tUserSafe.setEmail(tuser.getEmail());
		       tUserSafe.setMobile(tuser.getMobile());
		       System.out.println("-->"+tUserSafe.getUserId()+"-->"+tUserSafe.getMobile()+"-->"+tUserSafe.getEmail()+"-->"+tUserSafe.getIdNo());
		       this.tuserService.updateUserSafeByUserId(tUserSafe);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected TUser getFormObject(@RequestParam("userId") Long userId, Model model)  throws Exception
	   {
	     this.logger.debug("enter Tuser getFormObject here....");
	     TUser tuser = null;
	     if (userId != null)
	    	 tuser = (TUser)this.tuserService.getById(userId);
	     else {
	    	 tuser = new TUser();
	     }
	     return tuser;
	   }
}

