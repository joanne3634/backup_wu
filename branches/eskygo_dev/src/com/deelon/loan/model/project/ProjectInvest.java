package com.deelon.loan.model.project;

import java.math.BigDecimal;
import java.util.Date;

public class ProjectInvest implements java.io.Serializable{
	
	 private long investId;//Invest_id 投资ID
	 private long projectId;//Project_id贷款项目ID
	 private int piInvestors;//PI_Investors投资人
	 private BigDecimal piAmount;//PI_Amount投资额
	 private BigDecimal piEffectAmount;// PI_EffectAmount投资额（实际有效）
	 private Date piBidTime;// PI_BidTime 投标时间
	 private int  piHavedPay;//PI_HavedPay 是否完成打款
	 private Date piHavedPayTime;//PI_HavedPayTime打款时间
	 private int piIsCancel;//PI_IsCancel是否取消投标       
	public long getInvestId() {
		return investId;
	}
	public void setInvestId(long investId) {
		this.investId = investId;
	}
	public long getProjectId() {
		return projectId;
	}
	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}
	public int getPiInvestors() {
		return piInvestors;
	}
	public void setPiInvestors(int piInvestors) {
		this.piInvestors = piInvestors;
	}
	public BigDecimal getPiAmount() {
		return piAmount;
	}
	public void setPiAmount(BigDecimal piAmount) {
		this.piAmount = piAmount;
	}
	public BigDecimal getPiEffectAmount() {
		return piEffectAmount;
	}
	public void setPiEffectAmount(BigDecimal piEffectAmount) {
		this.piEffectAmount = piEffectAmount;
	}
	public Date getPiBidTime() {
		return piBidTime;
	}
	public void setPiBidTime(Date piBidTime) {
		this.piBidTime = piBidTime;
	}
	public int getPiHavedPay() {
		return piHavedPay;
	}
	public void setPiHavedPay(int piHavedPay) {
		this.piHavedPay = piHavedPay;
	}
	public Date getPiHavedPayTime() {
		return piHavedPayTime;
	}
	public void setPiHavedPayTime(Date piHavedPayTime) {
		this.piHavedPayTime = piHavedPayTime;
	}
	public int getPiIsCancel() {
		return piIsCancel;
	}
	public void setPiIsCancel(int piIsCancel) {
		this.piIsCancel = piIsCancel;
	}

}
