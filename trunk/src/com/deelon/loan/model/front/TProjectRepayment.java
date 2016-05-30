package com.deelon.loan.model.front;

import java.math.BigDecimal;
import java.util.Date;

import com.deelon.core.model.BaseModel;

/**
 * TProjectRepayment entity. @author MyEclipse Persistence Tools
 */

public class TProjectRepayment extends BaseModel implements java.io.Serializable {

	// Fields

	private long repaymentId;//Repayment_id还款记录ID',
	private long currentRepaymentId;
	  private long projectId;//Project_id贷款项目ID',
	  private String prCurrentOfAll;//PR_CurrentOfAll当前期数/总期数',
	  private int prCurrent;//PR_Current当前期数',
	  private BigDecimal prPay;//PR_Pay本期应还款
	  private BigDecimal prRealPay;//PR_RealPay本期实际还款
	  private int prIsPayoff; //	  PR_IsPayOff是否还清
	  private BigDecimal prPayless;//	  PR_PayLess本期剩余还款金额
	  private BigDecimal prLate;//	  PR_Late逾期罚息
	  private int prisLate;//	  PR_IsLate是否逾期
	  private int prLateDays;//	  PR_LateDays逾期天数
	  private BigDecimal prPrincipal;//PR_Principal本金',
	  private BigDecimal prInterest;//PR_Interest利息',
	  private String prRepayWay;//PR_RepayWay还款方式',
	  private long prRepayer;//PR_Repayer'还款人',
	  private Date prPlanPayTime;//PR_PlanPayTime'计划还款时间',
	  private Date prRealPayTime;//PR_RealPayTime'实际还款时间',
	  private int prIsDone;//PR_IsDone已经执行
	  
	  private String prRepayerName;//还款人 
	  private String prRepayerUserName;//会员用户名
	  private String prPlanPayTimeStr;//计划还款时间展示
	  private String prRealPayTimeStr;//实际还款时间展示
	  private String pname;//项目名称
	  
	public long getCurrentRepaymentId() {
		return currentRepaymentId;
	}
	public void setCurrentRepaymentId(long currentRepaymentId) {
		this.currentRepaymentId = currentRepaymentId;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPrRepayerName() {
		return prRepayerName;
	}
	public void setPrRepayerName(String prRepayerName) {
		this.prRepayerName = prRepayerName;
	}
	public String getPrRepayerUserName() {
		return prRepayerUserName;
	}
	public void setPrRepayerUserName(String prRepayerUserName) {
		this.prRepayerUserName = prRepayerUserName;
	}
	public String getPrPlanPayTimeStr() {
		return prPlanPayTimeStr;
	}
	public void setPrPlanPayTimeStr(String prPlanPayTimeStr) {
		this.prPlanPayTimeStr = prPlanPayTimeStr;
	}
	public String getPrRealPayTimeStr() {
		return prRealPayTimeStr;
	}
	public void setPrRealPayTimeStr(String prRealPayTimeStr) {
		this.prRealPayTimeStr = prRealPayTimeStr;
	}
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
	public long getPrRepayer() {
		return prRepayer;
	}
	public void setPrRepayer(long prRepayer) {
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
	public BigDecimal getPrPay() {
		return prPay;
	}
	public void setPrPay(BigDecimal prPay) {
		this.prPay = prPay;
	}
	public BigDecimal getPrRealPay() {
		return prRealPay;
	}
	public void setPrRealPay(BigDecimal prRealPay) {
		this.prRealPay = prRealPay;
	}
	public int getPrIsPayoff() {
		return prIsPayoff;
	}
	public void setPrIsPayoff(int prIsPayoff) {
		this.prIsPayoff = prIsPayoff;
	}
	public BigDecimal getPrPayless() {
		return prPayless;
	}
	public void setPrPayless(BigDecimal prPayless) {
		this.prPayless = prPayless;
	}
	public BigDecimal getPrLate() {
		return prLate;
	}
	public void setPrLate(BigDecimal prLate) {
		this.prLate = prLate;
	}
	public int getPrisLate() {
		return prisLate;
	}
	public void setPrisLate(int prisLate) {
		this.prisLate = prisLate;
	}
	public int getPrLateDays() {
		return prLateDays;
	}
	public void setPrLateDays(int prLateDays) {
		this.prLateDays = prLateDays;
	}
	public int getPrIsDone() {
		return prIsDone;
	}
	public void setPrIsDone(int prIsDone) {
		this.prIsDone = prIsDone;
	}

}