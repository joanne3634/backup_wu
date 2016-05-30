package com.deelon.loan.controller.sysManager;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.log.SysAuditThreadLocalHolder;
import com.deelon.core.util.BeanUtils;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.sysManager.TSetHomepage;
import com.deelon.loan.service.sysManager.TsetHomepageService;

@Controller
@RequestMapping({ "/loan/sysManager/homeWidgetShow/" })
public class HomeWidgetShowController extends BaseController {
	 
	@Resource
	private TsetHomepageService tsetHomepageService;
	
	@Action(description="网贷首页模块展示管理列表")
	 @RequestMapping({"list"})
	  public ModelAndView list(HttpServletRequest request, HttpServletResponse response)
	    throws Exception
	  {
	    Long homePageId = Long.valueOf(RequestUtil.getLong(request, "homePageId"));
	    List<TSetHomepage> list = tsetHomepageService.getTSetHomepageByQuery(new QueryFilter(request, "homePageId"));
	    ModelAndView mv = getAutoView().addObject("ListVo", list);//.addObject("userId", homePageId);
	    
	    return mv;
	  }
	 
	@Action(description="编辑")
	 @RequestMapping({"edit"})
	  public ModelAndView edit(HttpServletRequest request,HttpServletResponse response)
	    throws Exception {
		 String homepageId=request.getParameter("HomePageId");
		 TSetHomepage ts=null;
		 if(StringUtil.isNotEmpty(homepageId)){
			 
			  ts=tsetHomepageService.getTSetHomepageById(homepageId);
		 }else{
			 new TSetHomepage();
		 }
	  return  getAutoView().addObject("TSetHomepage",ts);
	  }
	 
	
	@Action(description="删除")
	 @RequestMapping({"del"})
	  public void del(HttpServletRequest request, HttpServletResponse response)
	    throws Exception
	  {
		 String preUrl = RequestUtil.getPrePage(request);
		    ResultMessage message = null;
		    
		    try {
				
		    	
		    	Long[] lAryId = RequestUtil.getLongAryByStr(request, "HomePageId");
		    	delByIds(lAryId);
		    	message = new ResultMessage(1, "删除数据成功");
			} catch (Exception e) {
				 message = new ResultMessage(0, "删除数据失败:" + e.getMessage());
		    }
		    addMessage(message, request);
		    response.sendRedirect(preUrl);
		 
	  }
	 
	 private void delByIds(Long[] lAryId)
	  {
	    if (BeanUtils.isEmpty(lAryId)) {
	      return;
	    }
	    for (Long id : lAryId)
	    {
	    	tsetHomepageService.delTSetHomepageById(id);
	    }
	  }

}
