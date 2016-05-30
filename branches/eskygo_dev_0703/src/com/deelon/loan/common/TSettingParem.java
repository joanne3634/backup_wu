package com.deelon.loan.common;

public interface TSettingParem {
	
	/**
	 * 手续费比率
	 * @author pyg
	 *	key
	 */
	interface HandingCharge{
		//充值手续费
		String rechargeMoney="HANDING_CHARGE_PROPORTION"; //key
		//取现手续费
		String drawMoney="HANDING_DRAW_MONEY";
		//平台平台承担取现手续费0-100之间的数
		//0表示手续费100%由用户承担
		//100表示手续费100%由平台承担
		//默认是0
		String FeePercent="HANDING_DRAW_FeePercent";
	}
	
	/**
	 * 招标
	 * @author pyg
	 * key
	 */
	interface InviteTender{
		//招标百分比 ,达到多少就可以满标
		String inviteTenderPerCent="INVITE_TENDER_PERCENT";
	}
	
	/**
	 * 操作名称,
	 * @author Administrator
	 * 
	 */
	interface ActionName{
		String RECHARGE_MONEY="充值";//1
		String DRAW_MONEY="提现";//2
		String HANDlE_BID="手动投标";//3
		String AUTO_BID="自动投标";//4
		String ASSIGNMENT_OF_DEBT="债权转让";//5
	}
	
	/**
	 * 模块名称
	 * @author Administrator
	 *
	 */
	interface ModelName{
		String MONEY_MANAGE="资金管理";//1
		String FIANACIL_MANAGEMENT="理财管理";//2
		String HOUSEHOlDE_FINANCE="我要理财";//3
		String ASSIGNMENT_OF_DEBT="债权转让";//4
	}

}
