package com.deelon.loan.controller.myAccount;

import java.math.BigDecimal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.loan.common.LoanContextUtil;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.backstage.TSettingsService;
import com.deelon.loan.service.front.TbankcardService;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.operationLog.TuserLogService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.fr.base.core.UUID;
@Controller
@RequestMapping({ "/loan/myAccount/" })
public class RechargePageController extends BaseController {

	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TbankcardService tbankcardService;
	@Resource
	private TmoneymoveService tmoneymoveService;
	@Resource
	private TSettingsService tsettingsService;
	@Resource
	private TuserLogService tuserLogService;
	
	@Action(description="充值")
	@RequestMapping({"rechargePage"})
	public ModelAndView rechargePage(HttpServletRequest request,HttpServletResponse response){
		TUser u=(TUser)request.getSession().getAttribute("user");//当前用户id
		//String taskId=request.getParameter("taskId");
		//根据当前登录用户取得 用户资金信息
		try {
			TUserFunds tf=tuserFundsService.getTUserFundsByUserId(u.getUserId());
			if(tf.getChargeMoneyProportion()==null){
				tf.setChargeMoneyProportion(new BigDecimal(0));
			}
			//取得手续费比例 HANDING_CHARGE_PROPORTION
			String trandingHours=(String)AppUtil.getServletContext().getAttribute("RECHARGE_FEES");
			tf.setBalanceS(tf.getAvailable().add(tf.getFreeze()).doubleValue());
				if(StringUtil.isNotEmpty(trandingHours)){
					tf.setChargeMoneyProportion(new BigDecimal(trandingHours));
				}
				
			request.getSession().setAttribute("token", UUID.randomUUID().toString());
			return new ModelAndView("/loan/myAccount/rechargePage.jsp").addObject("TUserFunds", tf);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
		
	}
	
	@Action(description="充值操作")
	@RequestMapping({"vali_callBankFunc_save"})
	@ResponseBody
	public String vali_callBankFunc_save(HttpServletRequest request,HttpServletResponse response,
			String rechargeMoey,String chargeMoney_id)throws Exception{
	//	Map<String,String> ma =new HashMap<String,String>();
		long userId = LoanContextUtil.getCurrentTUser(request,"user").getUserId();//当前用户id
		
		String toke = request.getParameter("token_id");//
	    String serverToken = (String) request.getSession(false).getAttribute("token");
	    
		try {
			if(StringUtil.isNotEmpty(toke)){
				if(toke.equals(serverToken)){
					request.getSession(false).removeAttribute("token");
					
					tuserFundsService.rechargeMoney(userId,rechargeMoey,chargeMoney_id,null,"");
					//如果成功 则 插入操作记录
					tuserLogService.recordUserOperation(userId, 1, 1, 1, 1, rechargeMoey,request);
					return  "操作成功!";
				}else{
					return "重复提交";
				}
			}
		} catch (Exception e) {
			//如果失败 则 插入操作记录
			tuserLogService.recordUserOperation(userId, 1, 1, 1, 2, "操作失败",request);
			 return e.getMessage();
		}
		
		return null;
	}
	
}
