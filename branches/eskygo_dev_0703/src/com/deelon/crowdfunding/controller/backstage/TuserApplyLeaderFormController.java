package com.deelon.crowdfunding.controller.backstage;

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
import com.deelon.crowdfunding.model.backstage.TuserApplyLeader;
import com.deelon.crowdfunding.service.backstage.TuserApplyLeaderService;

/**
 * Create By [MyLiao]
 * 申请领投资格审核表单Controller
 */
@ Controller
@ RequestMapping({"/crowdfunding/backstage/tuserapplyleader/"})
public class TuserApplyLeaderFormController extends BaseFormController{
	@Resource
	private TuserApplyLeaderService tuserApplyLeaderService;
	
	@RequestMapping({"save"})
	@Action(description="审核或修改领投人资格表单", execOrder=ActionExecOrder.BEFORE, detail="审核或修改领投人资格表单")
	public void save(HttpServletRequest request, HttpServletResponse response, TuserApplyLeader tuserApplyLeader, BindingResult bindResult) 
	throws Exception{
		ResultMessage resultMessage = validForm("tuserApplyLeader", tuserApplyLeader, bindResult, request);	
		if(resultMessage.getResult()==0){ 
			writeResultMessage(response.getWriter(), resultMessage);
			return;
		}
		String resultMsg = null;
		if(tuserApplyLeader.getApplyLeaderId() == null){//新增
			tuserApplyLeader.setApplyLeaderId(Long.valueOf(UniqueIdUtil.genId()));
			this.tuserApplyLeaderService.add(tuserApplyLeader);
			resultMsg = getText("record.added", new Object[] { "数据" });
	        writeResultMessage(response.getWriter(), resultMsg, 1);
		}else{//修改
			this.tuserApplyLeaderService.update(tuserApplyLeader);
			resultMsg = getText("record.updated", new Object[] { "数据" });
		    writeResultMessage(response.getWriter(), resultMsg, 1);
		}
	}
	
	@ModelAttribute
	protected TuserApplyLeader getFormObject(@RequestParam("applyLeaderId") Long ApplyLeaderId, Model model) 
	throws Exception{
	     this.logger.debug("enter TuserApplyLeader getFormObject here...."); 
	     TuserApplyLeader tuserApplyLeader = null;
	     if(ApplyLeaderId != null){
	    	 tuserApplyLeader = (TuserApplyLeader)this.tuserApplyLeaderService.getById(ApplyLeaderId);
	     }else{
	    	 tuserApplyLeader = new TuserApplyLeader();
	     }
	     return tuserApplyLeader;
	}
}
