package com.deelon.crowdfunding.controller.front;


import java.util.Date;
import java.util.List;









import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectNews;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.backstage.TprojectNewsService;
import com.deelon.crowdfunding.service.front.TcprojectFrontSaveService;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.service.front.TmoneymoveService;

@Controller
@RequestMapping({ "/tcproject/ProjectDynamic/" })
public class ProjectDynamicFromController extends BaseController{

	@Resource
	   private TprojectNewsService tprojectNewsService; 
	
	@Resource
	   private TcprojectFrontSaveService tcprojectFrontSaveService;
	
	@Resource
	   private TcprojectService tcprojectService; 
	   
	   /**编辑和添加的保存
	 * @param request
	 * @param response
	 * @param TcprojectNews
	 * @param bindResult
	 * @throws Exception
	 */
	@RequestMapping({"editTProject"})
	   @Action(description="添加或更新会员后台的项目动态")
	   public void save(HttpServletRequest request, HttpServletResponse response, TcprojectNews TcprojectNews, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("TcprojectNews", TcprojectNews, bindResult, request);
//		     if (resultMessage.getResult() == 0) { 
//		    	 System.out.println("------------------->进这里干嘛！！！");
//		       writeResultMessage(response.getWriter(), resultMessage);
//		       return;
//		     }
		     String resultMsg = null;
		     System.out.println("------------------->"+TcprojectNews.getPncontent());
		     this.tcprojectFrontSaveService.saveTcprojectNewsInfo(TcprojectNews);
		     
		     Tcproject tcproject = tcprojectService.getById(TcprojectNews.getProjectId());
		     tcproject.setUpdateTime(new Date());   //更新项目更新时间
		     tcprojectService.update(tcproject);
		     
		     this.writeObjectToClient("保存成功", response);
		     
		     //resultMsg = getText("record.updated", new Object[] { "数据" });
		     //writeResultMessage(response.getWriter(), resultMsg, 1);
	   }
	   
	   @ModelAttribute
	   protected TcprojectNews getFormObject(@RequestParam("newsId") Long newsId, Model model)  throws Exception
	   {
	     this.logger.debug("enter tcprojectNews getFormObject here...."); 
	     TcprojectNews tcprojectNews = null;
	     if (newsId != null)
	    	 tcprojectNews = (TcprojectNews)this.tprojectNewsService.getById(newsId);
	     else {
	    	 tcprojectNews = new TcprojectNews();
	     }
	     return tcprojectNews;
	   }
}
