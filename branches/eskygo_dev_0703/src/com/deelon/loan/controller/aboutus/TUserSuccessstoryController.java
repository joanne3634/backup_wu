package com.deelon.loan.controller.aboutus;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.aboutus.TUserMessage;
import com.deelon.loan.model.aboutus.TUserSuccessstory;
import com.deelon.loan.service.aboutus.TUserSuccessstoryService;

/**
 * @author Administrator
 * @version成功故事
 * 
 */
@Controller
@RequestMapping({ "/loan/aboutus/tUserSuccessstory/" })
public class TUserSuccessstoryController extends BaseController {

	@Resource
	private TUserSuccessstoryService tUserSuccessstoryService;

	@RequestMapping({ "list" })
	// 处理方法url 与控制器url对应 等于/cmsform/site/TUserSuccessstory/list
	@Action(description = "查看TUserSuccessstory分页列表")
	public ModelAndView list(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List list = this.tUserSuccessstoryService.getAll(new QueryFilter(request,"TUserSuccessstoryItem")); 
		return new ModelAndView("/loan/aboutus/TUserSuccessstoryList.jsp")
				.addObject("TUserSuccessstoryList", list);// 返回的逻辑视图名
	}
	
	@RequestMapping({ "fontlist" })
	public ModelAndView fontList(HttpServletRequest request,
			HttpServletResponse response) throws Exception { 
		
		QueryFilter filter = new QueryFilter(); 
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",5);
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List   list =tUserSuccessstoryService.getAll(filter);//.getAll(filter,TUserSuccessstory.class); //tusermessageService.getBySqlKeyAll(filter, TUserMessage.class, "getUserId");
		 request.setAttribute( "page_bean", pb );
		return new ModelAndView("/loan/aboutus/SuccessStory.jsp")
				.addObject("TUserSuccessstoryList", list).addObject( "page_bean", pb );// 返回的逻辑视图名
	}

	@RequestMapping({ "SuceesstoryDetails" })
	@Action(description = "成功故事详情") 
	public ModelAndView SuceesstoryDetails(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		long messageid=Long.parseLong(request.getParameter("messageid"));
		 TUserSuccessstory  list=tUserSuccessstoryService.getById(messageid);
		return new ModelAndView("/loan/aboutus/SuceesstoryDetails.jsp").addObject("TUserSuccessstory",list);
	}
	@RequestMapping({ "del" })
	@Action(description = "删除TUserSuccesstory数据")
	public void del(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage(request);
		String messageIds = request.getParameter("messageId");
		for (int i = 0; i < messageIds.length(); i++) {
			int a = messageIds.indexOf(",");
			if (a < 0) {
				long messageId = Long.parseLong(messageIds);
				this.tUserSuccessstoryService.del(messageId);
			} else {
				long messageId = Long.parseLong(messageIds.substring(0, a));
				this.tUserSuccessstoryService.del(messageId);
				messageIds = messageIds.substring(a + 1);
			}
		}
		message = new ResultMessage(1, "删除数据成功");
		addMessage(message, request);
		response.sendRedirect(preUrl);
	}
	
	@RequestMapping({ "edit" })
	@Action(description = "添加编辑故事")
	public ModelAndView edit(HttpServletRequest request) throws Exception {
		long pkId = RequestUtil.getLong(request, "messageId");
		TUserSuccessstory tuserSuccessstory=null;
		if(pkId==0){
			tuserSuccessstory=new TUserSuccessstory();
		}else{
			tuserSuccessstory= (TUserSuccessstory) this.tUserSuccessstoryService
					.getById(Long.valueOf(pkId)); 
		}  
		return new ModelAndView("/loan/aboutus/TuserSuccesStoryEdit.jsp")
				.addObject("tuserSuccessstory", tuserSuccessstory);
	}
	@RequestMapping({ "tuserSuccessstorysave" })
	@Action(description = "添加或更新tuserSuccessstorysave") 
	@ResponseBody
	public String   save(HttpServletRequest request, HttpServletResponse response, TUserSuccessstory tuserSuccessstory)
			throws Exception { 
		String a="0";
		if(tuserSuccessstory.getSuccessstoryId()==0){
			tUserSuccessstoryService.add(tuserSuccessstory); 
			a="1";
		}else{
			tUserSuccessstoryService.update(tuserSuccessstory); 
			a=a;
		} 
		return a;
	}  
	@RequestMapping({ "get" })
	@Action(description = "查看TUserSuccessstory数据")
	public ModelAndView get(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		long pkId = RequestUtil.getLong(request, "messageId");
		TUserSuccessstory tuserSuccessstory = (TUserSuccessstory) this.tUserSuccessstoryService
				.getById(Long.valueOf(pkId));  
		return new ModelAndView("loan/aboutus/TUserSuccessstoryGet.jsp").addObject(
				"tuserSuccessstory", tuserSuccessstory);
	}
}
