package com.deelon.weixinform.controller.borrow;


import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import com.deelon.core.page.PageBean;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.controller.front.view.ProjectDetailView;
import com.deelon.loan.dao.sysManager.TprojectRepaymentDao;
import com.deelon.loan.exception.ProjectException;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserAuditMat;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.front.TUserAuditMatService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.platform.model.system.SysAuditModelType;

/**
 * 我要借款
 * @author qin
 *
 */
@Controller
@RequestMapping({ "/weixin/wxproject/" })
@Action(ownermodel = SysAuditModelType.USER_MANAGEMENT)
public class WxProjectController extends BaseFormController{

	@Autowired
	private TprojectService tProjectService;
	
	@Autowired
	private TprojectRepaymentDao tProjectRepayService;

	@Autowired
	private TUserService tUserService;

	@Autowired
	private TuserSafeService tuserSafeService;

	@Autowired
	private UserInfoService userInfoService;
	
	@Resource
	private TprojectInvestService tprojectInvestService;
	@Resource
	private TUserAuditMatService tuserAuditMatService;

	/**
	 * 保存借款项目
	 * 
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping({ "saveProject" })
	public ModelAndView saveTProject(TProject project,HttpServletRequest request) throws Exception {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeixin.jsp"); 
		}
		project.setPstatusId("1");//新申请  状态下的贷款
		project.setPtypeId("");
		project.setPcertifiLevel("");
		project.setPclerk("");
		project.setPloanReal(new BigDecimal(0));
		project.setPrateOut(new BigDecimal(0));
		project.setPcomplete(0);
		project.setPbided(0);
		project.setPviewed(0);
		project.setPapplicant(user.getUserId());
		project.setPapplicationTime(new Date());
		project.setPupdateTime(new Date());
		project.setPhavedPay(new Short("0"));
		project.setPauditPlatform(new Short("0"));
		project.setPisFull(new Short("0"));
		project.setPisBreak(new Short("0"));
		project.setPbreakTimes(0);
		project.setPisSetup(new Short("0"));
		project.setPisLate(new Short("0"));
		project.setPlateDays(0);
		project.setPisPayOff(new Short("0"));
		project.setPsumPayBack(new BigDecimal(0));
		project.setPsumInterest(new BigDecimal(0));
		project.setPsumHavedPay(new BigDecimal(0));
		project.setPsumLate(new BigDecimal(0));
		project.setPsumLateHavedPay(new BigDecimal(0));
		project.setPdel(new Short("0"));
		project.setPrateOut(project.getPrateIn().subtract(new BigDecimal(AppUtil.getServletContext().getAttribute("RATEIN_RATEOUT").toString())));
		if(null==project.getPloan()||StringUtil.isEmpty(project.getPname())||StringUtil.isEmpty(project.getPrepayWay())){//如果新增的项目关键信息为空则不插入数据库
			return new ModelAndView("/weixinform/borrow/borrowApply.jsp");
		}else{
			tProjectService.saveorUpdateProject(project);
			return new ModelAndView("redirect:/loginWeixin.jsp");
		}
	}

	private TUser getSessionUser(HttpServletRequest request) {
		return (TUser) request.getSession().getAttribute("user");
	}
	
}
