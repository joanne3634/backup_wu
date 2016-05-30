package com.deelon.loan.model.front;

import java.math.BigDecimal;
import java.util.Date;

import com.deelon.core.model.BaseModel;

/**
 * TProjectAccept entity. @author MyEclipse Persistence Tools
 */

public class TProjectAccept extends BaseModel{

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -6609794111489247476L;
	private long acceptId;
	private long projectId;
	private long repaymentId;
	private long painvestors;
	private BigDecimal papayBack;
	private BigDecimal paprincipal;
	private BigDecimal painterest;
	private Date papayBackTime;
	
	private BigDecimal palate;
	private Integer paisLate;
	private java.lang.Integer palateDays;
	private Integer paisReplacePay;
	private BigDecimal pareplacePay;
	private java.util.Date pareplacePayTime;
	
	private long investId;//投资id
	private int paTransfering;//是否正在转让债权中
	private long  paOldinvestors;//债权装让前投资人
	private int paHavePay;//还款已经支付

	// Constructors
	public long getInvestId() {
		return investId;
	}

	public void setInvestId(long investId) {
		this.investId = investId;
	}
	public int getPaTransfering() {
		return paTransfering;
	}

	public void setPaTransfering(int paTransfering) {
		this.paTransfering = paTransfering;
	}

	public long getPaOldinvestors() {
		return paOldinvestors;
	}

	public void setPaOldinvestors(long paOldinvestors) {
		this.paOldinvestors = paOldinvestors;
	}

	public int getPaHavePay() {
		return paHavePay;
	}

	public void setPaHavePay(int paHavePay) {
		this.paHavePay = paHavePay;
	}

	/** default constructor */
	public TProjectAccept() {
	}

	// Property accessors

	public long getAcceptId() {
		return this.acceptId;
	}

	public void setAcceptId(long acceptId) {
		this.acceptId = acceptId;
	}

	public long getProjectId() {
		return this.projectId;
	}

	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}

	public long getRepaymentId() {
		return this.repaymentId;
	}

	public void setRepaymentId(long repaymentId) {
		this.repaymentId = repaymentId;
	}

	

	public long getPainvestors() {
		return painvestors;
	}



	public void setPainvestors(long painvestors) {
		this.painvestors = painvestors;
	}



	public BigDecimal getPapayBack() {
		return papayBack;
	}



	public void setPapayBack(BigDecimal papayBack) {
		this.papayBack = papayBack;
	}



	public Date getPapayBackTime() {
		return papayBackTime;
	}



	public void setPapayBackTime(Date papayBackTime) {
		this.papayBackTime = papayBackTime;
	}



	public BigDecimal getPalate() {
		return palate;
	}

	public void setPalate(BigDecimal palate) {
		this.palate = palate;
	}

	public Integer getPaisLate() {
		return paisLate;
	}

	public void setPaisLate(Integer paisLate) {
		this.paisLate = paisLate;
	}

	public java.lang.Integer getPalateDays() {
		return palateDays;
	}

	public void setPalateDays(java.lang.Integer palateDays) {
		this.palateDays = palateDays;
	}

	public Integer getPaisReplacePay() {
		return paisReplacePay;
	}

	public void setPaisReplacePay(Integer paisReplacePay) {
		this.paisReplacePay = paisReplacePay;
	}

	public BigDecimal getPareplacePay() {
		return pareplacePay;
	}

	public void setPareplacePay(BigDecimal pareplacePay) {
		this.pareplacePay = pareplacePay;
	}

	public java.util.Date getPareplacePayTime() {
		return pareplacePayTime;
	}

	public void setPareplacePayTime(java.util.Date pareplacePayTime) {
		this.pareplacePayTime = pareplacePayTime;
	}

	public BigDecimal getPaprincipal() {
		return paprincipal;
	}

	public void setPaprincipal(BigDecimal paprincipal) {
		this.paprincipal = paprincipal;
	}

	public BigDecimal getPainterest() {
		return painterest;
	}

	public void setPainterest(BigDecimal painterest) {
		this.painterest = painterest;
	}
	
	

}