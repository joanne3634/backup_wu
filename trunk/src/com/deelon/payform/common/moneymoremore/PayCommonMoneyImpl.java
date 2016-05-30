/*
 * Copyright (c) 2008 Asiainfo Technologies(China),Inc.
 *
 * FileName: PayCommonMoneyImpl.java
 *
 * Description:
 *
 * Created: Allen 2014-12-16
 * 
 * |--------------------------------------------------History---------------------------------------------------|
 * |                                                                                                            |
 * |-----Author-----|-----Date-----|----Version----|----------------------------Desc----------------------------| 
 * || 
 * |------------------------------------------------------------------------------------------------------------|
 */
package com.deelon.payform.common.moneymoremore;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.deelon.core.util.AppUtil;
import com.deelon.core.util.BeanUtils;
import com.deelon.loan.model.sysManager.Tbank;
import com.deelon.loan.service.sysManager.TbankService;
import com.deelon.payform.util.moneymoremore.Common;
import com.deelon.payform.util.moneymoremore.HttpClientUtil;
import com.deelon.payform.util.moneymoremore.RsaHelper;

/**
 * PayCommonMoneyImpl
 *
 * <P></P>
 * 
 * @author Administrator 2014-12-16
 * @version 0.0.1
 */
public class PayCommonMoneyImpl   {
	public static HashMap register( HashMap hm) {
		 Object userSafe=	hm.get( "TUserSafe" );
		 Object user=hm.get( "TUser" );
		 String RegisterType=(String)hm.get( "RegisterType" ); 
		 String isCompany=BeanUtils.getProperty( user, "isCompany" );   
			String IdentificationNo="";
			 Map<String, String> req = new TreeMap<String, String>();
				req.put("RegisterType", RegisterType);
				if("0".equals( isCompany )){//个人投资者
					req.put("AccountType", "");		
					IdentificationNo=BeanUtils.getProperty( userSafe, "idNo" );
				}else{
					req.put("AccountType", "1");//企业投资者			
					IdentificationNo=BeanUtils.getProperty( userSafe, "businessLicense" );
				}
				req.put("Mobile", BeanUtils.getProperty( userSafe, "mobile" ));
				req.put("Email", BeanUtils.getProperty( userSafe, "email" ));
				req.put("RealName", BeanUtils.getProperty( user, "realName" ));	
				req.put("IdentificationNo", IdentificationNo);
				req.put("Image1", "");
				req.put("Image2", "");
				req.put("LoanPlatformAccount", BeanUtils.getProperty( user, "loginName" ));
				req.put("PlatformMoneymoremore", PayCommonMoney.payformNo);
				req.put("RandomTimeStamp", PayCommonMoney.getRandomTimeStamp()); 	
				req.put("Remark1", "自定义备注1");
				req.put("Remark2", "自定义备注2");
				req.put("Remark3", "自定义备注3");
				 if(RegisterType.equals("1")){//全自动
					 req.put("ReturnURL", "");
				 }else{
					 req.put("ReturnURL", PayCommonMoney.payReturnURL);
				 }
				req.put("NotifyURL", PayCommonMoney.payNotifyURL);	
				String[] signinfoKey=new String[]{"RegisterType","AccountType","Mobile","Email","RealName",
						 "IdentificationNo","Image1","Image2","LoanPlatformAccount","PlatformMoneymoremore",
						 "RandomTimeStamp","Remark1","Remark2","Remark3","ReturnURL","NotifyURL"};
				req.put("SignInfo", PayCommonMoney.getSignInfo(req,signinfoKey));
				String SubmitURL = PayCommonMoney.paySubmitURLPrefix + "loan/toloanregisterbind.action";
				hm.put("SubmitURL", SubmitURL );
				String[] resultarr = null;				
				 if(RegisterType.equals("1")){//全自动 
					 resultarr=HttpClientUtil.doPostQueryCmd(SubmitURL, req);
					System.out.println(resultarr[0]+"==="+resultarr[1]);
					HashMap rshm=(HashMap)Common.JSONDecode(resultarr[1], HashMap.class);
					 hm.put(PayCommonMoney.payReturnMessageKey, rshm.get( "Message" ) );
					 hm.put(PayCommonMoney.payReturnMoneymoremoreId, rshm.get( "MoneymoremoreId" ) );
				 }else{
					 if(resultarr!=null){
						 hm.put( PayCommonMoney.payReturnKey, resultarr[1] );
					 }
				 }
				 hm.put( PayCommonMoney.payDataKey, req );
		return hm;
	}

	public static HashMap recharge(HashMap hm) {
		Object TUserFunds=	hm.get( "TUserFunds" );
		Object TMoneymove=	hm.get( "TMoneymove" );
		Object TBankcard=	hm.get( "TBankcard" );		
		Map<String, String> req = new TreeMap<String, String>();
		req.put("RechargeMoneymoremore", BeanUtils.getProperty(TUserFunds , "payMark" ));
		req.put("PlatformMoneymoremore", PayCommonMoney.payformNo);
		req.put("OrderNo", BeanUtils.getProperty(TMoneymove , "flowCode"));
		req.put("Amount", BeanUtils.getProperty(TMoneymove , "moneyInOut"));
		req.put("RechargeType", "");
		req.put("FeeType", ""); 
		req.put("CardNo","");
		req.put("RandomTimeStamp", PayCommonMoney.getRandomTimeStamp());
		req.put("Remark1", "自定义备注1");
		req.put("Remark2", "自定义备注2");
		req.put("Remark3", "自定义备注3");
		req.put("ReturnURL", PayCommonMoney.rechargeReturnURL);
		req.put("NotifyURL", PayCommonMoney.rechargeNotifyURL);
		String[] signinfoKey=new String[]{"RechargeMoneymoremore","PlatformMoneymoremore","OrderNo","Amount","RechargeType",
				 "FeeType","CardNo","RandomTimeStamp","Remark1","Remark2","Remark3","ReturnURL","NotifyURL"};
		req.put("SignInfo", PayCommonMoney.getSignInfo(req,signinfoKey));
		String SubmitURL = PayCommonMoney.paySubmitURLPrefix + "loan/toloanrecharge.action";
		hm.put("SubmitURL", SubmitURL );
		hm.put(PayCommonMoney.payDataKey, req );
		return hm;
	}

	public static HashMap withdraws(HashMap hm) {
		// TODO Auto-generated method stub
		Object TUserFunds=	hm.get( "TUserFunds" );
		Object TMoneymove=	hm.get( "TMoneymove" );
		Object TBankcard=	hm.get( "TBankcard" );	
		//根据银行id取得对应的银行代码
		TbankService bs=(TbankService)AppUtil.getBean(TbankService.class);
		Tbank b=bs.getById(Long.valueOf(BeanUtils.getProperty(TBankcard , "bankId")));
		
		Map<String, String> req = new TreeMap<String, String>();
		req.put("WithdrawMoneymoremore", BeanUtils.getProperty(TUserFunds , "payMark" ));
		req.put("PlatformMoneymoremore", PayCommonMoney.payformNo);
		req.put("OrderNo", BeanUtils.getProperty(TMoneymove , "flowCode")); 
		req.put("Amount", BeanUtils.getProperty(TMoneymove , "moneyInOut").replace("-", ""));
		req.put("FeePercent", hm.get("FeePercent").toString());
		req.put("FeeMax", ""); 
		req.put("FeeRate", "");
		req.put("CardNo",BeanUtils.getProperty(TBankcard , "cardId"));
		req.put("CardType", "0");
		req.put("BankCode", BeanUtils.getProperty(b , "bankCode"));
		req.put("BranchBankName", "");
		req.put("Province", BeanUtils.getProperty(TBankcard , "cityNumber"));//开户省份
		req.put("City", BeanUtils.getProperty(TBankcard , "openingNumber"));//开户城市代码
		req.put("RandomTimeStamp", PayCommonMoney.getRandomTimeStamp());
		req.put("Remark1", "自定义备注1");
		req.put("Remark2", "自定义备注2");
		req.put("Remark3", "自定义备注3");
		req.put("ReturnURL", PayCommonMoney.withdrawsReturnURL); 
		req.put("NotifyURL", PayCommonMoney.withdrawsNotifyURL); 
		String[] signinfoKey=new String[]{"WithdrawMoneymoremore","PlatformMoneymoremore","OrderNo","Amount","FeePercent",
				 "FeeMax","FeeRate","CardNo","CardType","BankCode","BranchBankName","Province","City",
				 "RandomTimeStamp","Remark1","Remark2","Remark3","ReturnURL","NotifyURL"};
		req.put("SignInfo", PayCommonMoney.getSignInfo(req,signinfoKey));
		req.put("CardNo",RsaHelper.getInstance().encryptData(BeanUtils.getProperty(TBankcard , "cardId"), PayCommonMoney.publicKey));
		String SubmitURL = PayCommonMoney.paySubmitURLPrefix + "loan/toloanwithdraws.action";
		hm.put("SubmitURL", SubmitURL );
		hm.put(PayCommonMoney.payDataKey, req );
		return hm;
	}
	
	
	public static HashMap loanTrans(HashMap hm){
		// TODO Auto-generated method stub 	
				Map<String, String> req = new TreeMap<String, String>();
				req.put("LoanJsonList", loanTransLoanJsonList(hm));
				req.put("PlatformMoneymoremore", PayCommonMoney.payformNo);
				req.put("TransferAction", "3");
				req.put("Action", "1");
				req.put("TransferType", "2");
				req.put("NeedAudit", "1");
				req.put("RandomTimeStamp", PayCommonMoney.getRandomTimeStamp()); 
				req.put("Remark1", "自定义备注1");
				req.put("Remark2", "自定义备注2");
				req.put("Remark3", "自定义备注3"); 
				req.put("ReturnURL", PayCommonMoney.loanTransReturnURL); 
				req.put("NotifyURL", PayCommonMoney.loanTransNotifyURL);				
				String[] signinfoKey=new String[]{"LoanJsonList","PlatformMoneymoremore","TransferAction","Action","TransferType",
						 "NeedAudit","RandomTimeStamp","Remark1","Remark2","Remark3","ReturnURL","NotifyURL"};
				req.put("SignInfo", PayCommonMoney.getSignInfo(req,signinfoKey));
				String SubmitURL = PayCommonMoney.paySubmitURLPrefix + "loan/loan.action";
				hm.put("SubmitURL", SubmitURL );
				hm.put(PayCommonMoney.payDataKey, req );
			return hm;
	}
	private static String loanTransLoanJsonList(HashMap hm){
		Map<String, String> req = new TreeMap<String, String>();
		req.put("LoanOutMoneymoremore", hm.get("LoanOutMoneymoremore").toString());//付款帐号
		req.put("LoanInMoneymoremore", hm.get("LoanInMoneymoremore").toString());//收款帐号
		req.put("OrderNo",hm.get("OrderNo").toString());//订单号
		req.put("BatchNo", hm.get("BatchNo").toString());//批次号
		req.put("ExchangeBatchNo", "");
		req.put("AdvanceBatchNo", "");
		req.put("Amount", hm.get("Amount").toString());
		req.put("FullAmount", "");
		req.put("TransferName", hm.get("TransferName").toString());
		req.put("Remark", hm.get("TransferName").toString());
		req.put("SecondaryJsonList", "");
		hm.put("LoanJsonList", req.toString());
		return Common.JSONEncode(req);
	}
	//<------------------------------------------------------------>
	public static List<Map<String,Object>> loanTrans(List<Map<String,Object>> list){
		// TODO Auto-generated method stub 	
				Map<String, Object> req = new TreeMap<String, Object>();
				req.put("LoanJsonList", loanTransLoanJsonList(list));
				req.put("PlatformMoneymoremore", PayCommonMoney.payformNo);
				req.put("TransferAction", "3");
				req.put("Action", "1");
				req.put("TransferType", "2");
				req.put("NeedAudit", "1");
				req.put("RandomTimeStamp", PayCommonMoney.getRandomTimeStamp()); 
				req.put("Remark1", "自定义备注1");
				req.put("Remark2", "自定义备注2");
				req.put("Remark3", "自定义备注3"); 
				req.put("ReturnURL", PayCommonMoney.loanTransReturnURL); 
				req.put("NotifyURL", PayCommonMoney.loanTransNotifyURL);				
				String[] signinfoKey=new String[]{"LoanJsonList","PlatformMoneymoremore","TransferAction","Action","TransferType",
						 "NeedAudit","RandomTimeStamp","Remark1","Remark2","Remark3","ReturnURL","NotifyURL"};
				req.put("SignInfo", PayCommonMoney.getSignInfoObj(req,signinfoKey));
				String SubmitURL = PayCommonMoney.paySubmitURLPrefix + "loan/loan.action";
				req.put("SubmitURL", SubmitURL);
				list.add(0,req);
		//		hm.put(PayCommonMoney.payDataKey, req);
			return list;
	}
	private static String loanTransLoanJsonList(List<Map<String,Object>> list){
		if(list.size()==1){
			Map<String,Object> hm = list.get(0);
			 Map<String,String> req = new TreeMap<String, String>();
			 req.put("LoanOutMoneymoremore", hm.get("LoanOutMoneymoremore").toString());//付款帐号
				req.put("LoanInMoneymoremore", hm.get("LoanInMoneymoremore").toString());//收款帐号
				req.put("OrderNo",hm.get("OrderNo").toString());//订单号
				req.put("BatchNo", hm.get("BatchNo").toString());//批次号
				req.put("ExchangeBatchNo", "");
				req.put("AdvanceBatchNo", "");
				req.put("Amount", hm.get("Amount").toString());
				req.put("FullAmount", "");
				req.put("TransferName", hm.get("TransferName").toString());
				req.put("Remark", hm.get("TransferName").toString());
				req.put("SecondaryJsonList", "");
		    	hm.put("LoanJsonList", req);
		    	String SubmitURL = PayCommonMoney.paySubmitURLPrefix + "loan/loan.action";
				hm.put("SubmitURL", SubmitURL );
				return Common.JSONEncode(req);
			 
		}else if(list.size()>1){
			for (Map<String, Object> map : list) {
				Map<String,String> req = new TreeMap<String, String>();
				 req.put("LoanOutMoneymoremore", map.get("LoanOutMoneymoremore").toString());//付款帐号
					req.put("LoanInMoneymoremore", map.get("LoanInMoneymoremore").toString());//收款帐号
					req.put("OrderNo",map.get("OrderNo").toString());//订单号
					req.put("BatchNo", map.get("BatchNo").toString());//批次号
					req.put("ExchangeBatchNo", "");
					req.put("AdvanceBatchNo", "");
					req.put("Amount", map.get("Amount").toString());
					req.put("FullAmount", "");
					req.put("TransferName", map.get("TransferName").toString());
					req.put("Remark", map.get("TransferName").toString());
					req.put("SecondaryJsonList", "");
			    	map.put("LoanJsonList", req);
			    	String SubmitURL = PayCommonMoney.paySubmitURLPrefix + "loan/loan.action";
					map.put("SubmitURL", SubmitURL );
			}
			return Common.JSONEncode(list);
		}
	//	Map<String, String> req = new TreeMap<String, String>();
		return null;
	}
	
	/**
	 * 查询第三方平台余额
	 * @param list
	 * @return
	 */
	public static Map<String,Object> queryAccountMoney(Map<String,Object> map){
		Map<String, Object> req = new TreeMap<String, Object>();
		req.put("PlatformId", queryAccountMoneyToJson(map));
		req.put("PlatformType", "1");
		req.put("PlatformMoneymoremore", PayCommonMoney.payformNo);
					
		String[] signinfoKey=new String[]{"PlatformId","PlatformType","PlatformMoneymoremore"};
		req.put("SignInfo", PayCommonMoney.getSignInfoObj(req,signinfoKey));
		map.put("LoanJsonList",req);
//		hm.put(PayCommonMoney.payDataKey, req);
		return map;
	}
	
	private static String queryAccountMoneyToJson(Map<String,Object> map){
			 Map<String,String> req = new TreeMap<String, String>();
			 req.put("PlatformId", map.get("PlatformId").toString());//收款帐号
		//	map.put("ToJson", req);
			return Common.JSONEncode(map);
	}
}
