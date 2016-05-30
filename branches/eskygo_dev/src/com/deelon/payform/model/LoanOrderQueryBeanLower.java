package com.deelon.payform.model;

import com.deelon.core.model.BaseModel;

public class LoanOrderQueryBeanLower extends BaseModel {
	/*
	 * 付款人标识
	 */
	private String loanOutMoneymoremore;
	
	/*
	 * 收款人标识
	 */
	private String loanInMoneymoremore;
	
	/*
	 * 乾多多流水号
	 */
	private String loanNo;
	
	/*
	 * 平台订单号
	 */
	private String orderNo;
	
	/*
	 * 平台标号
	 */
	private String batchNo;
	
	/*
	 * 金额
	 */
	private String amount;
	
	/*
	 * 平台乾多多标识
	 */
	private String platformMoneymoremore;
	
	/*
	 * 转账类型 1.投标 2.还款
	 */
	private String transferAction;
	
	/*
	 * 操作类型 1.手动 2.自动
	 */
	private String action;
	
	/*
	 * 转账方式 1.桥连 2.直连
	 */
	private String transferType;
	
	/*
	 * 转账状态 0.未转账 1.已转账
	 */
	private String transferState;
	
	/*
	 * 转账时间
	 */
	private String transferTime;
	
	/*
	 * 操作状态 0.未操作 1.已通过 2.已退回 3.自动通过
	 */
	private String actState;
	
	/*
	 * 通过/退回时间
	 */
	private String actTime;
	
	/*
	 * 通过/退回流水号
	 */
	private String actNo;
	
	/*
	 * 二次分配状态 null.无二次分配 0.未审核 1.同意 2.不同意 3.系统自动同意
	 */
	private String secondaryState;
	
	/*
	 * 二次分配时间
	 */
	private String secondaryTime;
	
	/*
	 * 二次分配列表
	 */
	private String secondaryJsonList;
	
	/*
	 * 用途
	 */
	private String transferName;
	
	/*
	 * 备注
	 */
	private String remark;

	public String getLoanOutMoneymoremore() {
		return loanOutMoneymoremore;
	}

	public void setLoanOutMoneymoremore(String loanOutMoneymoremore) {
		this.loanOutMoneymoremore = loanOutMoneymoremore;
	}

	public String getLoanInMoneymoremore() {
		return loanInMoneymoremore;
	}

	public void setLoanInMoneymoremore(String loanInMoneymoremore) {
		this.loanInMoneymoremore = loanInMoneymoremore;
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

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getPlatformMoneymoremore() {
		return platformMoneymoremore;
	}

	public void setPlatformMoneymoremore(String platformMoneymoremore) {
		this.platformMoneymoremore = platformMoneymoremore;
	}

	public String getTransferAction() {
		return transferAction;
	}

	public void setTransferAction(String transferAction) {
		this.transferAction = transferAction;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getTransferType() {
		return transferType;
	}

	public void setTransferType(String transferType) {
		this.transferType = transferType;
	}

	public String getTransferState() {
		return transferState;
	}

	public void setTransferState(String transferState) {
		this.transferState = transferState;
	}

	public String getTransferTime() {
		return transferTime;
	}

	public void setTransferTime(String transferTime) {
		this.transferTime = transferTime;
	}

	public String getActState() {
		return actState;
	}

	public void setActState(String actState) {
		this.actState = actState;
	}

	public String getActTime() {
		return actTime;
	}

	public void setActTime(String actTime) {
		this.actTime = actTime;
	}

	public String getActNo() {
		return actNo;
	}

	public void setActNo(String actNo) {
		this.actNo = actNo;
	}

	public String getSecondaryState() {
		return secondaryState;
	}

	public void setSecondaryState(String secondaryState) {
		this.secondaryState = secondaryState;
	}

	public String getSecondaryTime() {
		return secondaryTime;
	}

	public void setSecondaryTime(String secondaryTime) {
		this.secondaryTime = secondaryTime;
	}

	public String getSecondaryJsonList() {
		return secondaryJsonList;
	}

	public void setSecondaryJsonList(String secondaryJsonList) {
		this.secondaryJsonList = secondaryJsonList;
	}

	public String getTransferName() {
		return transferName;
	}

	public void setTransferName(String transferName) {
		this.transferName = transferName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	
	
}
