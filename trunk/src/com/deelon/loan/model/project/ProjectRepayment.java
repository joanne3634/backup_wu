package com.deelon.loan.model.project;

import java.math.BigDecimal;
import java.util.Date;

public class ProjectRepayment implements java.io.Serializable{
	  private long repaymentId;//Repayment_id还款记录ID',
	  private long projectId;//Project_id贷款项目ID',
	  private String prCurrentOfAll;//PR_CurrentOfAll当前期数/总期数',
	  private int prCurrent;//PR_Current当前期数',
	  private BigDecimal prPaymentTotal;//PR_PaymentTotal还款总额',
	  private BigDecimal prPrincipal;//PR_Principal本金',
	  private BigDecimal prInterest;//PR_Interest利息',
	  private String prRepayWay;//PR_RepayWay还款方式',
	  private int prRepayer;//PR_Repayer'还款人',
	  private Date prPlanPayTime;//PR_PlanPayTime'计划还款时间',
	  private Date prRealPayTime;//PR_RealPayTime'实际还款时间',
	  private int prIsOverdue;//PR_IsOverdue'是否逾期',
	  private int prIsDone;//PR_IsDone已经执行
	public long getRepaymentId() {
		return repaymentId;
	}
	public void setRepaymentId(long repaymentId) {
		this.repaymentId = repaymentId;
	}
	public long getProjectId() {
		return projectId;
	}
	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}
	public String getPrCurrentOfAll() {
		return prCurrentOfAll;
	}
	public void setPrCurrentOfAll(String prCurrentOfAll) {
		this.prCurrentOfAll = prCurrentOfAll;
	}
	public int getPrCurrent() {
		return prCurrent;
	}
	public void setPrCurrent(int prCurrent) {
		this.prCurrent = prCurrent;
	}
	public BigDecimal getPrPaymentTotal() {
		return prPaymentTotal;
	}
	public void setPrPaymentTotal(BigDecimal prPaymentTotal) {
		this.prPaymentTotal = prPaymentTotal;
	}
	public BigDecimal getPrPrincipal() {
		return prPrincipal;
	}
	public void setPrPrincipal(BigDecimal prPrincipal) {
		this.prPrincipal = prPrincipal;
	}
	public BigDecimal getPrInterest() {
		return prInterest;
	}
	public void setPrInterest(BigDecimal prInterest) {
		this.prInterest = prInterest;
	}
	public String getPrRepayWay() {
		return prRepayWay;
	}
	public void setPrRepayWay(String prRepayWay) {
		this.prRepayWay = prRepayWay;
	}
	public int getPrRepayer() {
		return prRepayer;
	}
	public void setPrRepayer(int prRepayer) {
		this.prRepayer = prRepayer;
	}
	public Date getPrPlanPayTime() {
		return prPlanPayTime;
	}
	public void setPrPlanPayTime(Date prPlanPayTime) {
		this.prPlanPayTime = prPlanPayTime;
	}
	public Date getPrRealPayTime() {
		return prRealPayTime;
	}
	public void setPrRealPayTime(Date prRealPayTime) {
		this.prRealPayTime = prRealPayTime;
	}
	public int getPrIsOverdue() {
		return prIsOverdue;
	}
	public void setPrIsOverdue(int prIsOverdue) {
		this.prIsOverdue = prIsOverdue;
	}
	public int getPrIsDone() {
		return prIsDone;
	}
	public void setPrIsDone(int prIsDone) {
		this.prIsDone = prIsDone;
	}
	  
}
