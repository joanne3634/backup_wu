package com.deelon.loan.model.front;

import java.sql.Timestamp;
import java.util.Date;

/**
 * TUserSafe entity. @author MyEclipse Persistence Tools
 */

public class TUserSafe implements java.io.Serializable {

	// Fields

	private long safeId;
	private long userId;
	private String mobile;
	private short bindMobile;
	private String email;
	private short bindEmail;
	private String idNo;
	private short bindIdNo;
	private String qqNo;
	private String q1;
	private String a1;
	private String q2;
	private String a2;
	private String q3;
	private String a3;
	private Timestamp outDate;
	private String validataKey;
	
	private String loginName;
	private String reallname;
	private String statusID;
	private Date checkTime;

	// Constructors

	/** default constructor */
	public TUserSafe() {
	}

	/** full constructor */
	public TUserSafe(long userId, String mobile, short bindMobile,
			String email, short bindEmail, String idNo, short bindIdNo,
			String qqNo, String q1, String a1, String q2, String a2, String q3,
			String a3) {
		this.userId = userId;
		this.mobile = mobile;
		this.bindMobile = bindMobile;
		this.email = email;
		this.bindEmail = bindEmail;
		this.idNo = idNo;
		this.bindIdNo = bindIdNo;
		this.qqNo = qqNo;
		this.q1 = q1;
		this.a1 = a1;
		this.q2 = q2;
		this.a2 = a2;
		this.q3 = q3;
		this.a3 = a3;
	}

	// Property accessors

	public long getSafeId() {
		return this.safeId;
	}

	public void setSafeId(long safeId) {
		this.safeId = safeId;
	}

	public long getUserId() {
		return this.userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public short getBindMobile() {
		return this.bindMobile;
	}

	public void setBindMobile(short bindMobile) {
		this.bindMobile = bindMobile;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public short getBindEmail() {
		return this.bindEmail;
	}

	public void setBindEmail(short bindEmail) {
		this.bindEmail = bindEmail;
	}

	public String getIdNo() {
		return this.idNo;
	}

	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}

	public short getBindIdNo() {
		return this.bindIdNo;
	}

	public void setBindIdNo(short bindIdNo) {
		this.bindIdNo = bindIdNo;
	}

	public String getQqNo() {
		return this.qqNo;
	}

	public void setQqNo(String qqNo) {
		this.qqNo = qqNo;
	}

	public String getQ1() {
		return this.q1;
	}

	public void setQ1(String q1) {
		this.q1 = q1;
	}

	public String getA1() {
		return this.a1;
	}

	public void setA1(String a1) {
		this.a1 = a1;
	}

	public String getQ2() {
		return this.q2;
	}

	public void setQ2(String q2) {
		this.q2 = q2;
	}

	public String getA2() {
		return this.a2;
	}

	public void setA2(String a2) {
		this.a2 = a2;
	}

	public String getQ3() {
		return this.q3;
	}

	public void setQ3(String q3) {
		this.q3 = q3;
	}

	public String getA3() {
		return this.a3;
	}

	public void setA3(String a3) {
		this.a3 = a3;
	}
	
	public Timestamp getOutDate() {
		return outDate;
	}

	public void setOutDate(Timestamp outDate) {
		this.outDate = outDate;
	}

	public String getValidataKey() {
		return validataKey;
	}

	public void setValidataKey(String validataKey) {
		this.validataKey = validataKey;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getReallname() {
		return reallname;
	}

	public void setReallname(String reallname) {
		this.reallname = reallname;
	}

	public String getStatusID() {
		return statusID;
	}

	public void setStatusID(String statusID) {
		this.statusID = statusID;
	}


	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	@Override
	public String toString() {
		return "TUserSafe [safeId=" + safeId + ", userId=" + userId
				+ ", mobile=" + mobile + ", bindMobile=" + bindMobile
				+ ", email=" + email + ", bindEmail=" + bindEmail + ", idNo="
				+ idNo + ", bindIdNo=" + bindIdNo + ", qqNo=" + qqNo + ", q1="
				+ q1 + ", a1=" + a1 + ", q2=" + q2 + ", a2=" + a2 + ", q3="
				+ q3 + ", a3=" + a3 + ", outDate=" + outDate + ", validataKey="
				+ validataKey + ", loginName=" + loginName + ", reallname="
				+ reallname + "]";
	}

}