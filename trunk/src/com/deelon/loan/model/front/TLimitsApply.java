package com.deelon.loan.model.front;

import java.math.BigDecimal;
import java.util.Date;

/**
 * TLimitsApply entity. @author MyEclipse Persistence Tools
 */

public class TLimitsApply implements java.io.Serializable {

	// Fields

	private long applyId;
	private BigDecimal limitOld;
	private BigDecimal limitApply;
	private String typeId;
	private long applicant;
	private Date applyTime;
	private short audit;
	private long checker;
	private Date checkTime;
	private String audit_status;
	private String audit_desc;
	
	//非持久化
	private String checkrName;
	private String applyName;
	private String appLyType;
	private String applytimeStr;
	private String checktimeStr;
	
	// Constructors

	/** default constructor */
	public TLimitsApply() {
	}

	/** full constructor */
	public TLimitsApply(BigDecimal limitOld, BigDecimal limitApply, String typeId,
			long applicant, Date applyTime, short audit, long checker,
			Date checkTime) {
		this.limitOld = limitOld;
		this.limitApply = limitApply;
		this.typeId = typeId;
		this.applicant = applicant;
		this.applyTime = applyTime;
		this.audit = audit;
		this.checker = checker;
		this.checkTime = checkTime;
	}

	// Property accessors

	public long getApplyId() {
		return this.applyId;
	}

	public void setApplyId(long applyId) {
		this.applyId = applyId;
	}

	public BigDecimal getLimitOld() {
		return this.limitOld;
	}

	public void setLimitOld(BigDecimal limitOld) {
		this.limitOld = limitOld;
	}

	public BigDecimal getLimitApply() {
		return this.limitApply;
	}

	public void setLimitApply(BigDecimal limitApply) {
		this.limitApply = limitApply;
	}

	public String getTypeId() {
		return this.typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public long getApplicant() {
		return this.applicant;
	}

	public void setApplicant(long applicant) {
		this.applicant = applicant;
	}

	public Date getApplyTime() {
		return this.applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public short getAudit() {
		return this.audit;
	}

	public void setAudit(short audit) {
		this.audit = audit;
	}

	public long getChecker() {
		return this.checker;
	}

	public void setChecker(long checker) {
		this.checker = checker;
	}

	public Date getCheckTime() {
		return this.checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public String getAudit_status() {
		return audit_status;
	}

	public void setAudit_status(String audit_status) {
		this.audit_status = audit_status;
	}

	public String getAudit_desc() {
		return audit_desc;
	}

	public void setAudit_desc(String audit_desc) {
		this.audit_desc = audit_desc;
	}

	public String getApplyName() {
		return applyName;
	}

	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}

	public String getCheckrName() {
		return checkrName;
	}

	public void setCheckrName(String checkrName) {
		this.checkrName = checkrName;
	}

	public String getAppLyType() {
		return appLyType;
	}

	public void setAppLyType(String appLyType) {
		this.appLyType = appLyType;
	}

	public String getApplytimeStr() {
		return applytimeStr;
	}

	public void setApplytimeStr(String applytimeStr) {
		this.applytimeStr = applytimeStr;
	}

	public String getChecktimeStr() {
		return checktimeStr;
	}

	public void setChecktimeStr(String checktimeStr) {
		this.checktimeStr = checktimeStr;
	}

	
}