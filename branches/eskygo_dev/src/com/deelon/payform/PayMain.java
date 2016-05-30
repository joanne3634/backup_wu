/*
 * Copyright (c) 2008 Asiainfo Technologies(China),Inc.
 *
 * FileName: PayMain.java
 *
 * Description:
 *
 * Created: Allen 2014-12-17
 * 
 * |--------------------------------------------------History---------------------------------------------------|
 * |                                                                                                            |
 * |-----Author-----|-----Date-----|----Version----|----------------------------Desc----------------------------| 
 * || 
 * |------------------------------------------------------------------------------------------------------------|
 */
package com.deelon.payform;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.deelon.core.util.BeanUtils;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.payform.common.PayCommon;
import com.deelon.payform.common.moneymoremore.PayCommonMoney;
import com.deelon.payform.util.moneymoremore.Common;
import com.deelon.payform.util.moneymoremore.HttpClientUtil;
import com.deelon.payform.util.moneymoremore.RsaHelper;

/**
 * PayMain
 *
 * <P></P>
 * 
 * @author Administrator 2014-12-17
 * @version 0.0.1
 */
public class PayMain {
	private static String RegisterType = "1";
	private static String AccountType = "";
	private static String RandomTimeStamp = "";
	private static String Mobile = "18666090510";
	private static String Email = "libin_bad@163.com";
	private static String RealName = "李斌";
	private static String IdentificationNo = "431003198612282819";
	private static String Image1 = "";
	private static String Image2 = "";
	private static String LoanPlatformAccount = "libin";
	private static String PlatformMoneymoremore = "p422";
	private static String Remark1="";
	private static String Remark2="";
	private static String Remark3="";
	private static String ReturnURL="";
	private static String NotifyURL="http://localhost:8080/gqzc/payform/pay/notify.ht";

	/**
	 *
	 *
	 * @param args
	 */
	public static void main( String[] args ) throws Exception{
		//register();
			//del();
		//withdraws();
		//loanTrans();
		//System.out.println(loanTransLoanJsonList());
		String s="%5B%7B%22LoanOutMoneymoremore%22%3A%22m15698%22%2C%22LoanInMoneymoremore%22%3A%22p422%22%2C%22LoanNo%22%3A%22LN14413292014122218160454646%22%2C%22OrderNo%22%3A%2210000021920014%22%2C%22BatchNo%22%3A%2210000021920014%22%2C%22Amount%22%3A%221000.00%22%2C%22TransferName%22%3A%22%22%2C%22Remark%22%3A%22%22%2C%22SecondaryJsonList%22%3A%22%22%7D%5D";
		s=Common.UrlDecoder(s, "utf-8");
		List<Object> hm=Common.JSONDecodeList(s, HashMap.class);
		for(int i=0;i<hm.size();i++){
			HashMap h=(HashMap)hm.get(i);
			System.out.println(h.get("OrderNo"));
		}
	}
	public static void loanTrans(){
		// TODO Auto-generated method stub 	
				Map<String, String> req = new TreeMap<String, String>();
				req.put("LoanJsonList", loanTransLoanJsonList());
				req.put("PlatformMoneymoremore", "p422");
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
				System.out.println(req.get("SignInfo").toString());
				String SubmitURL = PayCommonMoney.paySubmitURLPrefix + "loan/loan.action";
				String[] resultarr = HttpClientUtil.doPostQueryCmd(SubmitURL, req);
				System.out.println(resultarr[1]);
	}
	public static String loanTransLoanJsonList(){
		Map<String, String> req = new TreeMap<String, String>();
		req.put("LoanOutMoneymoremore", "m15698");
		req.put("LoanInMoneymoremore", "p422");
		req.put("OrderNo","10000021920004");
		req.put("BatchNo","10000021920004");
		req.put("ExchangeBatchNo", "");
		req.put("AdvanceBatchNo", "");
		req.put("Amount", "1000");
		req.put("FullAmount", "");
		req.put("Remark", "");
		req.put("SecondaryJsonList", "");
		return Common.JSONEncode(req);
	}
	public static void register(){
		/*String privatekey = PayCommon.privateKeyPKCS8;
		String dataStr = RegisterType + AccountType + Mobile + Email + RealName + IdentificationNo + Image1 + Image2 + LoanPlatformAccount + PlatformMoneymoremore + RandomTimeStamp + Remark1 + Remark2 + Remark3 + ReturnURL + NotifyURL;
		  System.out.println( RsaHelper.getInstance().signData(dataStr, privatekey));
		   String SignInfo=RsaHelper.getInstance().signData(dataStr, privatekey);
		  // SignInfo="nlahUT70FiSYRxq0BBbKgXlrj3Rx5nlm7slTyuPcTCuDpm62mbeO3GRK/7S7fewS43xjBkfcH81+RvKZ2ytWYdlzBJwZg/hOZ57/Pp5UPWcoDKr8MKhGMS2sMoXHh3NbD4LZfEEhKgd+FCSASf3KM3GYBqnorOYRHTdtncF3ZBE=";
		  String SubmitURL =  "http://218.4.234.150:88/main/loan/toloanregisterbind.action";
		  Map<String, String> req = new TreeMap<String, String>();
			req.put("RegisterType", RegisterType);
			req.put("AccountType", AccountType);
			req.put("Mobile", Mobile);
			req.put("Email", Email);
			req.put("RealName", RealName);
			req.put("IdentificationNo", IdentificationNo);
			req.put("Image1", Image1);
			req.put("Image2", Image2);
			req.put("LoanPlatformAccount", LoanPlatformAccount);
			req.put("PlatformMoneymoremore", PlatformMoneymoremore);
			req.put("RandomTimeStamp", RandomTimeStamp);
			req.put("Remark1", Remark1);
			req.put("Remark2", Remark2);
			req.put("Remark3", Remark3);
			req.put("ReturnURL", ReturnURL);
			req.put("NotifyURL", NotifyURL);
			req.put("SignInfo", SignInfo);
			String[] resultarr = HttpClientUtil.doPostQueryCmd(SubmitURL, req);
			System.out.println(resultarr[1]);
			HashMap hm=(HashMap)Common.JSONDecode(resultarr[1], HashMap.class);
			System.out.println(hm.values().toString());*/
	}
	public static void del(){
		 String SubmitURL =  "http://218.4.234.150:88/main/loantest/loandeletetestinfo.action";
		  Map<String, String> req = new TreeMap<String, String>();
		    req.put("m", "m15568");
			req.put("p", "422");
			req.put("s", "Xf1M/dvIWT7/CoCYMG0LIaPPtmqa63kT6zzFdZjghXe6fgYafaHaN3W+2ExgkA5b5jQxwTryCVoajOx666Cj+gAb1GPSiaIH8UxV+Keow2198eFaKlhV+xYvNvF4OELSn2Sjf27jCZx97KxLhArxAyGFrAcCdV1t5uH4aaGMBwc=");
			String[] resultarr = HttpClientUtil.doPostQueryCmd(SubmitURL, req);
			System.out.println(resultarr[1]);
	}
	public static void withdraws() {
		// TODO Auto-generated method stub 	
		Map<String, String> req = new TreeMap<String, String>();
		req.put("WithdrawMoneymoremore", "m15698");
		req.put("PlatformMoneymoremore", "p422");
		req.put("OrderNo", "10000021870022");
		//BeanUtils.getProperty(TMoneymove , "moneyInOut").replace("-", "")
		req.put("Amount", "200");
		req.put("FeePercent", "50");
		req.put("FeeMax", ""); 
		req.put("FeeRate", "");
		req.put("CardNo","6226220305579392");
		req.put("CardType", "0");
		req.put("BankCode", "12");
		req.put("BranchBankName", "");
		req.put("Province", "19");
		req.put("City", "1197");
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
		req.put("CardNo",RsaHelper.getInstance().encryptData("6226220305579392", PayCommonMoney.publicKey));
		String SubmitURL = PayCommonMoney.paySubmitURLPrefix + "loan/toloanwithdraws.action";
		String[] resultarr = HttpClientUtil.doPostQueryCmd(SubmitURL, req);
		System.out.println(resultarr[1]);
	}
}
