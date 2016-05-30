package com.deelon.payform.model;

import com.deelon.core.model.BaseModel;

public class LoanRechargeOrderQueryBeanLower extends BaseModel {
	/*
	 * 充值人标识
	 */
	private String rechargeMoneymoremore;
	
	/*
	 * 平台标识
	 */
	private String rlatformMoneymoremore;
	
	/*
	 * 流水号
	 */
	private String loanNo;
	
	/*
	 * 订单号
	 */
	private String orderNo;
	
	/*
	 * 金额
	 */
	private String amount;
	
	/*
	 * 手续费
	 */
	private String fee;
	
	/*
	 * 平台手续费
	 */
	private String feePlatform;
	
	/*
	 * 充值时间
	 */
	private String rechargeTime;
	
	/*
	 * 充值类型
	 */
	private String rechargeType;
	
	/*
	 * 手续费类型
	 */
	private String feeType;
	
	/*
	 * 状态
	 */
	private String rechargeState;

	public String getRechargeMoneymoremore() {
		return rechargeMoneymoremore;
	}

	public void setRechargeMoneymoremore(String rechargeMoneymoremore) {
		this.rechargeMoneymoremore = rechargeMoneymoremore;
	}

	public String getRlatformMoneymoremore() {
		return rlatformMoneymoremore;
	}

	public void setRlatformMoneymoremore(String rlatformMoneymoremore) {
		this.rlatformMoneymoremore = rlatformMoneymoremore;
	}

	public String getLoanNo() {
		return loanNo;
	}

	public void setLoanNo(String loanNo) {
		this.loanNo = loanNo;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getFee() {
		return fee;
	}

	public void setFee(String fee) {
		this.fee = fee;
	}

	public String getFeePlatform() {
		return feePlatform;
	}

	public void setFeePlatform(String feePlatform) {
		this.feePlatform = feePlatform;
	}

	public String getRechargeTime() {
		return rechargeTime;
	}

	public void setRechargeTime(String rechargeTime) {
		this.rechargeTime = rechargeTime;
	}

	public String getRechargeType() {
		return rechargeType;
	}

	public void setRechargeType(String rechargeType) {
		this.rechargeType = rechargeType;
	}

	public String getFeeType() {
		return feeType;
	}

	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}

	public String getRechargeState() {
		return rechargeState;
	}

	public void setRechargeState(String rechargeState) {
		this.rechargeState = rechargeState;
	}
	
	
}
