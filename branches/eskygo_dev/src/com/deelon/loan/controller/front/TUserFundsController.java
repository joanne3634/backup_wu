package com.deelon.loan.controller.front;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.payform.common.moneymoremore.PayCommonMoney;
import com.deelon.payform.model.LoanOrderQueryBean;
import com.deelon.payform.model.LoanOrderQueryBeanLower;
import com.deelon.payform.model.LoanOrderQuerySecondaryBean;
import com.deelon.payform.model.LoanRechargeOrderQueryBean;
import com.deelon.payform.model.LoanRechargeOrderQueryBeanLower;
import com.deelon.payform.model.LoanWithdrawsOrderQueryBean;
import com.deelon.payform.model.LoanWithdrawsOrderQueryBeanLower;
import com.deelon.payform.util.moneymoremore.Common;
import com.deelon.payform.util.moneymoremore.HttpClientUtil;
import com.deelon.payform.util.moneymoremore.RsaHelper;

@Controller
@RequestMapping({ "/loan/front/userFunds/" })
public class TUserFundsController extends BaseController {
	
	@Resource
	private TuserFundsService tuserFundsService; 
	@Resource
	private TmoneymoveService tmoneymoveService;
	
	 @RequestMapping({"list"})
	 @ Action( description = "查看TuserFunds分页列表")
	  public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
		 
		 try {
			//begin 获得查询条件
			 String userName = request.getParameter("userName");
			 String realName = request.getParameter("realName");
			//end
			 QueryFilter queryFilter=new QueryFilter(request,"userFundsItem");//分页
			 queryFilter.addFilter("userName", userName);
			 queryFilter.addFilter("realName", realName);
	//		 List<TUserFunds> list = tuserFundsService.getAll(queryFilter);//查询分页列表数据
			 List<TUserFunds> list = tuserFundsService.getUserFundsList(queryFilter);
			
			 return new ModelAndView("/loan/front/tUserFundsList.jsp").addObject("userFundsList", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return null;
	  }
	 
	 
	 
	 @ RequestMapping( { "statement" } )
	 @ Action( description = "会员资金对账")
		public ModelAndView statement( HttpServletRequest request ) throws Exception {
		 	
		 String payMark = request.getParameter("payMark");//支付标识号
		 
		 String privatekey = PayCommonMoney.privateKeyPKCS8;
			
			String dataStr = payMark + "1" + PayCommonMoney.payformNo;
			RsaHelper rsa = RsaHelper.getInstance();
			String SignInfo = rsa.signData(dataStr, privatekey);
		 
		 Map<String, String> req = new TreeMap<String, String>();
			req.put("PlatformId", payMark);
			req.put("PlatformType", "1");
			req.put("PlatformMoneymoremore", "p422");
			req.put("SignInfo", SignInfo);
//			String[] signinfoKey=new String[]{"PlatformId","PlatformType","PlatformMoneymoremore"};
			
			
			
	//		PayCommonMoney.getSignInfo(req,PayCommonMoney);
			String[] resultarr = HttpClientUtil.doPostQueryCmd(PayCommonMoney.balancequery, req);
			System.out.println(resultarr[1]);
			
			
			if (StringUtil.isNotEmpty(resultarr[1]))
			{
				String[] balance = resultarr[1].split("\\|");
				if (balance != null && balance.length > 2)
				{
					request.setAttribute("balance0", balance[0]);
					request.setAttribute("balance1", balance[1]);
					request.setAttribute("balance2", balance[2]);
					System.out.println(balance[0]);
					System.out.println(balance[1]);
					System.out.println(balance[2]);
				}
			}
		 
			Long pkId = Long.valueOf( RequestUtil.getLong( request, "fundsId" ) );//接受页面返回的Id
			TUserFunds tUserFunds = null;
			if ( pkId.longValue() != 0L )
				tUserFunds = (TUserFunds) this.tuserFundsService.getById( pkId );//通过Id查询相应数据
			else {
				tUserFunds = new TUserFunds();
			}
			
			
			return new ModelAndView("/loan/front/tUserFundsStatement.jsp").addObject("payMark", payMark).addObject( "tUserFunds", tUserFunds ).addObject( "fundsId", pkId );
		}
	 
	 @ RequestMapping( { "grid" } )
	 @ Action( description = "会员资金对账")
	public ModelAndView grid( HttpServletRequest request ) throws Exception {

		 	String userId = request.getParameter("userId");//
		 	 String payMark = request.getParameter("payMark");//支付标识号
		 	 String fundsId = request.getParameter("fundsId");//支付标识号
			//查找当前用户的资金流动记录
			
			QueryFilter queryFilter=new QueryFilter(request,"item");
			queryFilter.addFilter("userId", userId);
			queryFilter.addFilter("typeIdIn","1,2,3,4,7,8,11");
			queryFilter.addFilter("typeIdIn1","1");
			queryFilter.addFilter("typeIdIn2","2");
			queryFilter.addFilter("typeIdIn3","3");
			queryFilter.addFilter("typeIdIn4","4");
			queryFilter.addFilter("typeIdIn5","7");
			queryFilter.addFilter("typeIdIn6","8");
			queryFilter.addFilter("typeIdIn7","11");
			queryFilter.addFilter("typeIdIn8","12");
			request.setAttribute("userId", userId);
			List<TMoneymove> kist=tmoneymoveService.getListByMap(queryFilter);
	  return new ModelAndView("/loan/front/tUserFundsGrid.jsp").addObject("list", kist).addObject("payMark",payMark ).addObject("fundsId",fundsId );
 	}
	 
	
	 @ RequestMapping( { "doStatement" } )
	 @ Action( description = "对账")
	 public ModelAndView doStatement(HttpServletRequest request, HttpServletResponse response){
		 
		 String action=request.getParameter("Action");//空.转账 1.充值2.提现
		 String flowCode=request.getParameter("flowCode");//流水号

		 
		 String privatekey = PayCommonMoney.privateKeyPKCS8;
			String LoanNo="";
		 	String OrderNo=flowCode;
			 String BatchNo = "";
			 String BeginTime = "";
			 String EndTime = "";
		 
		 
			String dataStr = PayCommonMoney.payformNo + action +LoanNo +OrderNo+BatchNo+BeginTime+EndTime ;
			RsaHelper rsa = RsaHelper.getInstance();
			String SignInfo = rsa.signData(dataStr, privatekey);
		 
		 Map<String, String> req = new TreeMap<String, String>();
		 req.put("PlatformMoneymoremore", PayCommonMoney.payformNo);
			req.put("Action", action);
			req.put("LoanNo", LoanNo);
			req.put("OrderNo", OrderNo);
			req.put("BatchNo", BatchNo);
			req.put("BeginTime",BeginTime);
			req.put("EndTime", EndTime);
			req.put("SignInfo", SignInfo);
			String[] resultarr = HttpClientUtil.doPostQueryCmd(PayCommonMoney.loanorderquery, req);
			System.out.println(resultarr[1]);
			
			LoanOrderQueryBean loqb=null;
			LoanOrderQuerySecondaryBean loqsb=null;
			LoanRechargeOrderQueryBean lroqb=null;
			LoanWithdrawsOrderQueryBean lwoqb =null;
			if (StringUtil.isNotEmpty(resultarr[1]) && (resultarr[1].startsWith("[") || resultarr[1].startsWith("{")))
			{
				if (StringUtil.isEmpty(action))
				{
					// 转账
					List<Object> loanobjectlist = Common.JSONDecodeList(resultarr[1], LoanOrderQueryBean.class);
					if (loanobjectlist != null && loanobjectlist.size() > 0)
					{
						for (int i = 0; i < loanobjectlist.size(); i++)
						{
							if (loanobjectlist.get(i) instanceof LoanOrderQueryBean)
							{
								 loqb = (LoanOrderQueryBean) loanobjectlist.get(i);
								System.out.println(loqb);
								// 二次分配列表
								if (StringUtil.isNotEmpty(loqb.getSecondaryJsonList()))
								{
									List<Object> loansecondarylist = Common.JSONDecodeList(loqb.getSecondaryJsonList(), LoanOrderQuerySecondaryBean.class);
									if (loansecondarylist != null && loansecondarylist.size() > 0)
									{
										for (int j = 0; j < loansecondarylist.size(); j++)
										{
											if (loansecondarylist.get(j) instanceof LoanOrderQuerySecondaryBean)
											{
												 loqsb = (LoanOrderQuerySecondaryBean) loansecondarylist.get(j);
												System.out.println(loqsb);
											}
										}
									}
								}
							}
						}
					}
				}
				else if (action.equals("1"))
				{
					// 充值
					List<Object> loanobjectlist = Common.JSONDecodeList(resultarr[1], LoanRechargeOrderQueryBean.class);
					if (loanobjectlist != null && loanobjectlist.size() > 0)
					{
						for (int i = 0; i < loanobjectlist.size(); i++)
						{
							if (loanobjectlist.get(i) instanceof LoanRechargeOrderQueryBean)
							{
								 lroqb = (LoanRechargeOrderQueryBean) loanobjectlist.get(i);
								System.out.println(lroqb);
							}
						}
					}
				}
				else if (action.equals("2"))
				{
					// 提现
					List<Object> loanobjectlist = Common.JSONDecodeList(resultarr[1], LoanWithdrawsOrderQueryBean.class);
					if (loanobjectlist != null && loanobjectlist.size() > 0)
					{
						for (int i = 0; i < loanobjectlist.size(); i++)
						{
							if (loanobjectlist.get(i) instanceof LoanWithdrawsOrderQueryBean)
							{
								 lwoqb = (LoanWithdrawsOrderQueryBean) loanobjectlist.get(i);
								System.out.println(lwoqb);
							}
						}
					}
				}
			}
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			LoanOrderQueryBeanLower lb=null;
			if(loqb!=null){
				lb=new LoanOrderQueryBeanLower();
				lb.setAction(loqb.getAction());
				lb.setActNo(loqb.getActNo());
				lb.setActState(loqb.getActState());
				lb.setActTime(loqb.getActTime());
				lb.setAmount(loqb.getAmount());
				lb.setBatchNo(loqb.getBatchNo());
				lb.setLoanInMoneymoremore(loqb.getLoanInMoneymoremore());
				lb.setLoanNo(loqb.getLoanNo());
				lb.setLoanOutMoneymoremore(loqb.getLoanOutMoneymoremore());
				lb.setOrderNo(loqb.getOrderNo());
				lb.setPlatformMoneymoremore(loqb.getPlatformMoneymoremore());
				lb.setRemark(loqb.getRemark());
				lb.setSecondaryJsonList(loqb.getSecondaryJsonList());
				lb.setSecondaryState(loqb.getSecondaryState());
				lb.setSecondaryTime(loqb.getSecondaryTime());
				lb.setTransferAction(loqb.getTransferAction());
				lb.setTransferName(loqb.getTransferName());
				lb.setTransferState(loqb.getTransferState());
				lb.setTransferTime(loqb.getTransferTime());
				lb.setTransferType(loqb.getTransferType());
				
			}
			LoanRechargeOrderQueryBeanLower ll=null;
			if(lroqb!=null){
				ll=new LoanRechargeOrderQueryBeanLower();
				ll.setRechargeMoneymoremore(lroqb.getRechargeMoneymoremore());

				ll.setRlatformMoneymoremore(lroqb.getPlatformMoneymoremore());

				ll.setLoanNo(lroqb.getLoanNo());

				ll.setOrderNo(lroqb.getOrderNo());

				ll.setAmount(lroqb.getAmount());

				ll.setFee(lroqb.getFee());

				ll.setFeePlatform(lroqb.getFeePlatform());

				ll.setRechargeTime(lroqb.getRechargeTime());

				ll.setRechargeType(lroqb.getRechargeType());

				ll.setFeeType(lroqb.getFeeType());

				ll.setRechargeState(lroqb.getRechargeState());
			}
			LoanWithdrawsOrderQueryBeanLower lw=null;
			if(lwoqb!=null){
				lw=new LoanWithdrawsOrderQueryBeanLower();
				lw.setWithdrawMoneymoremore(lwoqb.getWithdrawMoneymoremore());

				lw.setPlatformMoneymoremore(lwoqb.getPlatformMoneymoremore());

				lw.setLoanNo(lwoqb.getLoanNo());

				lw.setOrderNo(lwoqb.getOrderNo());

				lw.setAmount(lwoqb.getAmount());

				lw.setFeeMax(lwoqb.getFeeMax());

				lw.setFeeWithdraws(lwoqb.getFeeWithdraws());

				lw.setFeePercent(lwoqb.getFeePercent()) ;

				lw.setFee(lwoqb.getFee());

				lw.setFreeLimit(lwoqb.getFreeLimit());

				lw.setFeeRate(lwoqb.getFeeRate());

				lw.setFeeSplitting(lwoqb.getFeeSplitting());

				lw.setSplittingSettleState(lwoqb.getSplittingSettleState());

				lw.setWithdrawState(lwoqb.getWithdrawState());

				lw.setWithdrawsTime(lwoqb.getWithdrawsTime());

				lw.setPlatformAuditState(lwoqb.getPlatformAuditState());

				lw.setPlatformAuditTime(lwoqb.getPlatformAuditTime());

				lw.setWithdrawsBackTime(lwoqb.getWithdrawsBackTime());
			}
			if(StringUtil.isEmpty(resultarr[1])){
				request.setAttribute("notExistData","1" );
			}
			request.setAttribute("LoanOrderQueryBean",lb );
			request.setAttribute("LoanOrderQuerySecondaryBean",loqsb );
			request.setAttribute("LoanRechargeOrderQueryBean", ll);
			request.setAttribute("LoanWithdrawsOrderQueryBean", lw);
			
		 return new ModelAndView("/loan/front/tUserFundsTable.jsp");
	 }
	 
	 @ RequestMapping( { "updateFundsOfUser" } )
	 @ Action( description = "修正用户资金")
	 @ResponseBody
	 public String updateFundsOfUser(HttpServletRequest request, HttpServletResponse response){
		 Long pkId = Long.valueOf( RequestUtil.getLong( request, "tmoneymoveId" ) );//接受页面返回的Id
		 try {
			// tuserFundsService; 
			 TMoneymove m=tmoneymoveService.getById(pkId);
			 if(m!=null){
				 //修改用户资金记录的状态为成功,
				 m.setResultId("1");//成功
				 String remark=m.getRemark();
				 if(StringUtil.isNotEmpty(remark)){
					 remark=remark.replaceAll("失败", "成功");
				 }
				 m.setSerialNo("对账后已修正会员资金");//这里用来区分 需不需要显示 撤销按钮
				 m.setRemark(remark);
				 tmoneymoveService.update(m);
				 TUserFunds uf=tuserFundsService.getByUserId(m.getUserId());
				 uf.setAvailable(uf.getAvailable().add(m.getMoneyInOut().abs()));//加上
				 uf.setBalance(uf.getAvailable().add(uf.getFreeze()));//重新计算
				 tuserFundsService.update(uf);
				 return "1";
			 }
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		 return null;
	 }
	 
	 @ RequestMapping( { "rollBackFundsOfUser" } )
	 @ Action( description = "撤销修修正的用户资金")
	 @ResponseBody
	 public String rollBackFundsOfUser(HttpServletRequest request, HttpServletResponse response){
		 Long pkId = Long.valueOf( RequestUtil.getLong( request, "tmoneymoveId" ) );//接受页面返回的Id
		 try {
			// tuserFundsService; 
			 TMoneymove m=tmoneymoveService.getById(pkId);
			 if(m!=null){
				 //修改用户资金记录的状态为成功,
				 m.setResultId("2");//成功
				 String remark=m.getRemark();
				 if(StringUtil.isNotEmpty(remark)){
					 remark=remark.replaceAll("成功", "失败");
				 }
				 m.setSerialNo("");//清空 //这里用来区分 需不需要显示 撤销按钮
				 m.setRemark(remark);
				 tmoneymoveService.update(m);
				 TUserFunds uf=tuserFundsService.getByUserId(m.getUserId());
				 uf.setAvailable(uf.getAvailable().subtract(m.getMoneyInOut().abs()));//减去
				 uf.setBalance(uf.getAvailable().add(uf.getFreeze()));//重新计算
				 tuserFundsService.update(uf);
				 return "1";
			 }
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		 
		 return null;
	 }
	 
	 
	 @ RequestMapping( { "edit" } )
	 @ Action( description = "编辑TriskCompany数据")
		public ModelAndView edit( HttpServletRequest request ) throws Exception {
			Long pkId = Long.valueOf( RequestUtil.getLong( request, "fundsId" ) );//接受页面返回的Id
			TUserFunds tUserFunds = null;
			if ( pkId.longValue() != 0L )
				tUserFunds = (TUserFunds) this.tuserFundsService.getById( pkId );//通过Id查询相应数据
			else {
				tUserFunds = new TUserFunds();
			}
			return new ModelAndView("/loan/front/tUserFundsEdit.jsp").addObject( "tUserFunds", tUserFunds ).addObject( "fundsId", pkId );
		}
	 
	@ RequestMapping( { "editUserFunds" } )
	public String editUserFunds( HttpServletRequest request ) throws Exception {
		String userId = request.getParameter("userId");
		String balance = request.getParameter("balance");
		String freeze = request.getParameter("freeze");
		String available = request.getParameter("available");
		String fundsId = request.getParameter("fundsId");
		
		System.out.println(userId+"--->"+balance+"--->"+freeze+"--->"+available+"--->"+fundsId);

		TUser sessionUser = (TUser) request.getSession().getAttribute("user");
		if(sessionUser == null){
			return "登录已失效，请重新登录";
		}
		long user_id = sessionUser.getUserId();

		TUserFunds userFunds = new TUserFunds();
		userFunds.setFundsId(Long.parseLong(fundsId));
		userFunds.setUserId(Long.parseLong(userId));
		userFunds.setBalance( BigDecimal.valueOf(Long.parseLong(balance)));
		userFunds.setFreeze( BigDecimal.valueOf(Long.parseLong(balance)));
		userFunds.setAvailable( BigDecimal.valueOf(Long.parseLong(balance)));

		return "0";
	}

}
