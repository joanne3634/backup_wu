package com.deelon.loan.controller.front;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.cmsform.service.site.CmsSiteMenuContentService;
import com.deelon.core.annotion.Action;
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.platform.model.system.SysAuditModelType;
import com.deelon.platform.model.system.SysUser;
import com.sun.jna.platform.win32.WinDef.LONG;
/**
 * @author Administrator
 *@version公司简介
 * 
 */
@Controller
@RequestMapping({ "/site/tmoneymoveSH/" })
@Action(ownermodel=SysAuditModelType.TMONEYMOVESH)
public class TmoneymoveSHController extends BaseController {
	@Resource
	private TmoneymoveService tmoneymoveService;
	
	@RequestMapping({"list"})
	@ Action( description = "查看Tmoneymove分页列表")
	public ModelAndView AboutUs(HttpServletRequest request,
			HttpServletResponse response) { 
		
		//begin 获得查询条件
		String userName = request.getParameter("userName");
		String typeId = request.getParameter("typeId");
		String resultId = request.getParameter("resultId");
		String audit = request.getParameter("audit");
		//end
		QueryFilter queryFilter=new QueryFilter(request,"item");//分页
		queryFilter.addFilter("userName", userName);
		queryFilter.addFilter("typeId", typeId);
		queryFilter.addFilter("resultId", resultId);
		queryFilter.addFilter("audit", audit);
		List<TMoneymove> list =tmoneymoveService.getAll(queryFilter);//查询分页列表数据
		return new ModelAndView("/loan/front/listTMoneyMove.jsp").addObject("list",list);
	}

	@RequestMapping({"audit"})
	@ResponseBody
	@ Action( description = "审核Tmoneymove数据", execOrder=ActionExecOrder.BEFORE,detail="审核Tmoneymove数据")
	public String Audit(HttpServletRequest request,HttpServletResponse response) {
		SysUser sysUser=ContextUtil.getCurrentUser();
		long moneyMoveId = Long.parseLong(request.getParameter("moneyMoveId"));//获取后台传过来的Id
		long audit = Long.parseLong(request.getParameter("audit"));////获取后台传过来的状态
		TMoneymove tmoneymove = tmoneymoveService.getById(moneyMoveId);
		if (audit==0) {										//判断状态
			audit=1;										//改变状态
		}else {
			audit=0;										//改变状态
		}
		tmoneymove.setAudit(audit);
		tmoneymove.setChecker(sysUser.getUserId());
		tmoneymove.setCheckTime(new Date());
		int count = tmoneymoveService.updateAudit(tmoneymove);//修改数据库，并返回修改数量
		if (count>0) {
			return "success";	//返回成功
		}else {
			return "failure";	//返回失败
		}
		
	}
}
