package com.deelon.loan.controller.myAccount;

import java.math.BigDecimal;
import java.net.InetAddress;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
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
@Controller
@ RequestMapping({"/loan/myAccount/"})
public class DrawMoneyController extends BaseController {

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
	
	@Action(description="到体现页面")
	@RequestMapping({"toDrawMnPage"})
	public ModelAndView toDrawMnPage(HttpServletRequest request,HttpServletResponse response){
		TUser u=(TUser)request.getSession().getAttribute("user");
		Long userId=u.getUserId();//当前用户id;
		
		//先取到用户卡信息 1.如果没取到 页面提示先绑定银行卡,取到则显示
				List<TBankcard> list=tbankcardService.getBankCardAndTransactionPwd(userId);
				//取得手续费比例
				TSettings t=tsettingsService.getTSettingsBySetCode(TSettingParem.HandingCharge.drawMoney);
		return new ModelAndView("/loan/myAccount/drawMoney.jsp").addObject("BankCard",list).addObject("HandingRecharge", t);
	}
	
	@Action(description="体现操作")
	@RequestMapping({"drawMoneyAction"})
	public Map<String,String> drawMoneyAction(HttpServletRequest request,HttpServletResponse response){
		TUser u=(TUser)request.getSession().getAttribute("user");
		Long userId=u.getUserId();//当前用户id;
		Map<String,String> ma=new HashMap<String,String>();
		
		String transactionPW=request.getParameter("transactionPW");//交易密码
		String transactionMoney=request.getParameter("transactionMoney");//取现金额
		String bankCardId=request.getParameter("bankCardId");//银行卡id
		String handingCharge=request.getParameter("handingCharge");//手续费
		
		try {
			
			//先取到用户的银行卡信息 1.如果没取到 页面提示先绑定银行卡,取到则显示
			List<TBankcard> list=tbankcardService.getBankCardAndTransactionPwd(userId);
			//验证客户的取现密码 t_user中的交易密码
			if(StringUtil.isNotEmpty(transactionPW)){
				if(list!=null&&list.size()>0){
					//取用户的交易密码 比较
					//交易密码 要先解密 ,这里暂时 
					if(transactionPW.equals(list.get(0).getTradingPwd())){//成功后调用银行 接口
						//调用银行的划账接口
						//划账成功后
						if(true){//这里假设划账成功
							
							//1.修改t_user_funds 的可用余额 账户余额 体现总额
							TUserFunds tf=tuserFundsService.getTUserFundsByUserId(userId);
							BigDecimal transacMoney=new BigDecimal(transactionMoney);
							if(tf!=null){
								tf.setAvailable(tf.getAvailable().subtract(transacMoney));//可用余额
								tf.setBalance(tf.getAvailable().add(tf.getFreeze()));//账户余额
								if(tf.getFundsOut()!=null){// 体现总额
									
									tf.setFundsOut(tf.getFundsOut().add(transacMoney));
								}else{
									tf.setFundsOut(transacMoney);//
								}
							}
							//2.t_moneymove 增加一条记录
							TMoneymove t=new TMoneymove();
							t.setUserId(userId);//
							t.setCardId(Long.valueOf(bankCardId));
							t.setTypeId("2");
							t.setMoneyInOut(transacMoney);
							t.setGetFee(new BigDecimal(handingCharge));
							t.setMoneyCurrent(tf.getBalance());
							t.setCreateTime(new Timestamp(System.currentTimeMillis()));
							tmoneymoveService.saveOrUpdateTMoneymove(t);
							//如果成功 则 插入操作记录
							tuserLogService.recordUserOperation(userId, 1, 2, 1, 1, transactionMoney,request);
						}/*else{
						ma.put("msg", "交易出现问题!");
					}*/
					}else{
						ma.put("msg", "交易密码输入错误!");
					}
					
				}
			}
		} catch (Exception e) {
			//如果失败 则 插入操作记录
			tuserLogService.recordUserOperation(userId, 1, 2, 1, 2, "操作失败",request);
			e.printStackTrace();
		}
		
		return null;
	}
}
