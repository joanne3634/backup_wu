package com.deelon.payform.model;

import com.deelon.core.model.BaseModel;

public class LoanWithdrawsOrderQueryBeanLower extends BaseModel {
	/*
	 * 提现人乾多多标识
	 */
	private String withdrawMoneymoremore;
	
	/*
	 * 平台乾多多标识
	 */
	private String platformMoneymoremore;
	
	/*
	 * 乾多多流水号
	 */
	private String loanNo;
	
	/*
	 * 平台订单号
	 */
	private String orderNo;
	
	/*
	 * 金额
	 */
	private String amount;
	
	/*
	 * 用户承担的最高手续费
	 */
	private String feeMax;
	
	/*
	 * 用户实际承担的手续费金额
	 */
	private String feeWithdraws;
	
	/*
	 * 平台承担的手续费比例
	 */
	private String feePercent;
	
	/*
	 * 平台承担的手续费金额
	 */
	private String fee;
	
	/*
	 * 平台扣除的免费提现额
	 */
	private String freeLimit;
	
	/*
	 * 上浮费率
	 */
	private String feeRate;
	
	/*
	 * 平台分润
	 */
	private String feeSplitting;
	
	/*
	 * 平台分润结算状态
	 */
	private String splittingSettleState;
	
	/*
	 * 提现状态
	 */
	private String withdrawState;
	
	/*
	 * 提现时间
	 */
	private String withdrawsTime;
	
	/*
	 * 平台审核状态
	 */
	private String platformAuditState;
	
	/*
	 * 平台审核时间
	 */
	private String platformAuditTime;
	
	/*
	 * 退回时间
	 */
	private String withdrawsBackTime;

	public String getWithdrawMoneymoremore() {
		return withdrawMoneymoremore;
	}

	public void setWithdrawMoneymoremore(String withdrawMoneymoremore) {
		this.withdrawMoneymoremore = withdrawMoneymoremore;
	}

	public String getPlatformMoneymoremore() {
		return platformMoneymoremore;
	}

	public void setPlatformMoneymoremore(String platformMoneymoremore) {
		this.platformMoneymoremore = platformMoneymoremore;
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

	public String getFeeMax() {
		return feeMax;
	}

	public void setFeeMax(String feeMax) {
		this.feeMax = feeMax;
	}

	public String getFeeWithdraws() {
		return feeWithdraws;
	}

	public void setFeeWithdraws(String feeWithdraws) {
		this.feeWithdraws = feeWithdraws;
	}

	public String getFeePercent() {
		return feePercent;
	}

	public void setFeePercent(String feePercent) {
		this.feePercent = feePercent;
	}

	public String getFee() {
		return fee;
	}

	public void setFee(String fee) {
		this.fee = fee;
	}

	public String getFreeLimit() {
		return freeLimit;
	}

	public void setFreeLimit(String freeLimit) {
		this.freeLimit = freeLimit;
	}

	public String getFeeRate() {
		return feeRate;
	}

	public void setFeeRate(String feeRate) {
		this.feeRate = feeRate;
	}

	public String getFeeSplitting() {
		return feeSplitting;
	}

	public void setFeeSplitting(String feeSplitting) {
		this.feeSplitting = feeSplitting;
	}

	public String getSplittingSettleState() {
		return splittingSettleState;
	}

	public void setSplittingSettleState(String splittingSettleState) {
		this.splittingSettleState = splittingSettleState;
	}

	public String getWithdrawState() {
		return withdrawState;
	}

	public void setWithdrawState(String withdrawState) {
		this.withdrawState = withdrawState;
	}

	public String getWithdrawsTime() {
		return withdrawsTime;
	}

	public void setWithdrawsTime(String withdrawsTime) {
		this.withdrawsTime = withdrawsTime;
	}

	public String getPlatformAuditState() {
		return platformAuditState;
	}

	public void setPlatformAuditState(String platformAuditState) {
		this.platformAuditState = platformAuditState;
	}

	public String getPlatformAuditTime() {
		return platformAuditTime;
	}

	public void setPlatformAuditTime(String platformAuditTime) {
		this.platformAuditTime = platformAuditTime;
	}

	public String getWithdrawsBackTime() {
		return withdrawsBackTime;
	}

	public void setWithdrawsBackTime(String withdrawsBackTime) {
		this.withdrawsBackTime = withdrawsBackTime;
	}
	
	
	
}
