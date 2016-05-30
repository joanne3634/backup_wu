package com.deelon.loan.model.sysManager;

import java.util.HashSet;
import java.util.Set;

import com.deelon.core.model.BaseModel;
import com.deelon.loan.model.front.TUserCompany;
import com.deelon.loan.model.front.TUserContact;
import com.deelon.loan.model.front.TUserFamily;
import com.deelon.loan.model.front.TUserSafe;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TuserAudit extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TuserAudit";
	public static final String ALIAS_USER_ID = "用户ID";
	public static final String ALIAS_LOGIN_NAME = "帐号";
	public static final String ALIAS_REAL_NAME = "真实姓名";
	public static final String ALIAS_ID_NO = "身份证号码";
	public static final String ALIAS_REGISTER_TIME = "registerTime";
	public static final String ALIAS_USER_SAFE = "个人信息";
	public static final String ALIAS_USER_FAMILY = "家庭信息";
	public static final String ALIAS_USER_COMPANY = "单位信息";
	public static final String ALIAS_USER_CONTACT = "联系信息";
	public static final String ALIAS_AUDITOR = "审核人";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long userId;
	private java.lang.String loginName;
	private java.lang.String realName;
	private java.lang.String idNo;
	private java.util.Date registerTime;
	private java.lang.String userSafe;
	private java.lang.String userFamily;
	private java.lang.String userCompany;
	private java.lang.String userContact;
	private java.lang.String auditor;
	
	private String auditorName;
	//columns END

	public TuserAudit(){
	}

	public TuserAudit(
		java.lang.Long userId
	){
		this.userId = userId;
	}

	public void setUserId(java.lang.Long value) {
		this.userId = value;
	}
	
	public java.lang.Long getUserId() {
		return this.userId;
	}
	public void setLoginName(java.lang.String value) {
		this.loginName = value;
	}
	
	public java.lang.String getLoginName() {
		return this.loginName;
	}
	public void setRealName(java.lang.String value) {
		this.realName = value;
	}
	
	public java.lang.String getRealName() {
		return this.realName;
	}
	public void setIdNo(java.lang.String value) {
		this.idNo = value;
	}
	
	public java.lang.String getIdNo() {
		return this.idNo;
	}
	public void setRegisterTime(java.util.Date value) {
		this.registerTime = value;
	}
	
	public java.util.Date getRegisterTime() {
		return this.registerTime;
	}
	
	public java.lang.String getUserSafe() {
		return userSafe;
	}

	public void setUserSafe(java.lang.String userSafe) {
		this.userSafe = userSafe;
	}

	public java.lang.String getUserFamily() {
		return userFamily;
	}

	public void setUserFamily(java.lang.String userFamily) {
		this.userFamily = userFamily;
	}

	public java.lang.String getUserCompany() {
		return userCompany;
	}

	public void setUserCompany(java.lang.String userCompany) {
		this.userCompany = userCompany;
	}

	public java.lang.String getUserContact() {
		return userContact;
	}

	public void setUserContact(java.lang.String userContact) {
		this.userContact = userContact;
	}

	public void setAuditor(java.lang.String value) {
		this.auditor = value;
	}
	
	public java.lang.String getAuditor() {
		return this.auditor;
	}
	
	public String getAuditorName() {
		return auditorName;
	}

	public void setAuditorName(String auditorName) {
		this.auditorName = auditorName;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("UserId",getUserId())
			.append("LoginName",getLoginName())
			.append("RealName",getRealName())
			.append("IdNo",getIdNo())
			.append("RegisterTime",getRegisterTime())
			.append("UserSafe",getUserSafe())
			.append("UserFamily",getUserFamily())
			.append("UserCompany",getUserCompany())
			.append("UserContact",getUserContact())
			.append("Auditor",getAuditor())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getUserId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TuserAudit == false) return false;
		if(this == obj) return true;
		TuserAudit other = (TuserAudit)obj;
		return new EqualsBuilder()
			.append(getUserId(),other.getUserId())
			.isEquals();
	}
}

