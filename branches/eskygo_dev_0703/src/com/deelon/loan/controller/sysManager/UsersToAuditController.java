package com.deelon.loan.controller.sysManager;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.deelon.core.util.ExceptionUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.sysManager.TuserReport;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.loan.service.sysManager.TuserReportService;

@Controller
@RequestMapping({ "/loan/sysManager/usersToAudit/" })
public class UsersToAuditController extends BaseController {

	@Resource
	private TUserService tUserService;
	
	@RequestMapping({"list"})
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		List<TUser> list = this.tUserService.getAll(new QueryFilter(request, "userItem"));
		ModelAndView mv = getAutoView().addObject( "listVo", list );
		return mv;
	}
	
	@RequestMapping({"credit"})
	  public ModelAndView credit(HttpServletRequest request, HttpServletResponse response)
			  throws Exception{
		 String userId=request.getParameter("userId");
		 System.out.println(userId+"____");
		 TUser pro=tUserService.getById(Long.valueOf(userId));
		 ModelAndView mv  =new ModelAndView("/loan/sysManager/userToAuditCredit.jsp").addObject("TUser", pro);
		 return mv;
	 }
	
	@RequestMapping( { "update" } )
	@ResponseBody
	public void update( HttpServletRequest request, HttpServletResponse response ) throws Exception{
		//  data: {useId:useId,pclerkId:pclerkId}
		String userId =request.getParameter("userId");
		String pclerkId =request.getParameter("pclerkId");
		
		ResultMessage resultMessage =new ResultMessage(1, "操作成功！");
		PrintWriter writer = response.getWriter();
		try {
			tUserService.updateAuditPeople(userId,pclerkId);
		} catch (Exception e) {
			// TODO: handle exception
			 String msg = ExceptionUtil.getExceptionMessage(e);
			 resultMessage = new ResultMessage(0, msg);
		}
		writer.print(resultMessage);
	}
	
	@ RequestMapping( { "editTogether" } )
	public ModelAndView updateTogether( HttpServletRequest request,HttpServletResponse response,String arrayIds ){
		Long[] lAryId = RequestUtil.getLongAryByStr(arrayIds);
		List<TUser> users=tUserService.updateUserTogether(lAryId);
		ModelAndView mv =new ModelAndView("/loan/sysManager/editUserToAudit.jsp").addObject("users", users).addObject("id", arrayIds);
		return mv;
	}
	
}
