package com.deelon.payform.model;

import com.deelon.core.model.BaseModel;

/**
 * 网贷平台 对账接口 返回
 * 
 * @author
 * 
 */
public class LoanOrderQueryBean extends BaseModel
{
	/*
	 * 付款人标识
	 */
	private String LoanOutMoneymoremore = "";
	
	/*
	 * 收款人标识
	 */
	private String LoanInMoneymoremore = "";
	
	/*
	 * 乾多多流水号
	 */
	private String LoanNo = "";
	
	/*
	 * 平台订单号
	 */
	private String OrderNo = "";
	
	/*
	 * 平台标号
	 */
	private String BatchNo = "";
	
	/*
	 * 金额
	 */
	private String Amount = "";
	
	/*
	 * 平台乾多多标识
	 */
	private String PlatformMoneymoremore = "";
	
	/*
	 * 转账类型 1.投标 2.还款
	 */
	private String TransferAction = "";
	
	/*
	 * 操作类型 1.手动 2.自动
	 */
	private String Action = "";
	
	/*
	 * 转账方式 1.桥连 2.直连
	 */
	private String TransferType = "";
	
	/*
	 * 转账状态 0.未转账 1.已转账
	 */
	private String TransferState = "";
	
	/*
	 * 转账时间
	 */
	private String TransferTime = "";
	
	/*
	 * 操作状态 0.未操作 1.已通过 2.已退回 3.自动通过
	 */
	private String ActState = "";
	
	/*
	 * 通过/退回时间
	 */
	private String ActTime = "";
	
	/*
	 * 通过/退回流水号
	 */
	private String ActNo = "";
	
	/*
	 * 二次分配状态 null.无二次分配 0.未审核 1.同意 2.不同意 3.系统自动同意
	 */
	private String SecondaryState = "";
	
	/*
	 * 二次分配时间
	 */
	private String SecondaryTime = "";
	
	/*
	 * 二次分配列表
	 */
	private String SecondaryJsonList = "";
	
	/*
	 * 用途
	 */
	private String TransferName = "";
	
	/*
	 * 备注
	 */
	private String Remark = "";
	
	
	
	
	
	public LoanOrderQueryBean() {
	
		// TODO Auto-generated constructor stub
	}





	public String getLoanOutMoneymoremore() {
		return this.LoanOutMoneymoremore;
	}





	public void setLoanOutMoneymoremore(String loanOutMoneymoremore) {
		this.LoanOutMoneymoremore = loanOutMoneymoremore;
	}



	


	public String getLoanInMoneymoremore() {
		return this.LoanInMoneymoremore;
	}





	public void setLoanInMoneymoremore(String loanInMoneymoremore) {
		this.LoanInMoneymoremore = loanInMoneymoremore;
	}





	public String getLoanNo() {
		return this.LoanNo;
	}





	public void setLoanNo(String loanNo) {
		this.LoanNo = loanNo;
	}





	public String getOrderNo() {
		return this.OrderNo;
	}





	public void setOrderNo(String orderNo) {
		this.OrderNo = orderNo;
	}





	public String getBatchNo() {
		return this.BatchNo;
	}





	public void setBatchNo(String batchNo) {
		this.BatchNo = batchNo;
	}





	public String getAmount() {
		return this.Amount;
	}





	public void setAmount(String amount) {
		this.Amount = amount;
	}





	public String getPlatformMoneymoremore() {
		return this.PlatformMoneymoremore;
	}





	public void setPlatformMoneymoremore(String platformMoneymoremore) {
		this.PlatformMoneymoremore = platformMoneymoremore;
	}





	public String getTransferAction() {
		return this.TransferAction;
	}





	public void setTransferAction(String transferAction) {
		this.TransferAction = transferAction;
	}





	public String getAction() {
		return this.Action;
	}





	public void setAction(String action) {
		this.Action = action;
	}





	public String getTransferType() {
		return this.TransferType;
	}





	public void setTransferType(String transferType) {
		this.TransferType = transferType;
	}





	public String getTransferState() {
		return this.TransferState;
	}





	public void setTransferState(String transferState) {
		this.TransferState = transferState;
	}





	public String getTransferTime() {
		return this.TransferTime;
	}





	public void setTransferTime(String transferTime) {
		this.TransferTime = transferTime;
	}





	public String getActState() {
		return this.ActState;
	}





	public void setActState(String actState) {
		this.ActState = actState;
	}





	public String getActTime() {
		return this.ActTime;
	}





	public void setActTime(String actTime) {
		this.ActTime = actTime;
	}





	public String getActNo() {
		return this.ActNo;
	}





	public void setActNo(String actNo) {
		this.ActNo = actNo;
	}





	public String getSecondaryState() {
		return this.SecondaryState;
	}





	public void setSecondaryState(String secondaryState) {
		this.SecondaryState = secondaryState;
	}





	public String getSecondaryTime() {
		return this.SecondaryTime;
	}





	public void setSecondaryTime(String secondaryTime) {
		this.SecondaryTime = secondaryTime;
	}





	public String getSecondaryJsonList() {
		return this.SecondaryJsonList;
	}





	public void setSecondaryJsonList(String secondaryJsonList) {
		this.SecondaryJsonList = secondaryJsonList;
	}





	public String getTransferName() {
		return this.TransferName;
	}





	public void setTransferName(String transferName) {
		this.TransferName = transferName;
	}





	public String getRemark() {
		return this.Remark;
	}





	public void setRemark(String remark) {
		this.Remark = remark;
	}









	

	
	
}
