package com.deelon.loan.controller.sysManager;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.sysManager.TsettingsEmail;
import com.deelon.loan.model.sysManager.TsettingsSms;
import com.deelon.loan.service.sysManager.TsettingsEmailService;
import com.deelon.loan.service.sysManager.TsettingsSmsService;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.service.system.DemensionService;

import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@ Controller
@ RequestMapping( { "/loan/sysManager/tsettingssms/" } )
public class TsettingsSmsController extends BaseController{
	
	@ Resource
	private TsettingsSmsService tsettingsSmsService;
	
	@Resource
	private TsettingsEmailService tsettingsEmailService;


	/**
	 * 跳转编辑页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "get" } )
	@ Action( description = "查看TsettingsSms数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		TsettingsSms tsettingsSms = (TsettingsSms) this.tsettingsSmsService.getFirstOneSms();
		TsettingsEmail tsettingsEmail =(TsettingsEmail)this.tsettingsEmailService.getFirstOneEmail();
		ModelAndView mv =new ModelAndView("/loan/sysManager/tsettingssmsEdit.jsp").addObject( "tsettingsSms", tsettingsSms ).addObject("tsettingsEmail", tsettingsEmail);
		return mv;
	}
	
	/**
	 * 保存短信设置
	 * @param request
	 * @param response
	 * @param tsettingsSms
	 * @throws Exception
	 */
	@ RequestMapping({"savesms"})
	@ResponseBody
	public void savesms(HttpServletRequest request, HttpServletResponse response,TsettingsSms tsettingsSms) throws Exception{
		 /*ResultMessage resultMessage = validForm("tsettingsSms", tsettingsSms, bindResult, request);		   
	     if (resultMessage.getResult() == 0) {
	       writeResultMessage(response.getWriter(), resultMessage);
	       return;
	     }*/
		//添加更新时间，更新人
		Long currentUserId =ContextUtil.getCurrentUser().getUserId();
		tsettingsSms.setUpated(currentUserId);
		Date date =new Date();
		tsettingsSms.setUpateTime(date);
	     String resultMsg = null;
	     if (tsettingsSms.getSmsid() == null){
	    	 tsettingsSms.setSmsid(Long.valueOf(UniqueIdUtil.genId()));
	         this.tsettingsSmsService.add(tsettingsSms);
	         resultMsg = getText("record.added", new Object[] { "数据" });
	         writeResultMessage(response.getWriter(), resultMsg, 1);
	     }else{
	       this.tsettingsSmsService.update(tsettingsSms);
	       resultMsg = getText("record.updated", new Object[] { "数据" });
	       writeResultMessage(response.getWriter(), resultMsg, 1);
	     }
	}
	
	/**
	 * 保存邮件设置
	 * @param request
	 * @param response
	 * @param tsettingsEmail
	 * @throws Exception
	 */
	@ RequestMapping({"saveemail"})
	@ResponseBody
	public void saveemail(HttpServletRequest request, HttpServletResponse response,TsettingsEmail tsettingsEmail) throws Exception{
		 /*ResultMessage resultMessage = validForm("tsettingsSms", tsettingsSms, bindResult, request);		   
	     if (resultMessage.getResult() == 0) {
	       writeResultMessage(response.getWriter(), resultMessage);
	       return;
	     }*/
	     String resultMsg = null;
	     if (tsettingsEmail.getEmailId() == null){
	    	 tsettingsEmail.setEmailId(Long.valueOf(UniqueIdUtil.genId()));
	         this.tsettingsEmailService.add(tsettingsEmail);
	         resultMsg = getText("record.added", new Object[] { "数据" });
	         writeResultMessage(response.getWriter(), resultMsg, 1);
	     }else{
	       this.tsettingsEmailService.update(tsettingsEmail);
	       resultMsg = getText("record.updated", new Object[] { "数据" });
	       writeResultMessage(response.getWriter(), resultMsg, 1);
	     }
	}
}

