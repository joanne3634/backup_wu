package com.deelon.crowdfunding.controller.onlinePayment;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
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
import com.deelon.core.page.PageBean;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.loan.common.LoanContextUtil;
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
import com.deelon.payform.common.PayCommon;
import com.deelon.payform.common.moneymoremore.PayCommonMoney;
import com.fr.base.core.UUID;

/**
 * 会员中心 账户资金管理(在线充值)
 * 
 * @author Administrator
 * 
 */
@Controller
@RequestMapping({ "/crowdfunding/onlinePayment/" })
public class OnlinePaymentController {
	@Resource
	private TUserService tuserService;
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

	@Action(description = "充值")
	@RequestMapping({ "rechargePage" })
	public ModelAndView rechargePage(HttpServletRequest request,
			HttpServletResponse response) {
		TUser u = (TUser) request.getSession().getAttribute("user");// 当前用户id
		// String taskId=request.getParameter("taskId");
		String flag = request.getParameter("flag") + "";// 如果flag=1表示账号单纯充值，提现按钮隐藏
		// 根据当前登录用户取得 用户资金信息
		try {
			TUserFunds tf = tuserFundsService.getTUserFundsByUserId(u
					.getUserId());
			if (tf != null && tf.getChargeMoneyProportion() == null) {
				tf.setChargeMoneyProportion(new BigDecimal(0));
				// 取得手续费比例 HANDING_CHARGE_PROPORTION
				String trandingHours = (String) AppUtil.getServletContext()
						.getAttribute("RECHARGE_FEES");
				tf.setBalanceS(tf.getAvailable().add(tf.getFreeze())
						.doubleValue());
				if (StringUtil.isNotEmpty(trandingHours)) {
					if (trandingHours.contains("%")) {
						String percent = trandingHours.substring(0,
								trandingHours.length() - 1);
						tf.setChargeMoneyProportion(new BigDecimal(Integer
								.parseInt(percent) * 100));
					} else {
						tf.setChargeMoneyProportion(new BigDecimal(
								trandingHours));
					}
				}
			}
			// 先取到用户的银行卡信息 1.如果没取到 页面提示先绑定银行卡,取到则显示
			List<TBankcard> bankcardlist = tbankcardService
					.getBankCardAndTransactionPwd(u.getUserId());

			request.getSession().setAttribute("token",
					UUID.randomUUID().toString());
			return new ModelAndView(
					"/crowdfunding/onlinePayment/onlineRechargePage.jsp")
					.addObject("TUserFunds", tf)
					.addObject("flag", flag)
					.addObject(
							"bankcardlist",
							bankcardlist == null ? new ArrayList<TBankcard>()
									: bankcardlist);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return null;

	}

	@Action(description = "第三方充值")
	@RequestMapping({ "recharge" })
	public ModelAndView recharge(HttpServletRequest request,
			HttpServletResponse response) {
		TUser u = (TUser) request.getSession().getAttribute("user");// 当前用户id
		String flowCode = request.getParameter("flowCode");
		// 根据当前登录用户取得 用户资金信息
		try {
			// TUserFunds
			// tf=tuserFundsService.getTUserFundsByUserId(u.getUserId());
			// 加入充值接口
			HashMap hm = new HashMap();
			TUserFunds tuf = tuserFundsService.getByUserId(u.getUserId());
			TMoneymove tmoneymove = tmoneymoveService.getByIdFlowCode(flowCode);
			TBankcard tbank = tbankcardService.getById(tmoneymove.getCardId());
			hm.put("TUserFunds", tuf);
			hm.put("TMoneymove", tmoneymove);
			hm.put("TBankcard", tbank);
			PayCommon.recharge(hm);
			return new ModelAndView("/crowdfunding/onlinePayment/recharge.jsp")
					.addObject("hm", hm).addObject("hmData",
							hm.get(PayCommonMoney.payDataKey));
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return null;

	}

	@Action(description = "异步获取已绑定到银行账号")
	@RequestMapping({ "getBankCardNo" })
	@ResponseBody
	public Map<String, Object> getBankCardNo(HttpServletRequest request,
			HttpServletResponse response) {
		TUser u = (TUser) request.getSession().getAttribute("user");// 当前用户id
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// 先取到用户的银行卡信息 1.如果没取到 页面提示先绑定银行卡,取到则显示
			List<TBankcard> bankcardlist = tbankcardService
					.getBankCardAndTransactionPwd(u.getUserId());
			map.put("bankcardlist", bankcardlist);
			String serverToken = (String) request.getSession(false)
					.getAttribute("token");
			map.put("token", serverToken);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;

	}

	@Action(description = "充值操作")
	@RequestMapping({ "vali_callBankFunc_save" })
	@ResponseBody
	public String vali_callBankFunc_save(HttpServletRequest request,
			HttpServletResponse response, String rechargeMoey,
			String chargeMoney_id, String pwd, String bankCardId)
			throws Exception {

		// chargeMoney_id 手续费
		// rechargeMoey 充值金额
		// 创建 资金记录 充值金额和手续费 状态均为失败
		// 当支付平台返回充值成功后,再修改状态为成功,同时用户虚拟账户资金做变动,tuserfunds
		try {
			TUser u = LoanContextUtil.getCurrentTUser(request, "user");
			if (u == null) {
				response.sendRedirect(request.getContextPath()
						+ "/loginWeb.jsp");
				return null;
			}
			long userId = u.getUserId();// 当前用户id
			String flowCode = String.valueOf(UniqueIdUtil.genId());// 加入充值流水号后期对帐可以allen

			TUserFunds uf = tuserFundsService.getByUserId(userId);//取得用户标示

			TMoneymove t = new TMoneymove();
			t.setMoneyMoveId(UniqueIdUtil.genId());
			t.setUserId(userId);
			t.setCardId(0);// 这里 如果有多个银行卡的话，就先取第一个
			t.setTypeId("1");// 充值

			if (StringUtil.isEmpty(chargeMoney_id)) {// 如果手续费为空
				chargeMoney_id = "0";
			}

			t.setMoneyInOut(new BigDecimal(rechargeMoey).add(new BigDecimal(
					chargeMoney_id)));// 这里应加上手续费
			t.setMoneyCurrent(uf.getBalance());// t_user_funds表的账户余额,成功后再减去
			t.setCreateTime(new Timestamp(System.currentTimeMillis()));
			t.setGetFee(new BigDecimal(chargeMoney_id));// 手续费
			t.setResultId("2");// 默认是不通过的 allen
			t.setRemark("充值失败");// allen
			t.setAudit(0);// 默认是不通过的allen
			t.setFlowCode(flowCode);// 加入充值流水号后期对帐可以allen

			t.setSerialNo("");
			t.setIsOffLine(0);
			tmoneymoveService.add(t);

			return flowCode;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return null;
	}

	@Action(description = "跳转到询价诚意金页面")
	@RequestMapping({ "getNewBalace" })
	@ResponseBody
	public Map<String, Object> getNewBalace(HttpServletRequest request,
			HttpServletResponse response) {
		TUser u = (TUser) request.getSession().getAttribute("user");
		Map<String, Object> param = new HashMap<String, Object>();
		Long userId = u.getUserId();// 当前用户id;
		request.getSession().setAttribute("drawtoken",
				UUID.randomUUID().toString());
		TUserFunds tf = null;
		TSettings t = tsettingsService
				.getTSettingsBySetCode(TSettingParem.HandingCharge.drawMoney);
		if (StringUtil.isNotEmpty(userId + "")) {
			tf = tuserFundsService.getTUserFundsByUserId(userId);
		}
		// 查询询价诚意金
		String askPrice = null;
		try {
			askPrice = (String) AppUtil.getServletContext().getAttribute(
					"ASK_PRICE_SINCERITY");
			param.put("askPrice", askPrice);
			param.put("userfund", tf);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return param;
	}

	@Action(description = "发送到第三方支付询价诚意金")
	@RequestMapping({ "payAskPriceMoneys" })
	public ModelAndView payAskPriceMoneys(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TUser u = (TUser) request.getSession().getAttribute("user");// 当前用户id
		String flowCode = request.getParameter("flowCode");
		// 根据当前登录用户取得 用户资金信息
		try {
			// TUserFunds
			// tf=tuserFundsService.getTUserFundsByUserId(u.getUserId());
			// 加入接口
			String askPrice = (String) AppUtil.getServletContext()
					.getAttribute("ASK_PRICE_SINCERITY");
			HashMap hm = new HashMap();
			TUserFunds tuf = tuserFundsService.getByUserId(u.getUserId());
			TMoneymove tmoneymove = tmoneymoveService.getByIdFlowCode(flowCode);
			TBankcard tbank = tbankcardService.getById(tmoneymove.getCardId());
			hm.put("LoanOutMoneymoremore", tuf.getPayMark());
			hm.put("LoanInMoneymoremore", PayCommonMoney.payformNo);
			hm.put("TransferName", "支付询价诚意金");
			hm.put("Amount", askPrice);
			hm.put("OrderNo", flowCode);
			hm.put("BatchNo", flowCode);
			PayCommon.loanTrans(hm);
			return new ModelAndView(
					"/crowdfunding/onlinePayment/payAskPriceMoneys.jsp")
					.addObject("hm", hm).addObject("hmData",
							hm.get(PayCommonMoney.payDataKey));
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return null;
	}

	@Action(description = "支付询价诚意金")
	@RequestMapping({ "payAskPriceMoney" })
	@ResponseBody
	public String payAskPriceMoney(HttpServletRequest request,
			HttpServletResponse response, String money, String backcardid,
			String pwd) throws Exception {
		long userId = LoanContextUtil.getCurrentTUser(request, "user")
				.getUserId();// 当前用户id
		// 查询询价诚意金
		String askPrice = (String) AppUtil.getServletContext().getAttribute(
				"ASK_PRICE_SINCERITY");
		String result = null;
		try {
			String flowCode = String.valueOf(UniqueIdUtil.genId());
			if (StringUtil.isNotEmpty(askPrice)) {
				// 1.修改t_user_funds 的可用余额 账户余额
				TUserFunds tf = tuserFundsService.getTUserFundsByUserId(userId);
				BigDecimal transacMoney = new BigDecimal(askPrice);
				if (tf != null) {
					// tf.setAvailable(tf.getAvailable().subtract(transacMoney));//可用金额-
					// 询价诚意金
					// tf.setBalance(tf.getBalance().subtract(transacMoney));//账户余额
					// - 询价诚意金
					// tuserFundsService.update(tf);
					// 2.t_moneymove 增加一条记录

					TMoneymove t = new TMoneymove();
					t.setMoneyMoveId(UniqueIdUtil.genId());
					t.setUserId(userId);//
					// t.setCardId(Long.valueOf(bankCardId));
					t.setTypeId("12");
					t.setMoneyInOut(transacMoney.multiply(new BigDecimal(-1)));
					t.setGetFee(new BigDecimal(0));
					t.setMoneyCurrent(tf.getBalance());
					t.setCreateTime(new Timestamp(System.currentTimeMillis()));
					// t.setChecker(userId);//在线支付默认审批通过
					// t.setCheckTime(new
					// Timestamp(System.currentTimeMillis()));
					t.setResultId("2");
					t.setAudit(0l);
					t.setRemark("支付询价诚意金失败");
					t.setSerialNo("");
					t.setFlowCode(flowCode);
					t.setIsOffLine(0);
					tmoneymoveService.add(t);
					/*
					 * //更新tuser表中的isAskPrice TUser tuser =
					 * this.tuserService.getById(userId); if(tuser != null){
					 * tuser.setIsAskPrice(1); tuserService.update(tuser); }
					 */
				}
			}
			result = flowCode;
		} catch (Exception e) {
			e.printStackTrace();
			result = "0";
		}
		return result;
	}

	@Action(description = "是否已经支付询价诚意金")
	@RequestMapping({ "ispayAskPriceMoney" })
	@ResponseBody
	public String ispayAskPriceMoney(HttpServletRequest request,
			HttpServletResponse response, String money, String backcardid,
			String pwd) throws Exception {
		String result = null;
		try {
			Long userId = TUserUtil.getLogUser(request).getUserId();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userId", userId);
			map.put("typeId", "12");// 查询在线支付的诚意金
			map.put("audit", 1);// 审批成功
			// 分页加参数
			int page = RequestUtil.getInt(request, "current_page", 1);
			int pageSize = RequestUtil.getInt(request, "pageSize", 10);
			PageBean pb = new PageBean(page, pageSize);
			List<TMoneymove> listvo = tmoneymoveService.getUserMoneyList(map,
					pb);
			if (listvo != null && listvo.size() > 0) {
				result = "1";
			} else {
				result = "0";
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "0";
		}
		return result;
	}
}
