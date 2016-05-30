package com.deelon.loan.model.front;

import java.util.Date;

/**
 * TUserCompany entity. @author MyEclipse Persistence Tools
 */

public class TUserCompany implements java.io.Serializable {

	// Fields

	private long companyId;
	private long userId;
	private String CJobsStatus;
	private String CIncomePayWay;
	private String CNature;
    private String CIndustry;
    private String CIncomeScope;
	private String CWorkYears;
	private String CName;
	private String cSize;
	private String CDeptName;
	private String CAreaid;
	private String CAddress;
	private String CPhone;
	private Date CUpdateTime;
	private String CPost;
	private String statusID;
	private Date checkTime;
	
	public long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getCJobsStatus() {
		return CJobsStatus;
	}

	public void setCJobsStatus(String cJobsStatus) {
		CJobsStatus = cJobsStatus;
	}

	public String getCIncomePayWay() {
		return CIncomePayWay;
	}

	public void setCIncomePayWay(String cIncomePayWay) {
		CIncomePayWay = cIncomePayWay;
	}

	public String getCNature() {
		return CNature;
	}

	public void setCNature(String cNature) {
		CNature = cNature;
	}

	public String getCIndustry() {
		return CIndustry;
	}

	public void setCIndustry(String cIndustry) {
		CIndustry = cIndustry;
	}

	public String getCIncomeScope() {
		return CIncomeScope;
	}

	public void setCIncomeScope(String cIncomeScope) {
		CIncomeScope = cIncomeScope;
	}

	public String getCWorkYears() {
		return CWorkYears;
	}

	public void setCWorkYears(String cWorkYears) {
		CWorkYears = cWorkYears;
	}

	public String getCName() {
		return CName;
	}

	public void setCName(String cName) {
		CName = cName;
	}

	public String getcSize() {
		return cSize;
	}

	public void setcSize(String cSize) {
		this.cSize = cSize;
	}

	public String getCDeptName() {
		return CDeptName;
	}

	public void setCDeptName(String cDeptName) {
		CDeptName = cDeptName;
	}

	public String getCAreaid() {
		return CAreaid;
	}

	public void setCAreaid(String cAreaid) {
		CAreaid = cAreaid;
	}

	public String getCAddress() {
		return CAddress;
	}

	public void setCAddress(String cAddress) {
		CAddress = cAddress;
	}

	public String getCPhone() {
		return CPhone;
	}

	public void setCPhone(String cPhone) {
		CPhone = cPhone;
	}

	public Date getCUpdateTime() {
		return CUpdateTime;
	}

	public void setCUpdateTime(Date cUpdateTime) {
		CUpdateTime = cUpdateTime;
	}

	public String getCPost() {
		return CPost;
	}

	public void setCPost(String cPost) {
		CPost = cPost;
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
		return "TUserCompany [companyId=" + companyId + ", userId=" + userId
				+ ", CJobsStatus=" + CJobsStatus + ", CIncomePayWay="
				+ CIncomePayWay + ", CNature=" + CNature + ", CIndustry="
				+ CIndustry + ", CIncomeScope=" + CIncomeScope
				+ ", CWorkYears=" + CWorkYears + ", CName=" + CName
				+ ", CSize=" + cSize + ", CDeptName=" + CDeptName
				+ ", CAreaid=" + CAreaid + ", CAddress=" + CAddress
				+ ", CPhone=" + CPhone + ", CUpdateTime=" + CUpdateTime + "]";
	}
	
}