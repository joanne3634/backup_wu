package com.deelon.loan.controller.sysManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TUserService;

@Controller
@RequestMapping({ "/loan/sysManager/userBasicInfoAudit/" })
public class UserBasicInfoAuditController extends BaseController {
	
	@Resource
	private TUserService tuserService; 
	
	 @RequestMapping({"list"})
	  public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
		 
		 try {
			 String realName=request.getParameter("realName");
			 String loginName=request.getParameter("loginName");
			 String idCard=request.getParameter("idCard");
			 QueryFilter queryFilter=new QueryFilter(request,"userId");
			 queryFilter.addFilter("realName", realName);
			 queryFilter.addFilter("loginName", loginName);
			 queryFilter.addFilter("idCard", idCard);
			 List<TUser> listVo=tuserService.getAllUserInfos(queryFilter);
			return getAutoView().addObject("ListVo", listVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return null;
	  }
	 
	 @RequestMapping({"updateUserInfoAudit"})
	 @ResponseBody
	 public Map<String,String> updateUserInfoAudit(HttpServletRequest request, HttpServletResponse response,String arrayIds){
		
		 
		 return null;
	 }

}
