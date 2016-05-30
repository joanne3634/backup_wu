package com.deelon.loan.controller.sysManager;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.deelon.core.annotion.Action;
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.sysManager.TSetHomepage;
import com.deelon.loan.service.sysManager.TsetHomepageService;
import com.deelon.platform.model.system.SysAuditModelType;

@Controller
@RequestMapping({"/loan/sysManager/homeWidgetShow/"})
@Action(ownermodel=SysAuditModelType.HOME_WIDGETSHOW)
public class HomeWidgetShowFormController extends BaseFormController {

	@Resource
	private TsetHomepageService tsetHomepageService;
	
	@Action(description="网贷首页模块管理 保存",execOrder=ActionExecOrder.BEFORE,detail="网贷首页模块管理 保存")
	 @RequestMapping({"save"})
	  public void save(HttpServletRequest request, HttpServletResponse response, TSetHomepage tSetHomepage, BindingResult bindResult)
	    throws Exception {
		 ResultMessage resultMessage = validForm("tsetHomepage", tSetHomepage, bindResult, request);	
		 if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		 String resultMsg = null;
		 if (tSetHomepage.getHomePageId() == null){
			 tSetHomepage.setHomePageId(Long.valueOf(UniqueIdUtil.genId()));
	         this.tsetHomepageService.add(tSetHomepage);
	         resultMsg = getText("数据增加成功!", new Object[] { "数据" });
	         writeResultMessage(response.getWriter(), resultMsg, 1);
	     }else{
	       this.tsetHomepageService.update(tSetHomepage);
	       resultMsg = getText("数据更新成功!", new Object[] { "数据" });
	       writeResultMessage(response.getWriter(), resultMsg, 1);
	     }
		 
	  }
}
