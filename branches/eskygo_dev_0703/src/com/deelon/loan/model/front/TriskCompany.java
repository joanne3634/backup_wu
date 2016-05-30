package com.deelon.loan.model.front;

import com.deelon.core.model.BaseModel;

public class TriskCompany extends BaseModel{
	private java.lang.Long companyId;
	private String name;
	private String contact;
	private String address;
	private String code;
	private String phone;
	private String mobile;
	private String fax;
	private String email;
	private String summary;
	private String rcPaypwd;//RC_PayPwd
	private int rcDefault;
	
	
	public int getRcDefault() {
		return rcDefault;
	}
	public void setRcDefault(int rcDefault) {
		this.rcDefault = rcDefault;
	}
	public String getRcPaypwd() {
		return rcPaypwd;
	}
	public void setRcPaypwd(String rcPaypwd) {
		this.rcPaypwd = rcPaypwd;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public java.lang.Long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(java.lang.Long companyId) {
		this.companyId = companyId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
}
