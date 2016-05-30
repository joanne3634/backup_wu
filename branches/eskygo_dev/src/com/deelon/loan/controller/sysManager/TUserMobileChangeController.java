/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */

package com.deelon.loan.controller.sysManager;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.service.system.DemensionService;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deelon.loan.model.sysManager.TUserMobileChange;
import com.deelon.loan.service.sysManager.TUserMobileChangeService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@ Controller
// 把本类变成一个handler
@ RequestMapping( { "/user/mobilechange" } )
// 指定控制器映射url
public class TUserMobileChangeController extends BaseController {

	@ Resource
	private TUserMobileChangeService tUserMobileChangeService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看TUserMobileChange分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception {
		//begin 获得查询条件
		String userName = request.getParameter("userName");
		 String mobileOld = request.getParameter("mobileOld");
		 String mobileNew = request.getParameter("mobileNew");
		//end
		 QueryFilter queryFilter=new QueryFilter(request,"tUserMobileChangeItem");//分页
		 queryFilter.addFilter("userName", userName);
		 queryFilter.addFilter("mobileOld", mobileOld);
		 queryFilter.addFilter("mobileNew", mobileNew);
		List<TUserMobileChange> list = tUserMobileChangeService.getAll(queryFilter); //查询分页列表数据
		 return new ModelAndView("/loan/sysManager/tusermobilechangeList.jsp").addObject( "tUserMobileChangeList", list );
	}
}
