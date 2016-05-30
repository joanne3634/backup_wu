package com.deelon.loan.model.project;

import java.math.BigDecimal;
import java.util.Date;

public class ProjectAccept implements java.io.Serializable{
	private long acceptId;//Accept_id收到还款ID',
	private long projectId;//Project_id贷款项目ID',
	private long repaymentId;//Repayment_id还款记录ID',
	private int paInvestors;//PA_Investors投资人',
	private BigDecimal paPayBack;//PA_PayBack返回金额',
	private Date paPayBackTime;//PA_PayBackTime返回时间'
	public long getAcceptId() {
		return acceptId;
	}
	public void setAcceptId(long acceptId) {
		this.acceptId = acceptId;
	}
	public long getProjectId() {
		return projectId;
	}
	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}
	public long getRepaymentId() {
		return repaymentId;
	}
	public void setRepaymentId(long repaymentId) {
		this.repaymentId = repaymentId;
	}
	public int getPaInvestors() {
		return paInvestors;
	}
	public void setPaInvestors(int paInvestors) {
		this.paInvestors = paInvestors;
	}
	public BigDecimal getPaPayBack() {
		return paPayBack;
	}
	public void setPaPayBack(BigDecimal paPayBack) {
		this.paPayBack = paPayBack;
	}
	public Date getPaPayBackTime() {
		return paPayBackTime;
	}
	public void setPaPayBackTime(Date paPayBackTime) {
		this.paPayBackTime = paPayBackTime;
	}
	
}
