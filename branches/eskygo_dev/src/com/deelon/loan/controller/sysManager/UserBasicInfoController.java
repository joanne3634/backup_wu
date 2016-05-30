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

import com.deelon.core.annotion.Action;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TUserService;

@Controller
@RequestMapping({ "/loan/sysManager/userBasicInfo/" })
public class UserBasicInfoController extends BaseController {
	
	@Resource
	private TUserService tuserService; 
	@Action(description="用户基本信息页面")
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return null;
	  }
	 
	@Action(description="保存修改操作")
	 @RequestMapping({"updateUserInfo"})
	 @ResponseBody
	 public Map<String,String> updateUserInfo(HttpServletRequest request, HttpServletResponse response,String arrayIds){
		 Map<String,String> map=new HashMap<String,String>();
		 try {
			 String isLock=request.getParameter("isLock");
			 String isActive=request.getParameter("isActive");
			Long[] larrId=RequestUtil.getLongAryByStr(arrayIds);
			
			for (Long id : larrId) {
				TUser u=tuserService.getById(id);
				if(StringUtil.isNotEmpty(isLock))
					u.setIsLock(Integer.valueOf(isLock));
				if(StringUtil.isNotEmpty(isActive))
					u.setIsActive(Integer.valueOf(isActive));
				u.setLoginPwdErrCount(0);
				tuserService.updateUser(u);
				
			}
			map.put("msg", "操作成功!");
			return map;
		} catch (Exception e) {
			// TODO: handle exception
			map.put("msg", "操作失败!");
			
			e.printStackTrace();
			return map;
		}
		 
	 }

}
