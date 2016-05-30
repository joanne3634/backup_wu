package com.deelon.loan.controller.front;


import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.loan.controller.front.view.ProjectDetailView;
import com.deelon.loan.exception.ProjectException;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TAttention;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserCompany;
import com.deelon.loan.model.front.TUserFamily;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.sysManager.TattentionService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.platform.model.system.SysAuditModelType;

@Controller
@RequestMapping({ "/attention/" })
@Action(ownermodel = SysAuditModelType.USER_MANAGEMENT)
public class AttentionController {

	@Autowired
	private TattentionService tattentionService;
	@Autowired
	private TprojectService tProjectService;

	
	/**
	 * 关注保存
	 * 
	 * @return
	 * @throws UserException 

	 */
	@RequestMapping({ "attentionProject" })
	@ResponseBody
	public String attentionProject(HttpServletRequest request,
			HttpServletResponse response) throws UserException {
		String projectId = request.getParameter("projectId");
		String result ="";
		TAttention attention = new TAttention();
		TUser user = getSessionUser(request);
		
		if(user != null){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("projectId", projectId);
			map.put("userId", user.getUserId());
			TAttention a = tattentionService.selectTattention(map);
			if(a!=null){
				return "你已经关注了";
			}
			TProject project = tProjectService.getProjectById(Long.valueOf(projectId));
			attention.setProjectId(Long.valueOf(projectId));
			attention.setTypeId(project.getPtypeId());
			attention.setCreateTime(new Date());
			attention.setUserId(user.getUserId());
			attention.setIsDel(0);
			int count = tattentionService.saveTattention(attention);
		if(count != 0){
			result = "关注成功";
		}else{
			result = "关注失败";
		}
		}else{
			return "0";
		}
		return result;
		
	}
	
	private TUser getSessionUser(HttpServletRequest request) {
		return (TUser) request.getSession().getAttribute("user");
	}
	
}
