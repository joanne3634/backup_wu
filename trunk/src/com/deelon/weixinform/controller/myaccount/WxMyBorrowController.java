package com.deelon.weixinform.controller.myaccount;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.page.PageBean;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.platform.util.ParamHelper;

/**
 * 我的借款
 * @author qin
 *
 */
@Controller
@RequestMapping({"/weixin/wxmyborrow/"})
public class WxMyBorrowController {
	
	@Autowired
	private TprojectService tProjectService;

	/**
	 * 跳转到我的借款界面
	 * @return
	 */
	@RequestMapping({ "myborrowPage" })
	public ModelAndView myborrowPage(HttpServletRequest request,HttpServletResponse response) throws Exception{
		Map<String,Object> result = new HashMap<String,Object>();
		TUser user = (TUser) request.getSession().getAttribute("user");
		if(null == user){
			response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
			return null;
		}
		
		int recentDays = Integer.parseInt(request.getParameter("recentDays")==null?"0":request.getParameter("recentDays").toString());
		long userId = user==null?0:user.getUserId();
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.addFilter("papplicant", userId); //用户
		//queryFilter.addFilter("resultId", 1); //成功
		
		if(recentDays>0)	{
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.add(Calendar.DAY_OF_MONTH, -recentDays);
			queryFilter.addFilter("papplicationTimeBegin", cal.getTime());
		}
		
		int page = RequestUtil.getInt(request, "page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize", 10);
		
		PageBean bean = new PageBean(page,pageSize);
		//queryFilter.setPageBean(bean);
		List<TProject> list = tProjectService.getAll(queryFilter);
		return new ModelAndView("/weixinform/myaccount/myborrow.jsp").addObject("borrowProject", list).addObject("recentDays", recentDays);
	}
	
}
