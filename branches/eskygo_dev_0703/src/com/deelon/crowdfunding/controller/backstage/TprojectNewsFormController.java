package com.deelon.crowdfunding.controller.backstage;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */




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
import com.deelon.crowdfunding.model.backstage.TcprojectNews;
import com.deelon.crowdfunding.service.backstage.TprojectNewsService;
import com.deelon.platform.model.system.Demension;


@ Controller
@ RequestMapping( { "/loan/sysManager/tprojectnews/" } )
public class TprojectNewsFormController extends BaseFormController{
	
	   @Resource
	   private TprojectNewsService tprojectNewsService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新TprojectNews")
	   public void save(HttpServletRequest request, HttpServletResponse response, TcprojectNews tprojectNews, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("tprojectNews", tprojectNews, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		     String resultMsg = null;
		     if (tprojectNews.getNewsId() == null){
		    	 tprojectNews.setNewsId(Long.valueOf(UniqueIdUtil.genId()));
		         this.tprojectNewsService.add(tprojectNews);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.tprojectNewsService.update(tprojectNews);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected TcprojectNews getFormObject(@RequestParam("newsId") Long newsId, Model model)  throws Exception
	   {
	     this.logger.debug("enter TprojectNews getFormObject here....");
	     TcprojectNews tprojectNews = null;
	     if (newsId != null)
	    	 tprojectNews = (TcprojectNews)this.tprojectNewsService.getById(newsId);
	     else {
	    	 tprojectNews = new TcprojectNews();
	     }
	     return tprojectNews;
	   }
}

