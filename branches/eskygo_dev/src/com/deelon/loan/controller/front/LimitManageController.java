package com.deelon.loan.controller.front;

import java.math.BigDecimal;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.loan.model.front.TLimitsApply;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.sysManager.TlimitsApplyService;
import com.deelon.loan.service.sysManager.TprojectService;
@Controller
@RequestMapping({ "/project/apply/" })
public class LimitManageController extends BaseFormController{
	
	@Resource
	private UserInfoService userInfoService;
	@Resource
	private TlimitsApplyService limitService;
	@Resource
	private TprojectService projectService;
	/**
	 * 获取用户最大借出借入限额
	 * 若传入申请额度值参数则提交申请
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "getUserLimit" })
	@ResponseBody  
	public Object getUserLimit(HttpServletRequest request) {
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeb.jsp"); 
		}
		JSONObject json = new JSONObject();
		if(StringUtil.isEmpty(request.getParameter("applyInMax"))){
			TUserFunds ufunds = userInfoService.getUserFundsInfo(user.getUserId());
			TProject ping = projectService.getmyLoanStatistics("(1,2,3,4)", user.getUserId());//获取申请中的借款汇总
			TProject pin = projectService.getmyLoanStatistics("(5,6,7)",user.getUserId());//获取还款中和还款完成的汇总数据
			if(null==ping){
				ping = new TProject();
				ping.setPloan(new BigDecimal(0));
			}else if(null==ping.getPloan()){
				ping.setPloan(new BigDecimal(0));
			}
			if(null==pin){
				pin = new TProject();
				pin.setPloanReal(new BigDecimal(0));
				pin.setPsumHavedPayPrincipal(new BigDecimal(0));
			}
			if(null==pin.getPloanReal()){
				pin.setPloanReal(new BigDecimal(0));
			}
			if(null==pin.getPsumHavedPayPrincipal()){
				pin.setPsumHavedPayPrincipal(new BigDecimal(0));
			}
			BigDecimal cando = ufunds.getLimitMaxIn().subtract(ping.getPloan().add(pin.getPloanReal()).subtract(pin.getPsumHavedPayPrincipal()));
			if(cando.compareTo(new BigDecimal(0))==-1){
				json.put("limitMaxCanDoIn", 0);
			}else{
				json.put("limitMaxCanDoIn", cando);
			}
			json.put("limitMaxIn", ufunds.getLimitMaxIn());
			json.put("limitMaxOut", ufunds.getLimitMaxOut());
		}else{
			TLimitsApply entity = new TLimitsApply();
			entity.setApplyId(UniqueIdUtil.genId());
			entity.setApplicant(user.getUserId());
			entity.setLimitApply(new BigDecimal(request.getParameter("applyInMax")));
			entity.setLimitOld(new BigDecimal(request.getParameter("oldLimit")));
			entity.setAudit_status("");
			entity.setAudit_desc("");
			entity.setTypeId("1");//借入额度申请
			entity.setApplyTime(new Date());
			limitService.add(entity);
			json.put("ok", 1);
		}
		return json;
	}

}
