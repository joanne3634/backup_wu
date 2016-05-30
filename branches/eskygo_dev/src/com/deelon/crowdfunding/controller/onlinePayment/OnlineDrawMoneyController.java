package com.deelon.crowdfunding.controller.onlinePayment;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.encrypt.EncryptUtil;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.loan.common.TSettingParem;
import com.deelon.loan.model.backstage.TSettings;
import com.deelon.loan.model.front.TBankcard;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.backstage.TSettingsService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TbankcardService;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.operationLog.TuserLogService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.fr.base.core.UUID;
/**
 * 会员中心  账户资金管理(在线提现)
 * @author Administrator
 *
 */
@Controller
@RequestMapping({ "/crowdfunding/onlinePayment/" })
public class OnlineDrawMoneyController {
	
	@Resource
	private TbankcardService tbankcardService;
	@Resource
	private TUserService tuserService;
	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TmoneymoveService tmoneymoveService;
	@Resource
	private TSettingsService tsettingsService;
	@Resource
	private TuserLogService tuserLogService;
	
	@Action(description="跳转到提现页面")
	@RequestMapping({"toDrawMnPage"})
	public ModelAndView toDrawMnPage(HttpServletRequest request,HttpServletResponse response){
		TUser u=(TUser)request.getSession().getAttribute("user");
		Long userId=u.getUserId();//当前用户id;
		request.getSession().setAttribute("drawtoken", UUID.randomUUID().toString());
		//先取到用户卡信息 1.如果没取到 页面提示先绑定银行卡,取到则显示
		List<TBankcard> list=tbankcardService.getBankCardAndTransactionPwd(userId);
		//取得手续费比例
		TUserFunds tf = null;
		
		TSettings t=tsettingsService.getTSettingsBySetCode(TSettingParem.HandingCharge.drawMoney);
		
		if(StringUtil.isNotEmpty(userId+"")){
			 tf=tuserFundsService.getTUserFundsByUserId(userId);
		}
		return new ModelAndView("/crowdfunding/onlinePayment/onlineDrawMoney.jsp")
		.addObject("bankCard",null !=list && list.size() > 0 ?list.get(0):new TBankcard()).addObject("handingRecharge", t).addObject("userfunds",tf);
	}
	
	@Action(description="提现操作")
	@ResponseBody
	@RequestMapping({"drawMoneyAction"})
	public String drawMoneyAction(HttpServletRequest request,HttpServletResponse response,
			String transactionPW,String transactionMoney,String bankCardId,String handingCharge) {
		TUser u=(TUser)request.getSession().getAttribute("user");
		Long userId=u.getUserId();//当前用户id;
		Map<String,String> ma=new HashMap<String,String>();
		String toke = request.getParameter("token_id");
		String serverToken = (String) request.getSession(false).getAttribute("drawtoken");
//		//取得手续费
		TSettings setting =tsettingsService.getTSettingsBySetCode(TSettingParem.HandingCharge.drawMoney);
		String setValue = "";
		if(setting.getSetValue().contains("%")){
			String percent = setting.getSetValue().substring(0,setting.getSetValue().length()-1);
			if(StringUtils.isNotEmpty(percent) && StringUtils.isNotBlank(percent)){
				Double pc  = Double.parseDouble(setting.getSetValue())/100;
				setValue = (new BigDecimal(transactionMoney).doubleValue()*pc)+""; 
			}
		}else{
			Double pc  = Double.parseDouble(setting.getSetValue())/100;
			Double setValue2 = new BigDecimal(transactionMoney).doubleValue() * pc;
			setValue = setValue2.toString();
			if(StringUtils.isEmpty(handingCharge))
				handingCharge = setValue;
		}
		try {
			//是否打开在线支付开关(1：打开)
		    String openOnlinePayment = (String)AppUtil.getServletContext().getAttribute("INTERVIEWS_TIMESPAN");
			//先取到用户的银行卡信息 1.如果没取到 页面提示先绑定银行卡,取到则显示
			List<TBankcard> list=tbankcardService.getBankCardAndTransactionPwd(userId);
			//验证客户的取现密码 t_user中的交易密码
			if(StringUtils.isEmpty(transactionMoney))
				return "提现金额必须大于零!";
			if(StringUtil.isNotEmpty(toke)){
				if(toke.equals(serverToken)){
					if(StringUtil.isNotEmpty(transactionPW)){
						if(list!=null&&list.size()>0){
							if(StringUtil.isEmpty(bankCardId)){
								bankCardId = list.get(0).getBankCardId()+"";
							}
							String tradingpwd = list.get(0).getTradingPwd();
							String enrypwd = EncryptUtil.encryptSha256(transactionPW);
							//取用户的交易密码 比较
							//交易密码 要先解密 ,这里暂时 
							if(enrypwd.equals(tradingpwd)){//成功后调用银行 接口
								//调用银行的划账接口(注意：要扣除手续费)new BigDecimal(transactionMoney)-new BigDecimal(setValue)
								//划账成功后
								if(true){//这里假设划账成功
									//1.修改t_user_funds 的可用余额 账户余额 提现总额
									TUserFunds tf=tuserFundsService.getTUserFundsByUserId(userId);
									BigDecimal transacMoney=new BigDecimal(transactionMoney);
									if(tf!=null){
										tf.setAvailable(tf.getAvailable().subtract(transacMoney));//可用金额- 提现金额元
										tf.setBalance(tf.getBalance().subtract(transacMoney));//账户余额 - 提现金额元
										if(tf.getFundsOut()!=null){// 提现总额
											tf.setFundsOut(tf.getFundsOut().add(transacMoney.multiply(new BigDecimal(-1))));
										}else{
											tf.setFundsOut(transacMoney.multiply(new BigDecimal(-1)));//
										}
										tuserFundsService.update(tf);
									}
									
									//2.t_moneymove 增加一条记录
									TMoneymove t=new TMoneymove();
									t.setMoneyMoveId(UniqueIdUtil.genId());
									t.setUserId(userId);//
									t.setCardId(Long.valueOf(bankCardId));
									t.setTypeId("2");
									t.setMoneyInOut(transacMoney.multiply(new BigDecimal(-1)));
									t.setGetFee(new BigDecimal(handingCharge));
									t.setMoneyCurrent(tf.getBalance());
									t.setCreateTime(new Timestamp(System.currentTimeMillis()));
									if(StringUtils.isNotEmpty(openOnlinePayment) && StringUtils.isNotBlank(openOnlinePayment)){
										t.setChecker(0L);//在线支付默认平台审批通过
										t.setCheckTime(new Timestamp(System.currentTimeMillis()));
										t.setResultId("1");
										t.setAudit(1);//在线支付默认审核通过
									}
									t.setRemark("提现成功");
									t.setSerialNo("");
									t.setIsOffLine(0);
									tmoneymoveService.add(t);
									//如果成功 则 插入操作记录
									tuserLogService.recordUserOperation(userId, 1, 2, 1, 1, transactionMoney,request);
									request.getSession(false).removeAttribute("drawtoken");
									return "提现成功!";
								}/*else{
								ma.put("msg", "交易出现问题!");
							}*/
							}else{
								return "交易密码输入错误!";
								//ma.put("msg", "交易密码输入错误!");
							}
						}else{
							return "请先绑定银行卡!";
						}
					}
				}else{
					return "重复提交!";
					//return "重复提交";
				}
			}
		} catch (Exception e) {
			//如果失败 则 插入操作记录
			tuserLogService.recordUserOperation(userId, 1, 2, 1, 2, "操作失败",request);
			e.printStackTrace();
			return e.getMessage();
		}
		
		return null;
	}
}
