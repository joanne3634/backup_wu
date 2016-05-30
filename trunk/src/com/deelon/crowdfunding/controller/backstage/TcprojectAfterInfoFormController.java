package com.deelon.crowdfunding.controller.backstage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.crowdfunding.model.backstage.TcprojectAfter;
import com.deelon.crowdfunding.service.backstage.TcprojectAfterService;

@Controller
@RequestMapping({ "/crowdfunding/tcprojectAfterInfo/" })
public class TcprojectAfterInfoFormController  extends BaseFormController{
	@Autowired
	private TcprojectAfterService tcprojectAfterService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新tcprojectAfter")
	   public void save(HttpServletRequest request, HttpServletResponse response, TcprojectAfter tcprojectAfter, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tcprojectAfter", tcprojectAfter, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tcprojectAfter.getAfterId() == null){
		    	 tcprojectAfter.setAfterId(Long.valueOf(UniqueIdUtil.genId()));
		    	 tcprojectAfterService.add(tcprojectAfter);
		         resultMsg = getText("添加成功", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		    	 TcprojectAfter tcprojectAfter2 = tcprojectAfterService.getById(tcprojectAfter.getAfterId());
		    	 tcprojectAfter2.setPaTitle(tcprojectAfter.getPaTitle());
		    	 tcprojectAfter2.setPaContent(tcprojectAfter.getPaContent());
		    	 tcprojectAfter2.setFileId(tcprojectAfter.getFileId());
		    	 tcprojectAfterService.update(tcprojectAfter2);
		       resultMsg = getText("修改成功", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }

}
