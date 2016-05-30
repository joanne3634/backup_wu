package com.deelon.loan.model.front;

import java.util.Date;

import com.deelon.core.model.BaseModel;

/**
 * TProductsloan entity. @author MyEclipse Persistence Tools
 */

public class TProductsloan extends BaseModel implements java.io.Serializable {

	// Fields

	private long productsLoanId;
	private String PName;
	private String PAmountMin;
	private String PAmountMax;
	private String PRateMin;
	private String PRateMax;
	private String PDeadlineMin;
	private String PDeadlineMax;
	private String PAuditDaysMin;
	private String PAuditDaysMax;
	private String PVotingDaysMin;
	private String PVotingDaysMax;
	private String PRepayWay;
	private String PFee;
	private String PGood;
	private String PRecommend;
	private String PRepayGuide;
	private long creator;
	private Date createTime;

	// Constructors

	/** default constructor */
	public TProductsloan() {
	}

	/** full constructor */
	public TProductsloan(String PName, String PAmountMin, String PAmountMax,
			String PRateMin, String PRateMax, String PDeadlineMin,
			String PDeadlineMax, String PAuditDaysMin, String PAuditDaysMax,
			String PVotingDaysMin, String PVotingDaysMax, String PRepayWay,
			String PFee, String PGood, String PRecommend, String PRepayGuide,
			long creator, Date createTime) {
		this.PName = PName;
		this.PAmountMin = PAmountMin;
		this.PAmountMax = PAmountMax;
		this.PRateMin = PRateMin;
		this.PRateMax = PRateMax;
		this.PDeadlineMin = PDeadlineMin;
		this.PDeadlineMax = PDeadlineMax;
		this.PAuditDaysMin = PAuditDaysMin;
		this.PAuditDaysMax = PAuditDaysMax;
		this.PVotingDaysMin = PVotingDaysMin;
		this.PVotingDaysMax = PVotingDaysMax;
		this.PRepayWay = PRepayWay;
		this.PFee = PFee;
		this.PGood = PGood;
		this.PRecommend = PRecommend;
		this.PRepayGuide = PRepayGuide;
		this.creator = creator;
		this.createTime = createTime;
	}

	// Property accessors

	public long getProductsLoanId() {
		return this.productsLoanId;
	}

	public void setProductsLoanId(long productsLoanId) {
		this.productsLoanId = productsLoanId;
	}

	public String getPName() {
		return this.PName;
	}

	public void setPName(String PName) {
		this.PName = PName;
	}

	public String getPAmountMin() {
		return this.PAmountMin;
	}

	public void setPAmountMin(String PAmountMin) {
		this.PAmountMin = PAmountMin;
	}

	public String getPAmountMax() {
		return this.PAmountMax;
	}

	public void setPAmountMax(String PAmountMax) {
		this.PAmountMax = PAmountMax;
	}

	public String getPRateMin() {
		return this.PRateMin;
	}

	public void setPRateMin(String PRateMin) {
		this.PRateMin = PRateMin;
	}

	public String getPRateMax() {
		return this.PRateMax;
	}

	public void setPRateMax(String PRateMax) {
		this.PRateMax = PRateMax;
	}

	public String getPDeadlineMin() {
		return this.PDeadlineMin;
	}

	public void setPDeadlineMin(String PDeadlineMin) {
		this.PDeadlineMin = PDeadlineMin;
	}

	public String getPDeadlineMax() {
		return this.PDeadlineMax;
	}

	public void setPDeadlineMax(String PDeadlineMax) {
		this.PDeadlineMax = PDeadlineMax;
	}

	public String getPAuditDaysMin() {
		return this.PAuditDaysMin;
	}

	public void setPAuditDaysMin(String PAuditDaysMin) {
		this.PAuditDaysMin = PAuditDaysMin;
	}

	public String getPAuditDaysMax() {
		return this.PAuditDaysMax;
	}

	public void setPAuditDaysMax(String PAuditDaysMax) {
		this.PAuditDaysMax = PAuditDaysMax;
	}

	public String getPVotingDaysMin() {
		return this.PVotingDaysMin;
	}

	public void setPVotingDaysMin(String PVotingDaysMin) {
		this.PVotingDaysMin = PVotingDaysMin;
	}

	public String getPVotingDaysMax() {
		return this.PVotingDaysMax;
	}

	public void setPVotingDaysMax(String PVotingDaysMax) {
		this.PVotingDaysMax = PVotingDaysMax;
	}

	public String getPRepayWay() {
		return this.PRepayWay;
	}

	public void setPRepayWay(String PRepayWay) {
		this.PRepayWay = PRepayWay;
	}

	public String getPFee() {
		return this.PFee;
	}

	public void setPFee(String PFee) {
		this.PFee = PFee;
	}

	public String getPGood() {
		return this.PGood;
	}

	public void setPGood(String PGood) {
		this.PGood = PGood;
	}

	public String getPRecommend() {
		return this.PRecommend;
	}

	public void setPRecommend(String PRecommend) {
		this.PRecommend = PRecommend;
	}

	public String getPRepayGuide() {
		return this.PRepayGuide;
	}

	public void setPRepayGuide(String PRepayGuide) {
		this.PRepayGuide = PRepayGuide;
	}

	public long getCreator() {
		return this.creator;
	}

	public void setCreator(long creator) {
		this.creator = creator;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}