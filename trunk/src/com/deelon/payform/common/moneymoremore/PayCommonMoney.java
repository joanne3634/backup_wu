package com.deelon.payform.common.moneymoremore;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

import com.deelon.core.util.AppUtil;
import com.deelon.payform.util.moneymoremore.Common;
import com.deelon.payform.util.moneymoremore.MD5;
import com.deelon.payform.util.moneymoremore.RsaHelper;

public class PayCommonMoney {
	//public static String CONTEXT_URL="http://54.223.187.101";
//	public static String CONTEXT_URL="http://www.wuyouchou.com";
	public static String CONTEXT_URL="http://192.168.1.134:8088";
	//#支付平台的标识号， 钱多多
	public static String payformNo="p1157";
	//#支付平台提交路径
	public static String paySubmitURLPrefix="http://218.4.234.150:88/main/";
	//#支付平台半自动主册时页面返回地址
	public static String payReturnURL=CONTEXT_URL+"/payform/pay/returnUrl.ht";
	//#支付平台注册后台通知地址
	public static String payNotifyURL=CONTEXT_URL+"/payform/pay/notifyUrl.ht";	
	
	//#支付平台充值时页面返回地址	
	public static String rechargeReturnURL=CONTEXT_URL+"/payform/pay/rechargeReturnUrl.ht";
	
	//#支付平台充值后台通知地址
	public static String rechargeNotifyURL=CONTEXT_URL+"/payform/pay/rechargeNotifyUrl.ht"; 
	//#支付平台提现时页面返回地址	
	public static String withdrawsReturnURL=CONTEXT_URL+"/payform/pay/withdrawsReturnUrl.ht";
	//#支付平台提现后台通知地址
	public static String withdrawsNotifyURL=CONTEXT_URL+"/payform/pay/withdrawsNotifyUrl.ht"; 
	//#支付平台提现时页面返回地址	
	public static String loanTransReturnURL=CONTEXT_URL+"/payform/pay/loanTransReturnUrl.ht";
	//#支付平台提现后台通知地址
	public static String loanTransNotifyURL=CONTEXT_URL+"/payform/pay/loanTransNotifyUrl.ht"; 
	
	//#余额查询接口地址
	public static String balancequery=paySubmitURLPrefix+"loan/balancequery.action";
	//#对账接口地址		
	public static String loanorderquery=paySubmitURLPrefix+"loan/loanorderquery.action";
	
	//#支付平台的启用防抵赖时标识号， 钱多多 1为启用0为停用  暂不开通会签名失败
	public static String payformAntistate="0";
	public static final String privateKeyPKCS8 ="MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAMyXVKwikdCx+tA2hKue6n6KjmK/"+
												"Oq7hYfSj2srTjqE36KfgzSNYe+lFpfnfn8qhS85qVNnjdT8lNxdLT0ZPTOdR0fMHrtqi2RJoAFwZ"+
												"UhcB9Xy+m03fFDU1znbqJGKltVRrtPQbTsTZKGDDzY6pwWA/jI7G7rzRh7UMB2xQORpdAgMBAAEC"+
												"gYBBpPzCDoWC1NiJHjULa/4JhCOTg5AstJxdhoWZNrA5AltgIj0v7iA0BOjwd9Qpi/9qx6taDiV8"+
												"kVBP5RYWlTMzImST6gIZaKYXro+ThucfUTgXQFU1J1Y6Pg7DyKzORSkzrqaysI7QLC+5tleAr5+0"+
												"7Tf27rupsh05Iz0reEz68QJBAPN8ZNt+Pcc5+OSar2YKRRes+WKorQVur4imoXdozDFyPlbNIGfF"+
												"HyC4pjLFiNAtD02BIfaJVjvrW/Mj7uDqjscCQQDXGzA0ZSnywjTGjzAN+IOnrEmZcksvgcJl5lBd"+
												"vLh4Kgu2A8+3nCSvhrDNTaveWM1B8g1Vy1F6HC/L61iNo7m7AkBIgbaXFlTXSxAvI1EwFcbVchEh"+
												"rBE6GOf0zYovwOltoBOoTZVk0XKfj90OKXzAYWq5LccrX2JqnX/YO88a8z5pAkBmxBh9j69AyUOJ"+
												"cTMWGZpcatUmuBHvemCzahsPDXBcCEpcBOoh4DkumnyxOOBZc7dsQAXa7S3Z1smG9MLzuDqtAkAc"+
												"dOVxnFgg/9Y7bNpNc+9vozURuh2n3yN1+THNZU6fJ8Hl01vY8g5xDy2ZorSwkdHFAE1Fb6RGgnb7"+
												"yFpcIYIn";
	public static final String publicKey ="MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMl1SsIpHQsfrQNoSrnup+io5ivzqu4WH0o9rK046hN+in4M0jWHvpRaX535/KoUvOalTZ43U/JTcXS09GT0znUdHzB67aotkSaABcGVIXAfV8vptN3xQ1Nc526iRipbVUa7T0G07E2Shgw82OqcFgP4yOxu680Ye1DAdsUDkaXQIDAQAB";
	
	public static String payReturnMoneymoremoreId="payReturnMoneymoremoreId";
	public static String payReturnMessageKey="payReturnMessageKey";
	public static String payReturnKey="payReturnKey";
	public static String payDataKey="payDataKey";
	
	
	
	
	/**
	 * 获取启用防抵赖时必填随机时间戳
	 *
	 * @return
	 */
	public static String getRandomTimeStamp(){
		String RandomTimeStamp="";
		if (payformAntistate.equals("1"))
		{
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			RandomTimeStamp = Common.getRandomNum(2) + sdf.format(d);
		} 
		return RandomTimeStamp;
	}
	public static String getSignInfo(Map<String, String> req,String[] signinfoKey){
					MD5 md5 = new  MD5(); 
					String dataStr="";
					for(int i=0;i<signinfoKey.length;i++){
						dataStr=dataStr+req.get( signinfoKey[i]);
					}
					if (payformAntistate.equals( "1"))
					{
						dataStr = md5.getMD5Info(dataStr);
					}
					return RsaHelper.getInstance().signData(dataStr, privateKeyPKCS8);
				  
	}
	
	
	
	public static String getSignInfoObj(Map<String, Object> req,String[] signinfoKey){
		MD5 md5 = new  MD5(); 
		String dataStr="";
		for(int i=0;i<signinfoKey.length;i++){
			dataStr=dataStr+req.get( signinfoKey[i]);
		}
		if (payformAntistate.equals( "1"))
		{
			dataStr = md5.getMD5Info(dataStr);
		}
		return RsaHelper.getInstance().signData(dataStr, privateKeyPKCS8);
	  
}
	
	public static void main(String[] args){
		System.out.println(CONTEXT_URL);
		System.out.println(payformNo);
		
	}
}
