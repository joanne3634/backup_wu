package com.deelon.loan.controller.myAccount;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.front.TuserTaskcompleteService;
import com.deelon.loan.service.sysManager.TtaskService;

@Controller
@RequestMapping({ "/myAccount/" })
public class SecurityCenterController {
	
	@Resource
	private TuserSafeService tuserSafeService;
	@Resource
	private TuserTaskcompleteService userTaskcompleteService;
	
	
	
	@RequestMapping({ "securityCenter" })
	public ModelAndView securityCenter(HttpServletRequest request,
			HttpServletResponse response){
		//String taskId = request.getParameter("taskId");
		
		TUser user = (TUser) request.getSession().getAttribute("user");
		TUserSafe userSafe = tuserSafeService.getUserSafeByUserId(user.getUserId());
		
		//if(taskId !=null){   //查看安全中心完成任务
		userTaskcompleteService.viweAddcredit(user.getUserId(), 1);
		//}
		
		
		return new ModelAndView("/loan/front/securityCenter.jsp").addObject("userSafe", userSafe);
	}

}
