


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
import com.deelon.core.encrypt.EncryptUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.loan.model.front.TriskCompany;
import com.deelon.loan.service.front.TriskCompanyService;
import com.deelon.platform.model.system.SysAuditModelType;

@Controller				  
@RequestMapping( { "/loan/front/riskCompany/" } )
@Action(ownermodel=SysAuditModelType.RISKCOMPANY_MANAGEMENT)
public class TRiskCompanyFormController extends BaseFormController{
	 
	   @Resource
	   private TriskCompanyService triskCompanyService; 
	   
	   @RequestMapping({"save"})
	   @ Action( description = "添加或者修改TriskCompany数据",execOrder=ActionExecOrder.BEFORE,detail="添加或者修改TriskCompany数据")
	   public void save(HttpServletRequest request, HttpServletResponse response, TriskCompany triskCompany, BindingResult bindResult) throws Exception
	   {
		   EncryptUtil encryptUtil = new EncryptUtil();
		   ResultMessage resultMessage = validForm("triskCompany", triskCompany, bindResult, request);		     
		     if (resultMessage.getResult() == 0) { 
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     String psd= encryptUtil.encrypt(triskCompany.getRcPaypwd());//密码加密
		     triskCompany.setRcPaypwd(psd);
		     if (triskCompany.getCompanyId() == null){					//添加
		    	 if (triskCompany.getRcDefault()==1) {					//是否为默认机构  ==1  是
		    		 triskCompanyService.updateDefault(triskCompany);	//修改其他默认值为0
				}
				triskCompany.setCompanyId(Long.valueOf(UniqueIdUtil.genId()));
			    this.triskCompanyService.add(triskCompany);
			    resultMsg = getText("record.added", new Object[] { "数据" });
			    writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{														//修改
			    if (triskCompany.getRcDefault()==1) {					//是否为默认机构  ==1  是
			    	triskCompanyService.updateDefault(triskCompany);	//修改其他默认值为0
				}
				this.triskCompanyService.update(triskCompany);
				resultMsg = getText("record.updated", new Object[] { "数据" });
				writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected TriskCompany getFormObject(@RequestParam("companyId") Long companyId, Model model)  throws Exception
	   {
	     this.logger.debug("enter triskCompany getFormObject here...."); 
	     TriskCompany triskCompany = null;
	     if (companyId != null)
	    	 triskCompany = (TriskCompany)this.triskCompanyService.getById(companyId);
	     else {
	    	 triskCompany = new TriskCompany();
	     }
	     return triskCompany;
	   }
}

