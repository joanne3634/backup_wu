/*
 * Copyright (c) 2008 Asiainfo Technologies(China),Inc.
 *
 * FileName: PayCommonImpl.java
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
package com.deelon.payform.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.deelon.core.util.AppConfigUtil;
import com.deelon.payform.common.moneymoremore.PayCommonMoneyImpl;

/**
 * PayCommonImpl
 *第
 * <P></P>
 * 
 * @author Administrator 2014-12-16
 * @version 0.0.1
 */
public class PayCommon {

	public static String payform=AppConfigUtil.get( "payform" );
	public static String payformType=AppConfigUtil.get( "payformType" );
	
	
	
	/**
	 * 注册接口
	 * @param hm
	 * @return
	 */
	public static HashMap register( HashMap hm) {
		if("true".equals( payform )){
			if("1".equals( payformType )){//钱多多支付
				PayCommonMoneyImpl.register( hm );
			}
		}
		return hm;
	}
	/**
	 * 充值
	 * @param hm
	 * @return
	 */
	public static HashMap recharge(HashMap hm) {
		if("true".equals( payform )){
			if("1".equals( payformType )){//钱多多支付
				PayCommonMoneyImpl.recharge( hm );
			}
		}
		return hm;
		
	}
	/**
	 * 提现
	 * @param hm
	 * @return
	 */
	public static HashMap withdraws(HashMap hm) {
		// TODO Auto-generated method stub
		if("true".equals( payform )){
			if("1".equals( payformType )){//钱多多支付
				PayCommonMoneyImpl.withdraws( hm );
			}
		}
		return hm;
	}
	
	
	/**
	 * 转帐
	 * @param hm
	 * @return
	 */
	public static HashMap loanTrans(HashMap hm) {
		// TODO Auto-generated method stub
		if("true".equals( payform )){
			if("1".equals( payformType )){//钱多多支付
				PayCommonMoneyImpl.loanTrans(hm);
			}
		}
		return hm;
	}
	
	/**
	 * 转帐2
	 * @param hm
	 * @return
	 */
	public static List<Map<String,Object>> loanTrans(List<Map<String,Object>> list) {
		// TODO Auto-generated method stub
		if("true".equals( payform )){
			if("1".equals( payformType )){//钱多多支付
				PayCommonMoneyImpl.loanTrans(list);
			}
		}
		return list;
	}
	
	/**
	 * 查询第三方账户余额
	 * @param list
	 * @return
	 */
	public static Map<String,Object> queryAccountMoney(Map<String,Object> map){
		if("true".equals( payform )){
			if("1".equals( payformType )){//钱多多支付
				PayCommonMoneyImpl.queryAccountMoney(map);
			}
		}
		return map;
	}
}
