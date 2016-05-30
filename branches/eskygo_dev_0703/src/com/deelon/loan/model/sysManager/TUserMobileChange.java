/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */


package com.deelon.loan.model.sysManager;

import java.sql.Timestamp;
import java.util.Date;

import com.deelon.core.model.BaseModel;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;


public class TUserMobileChange extends BaseModel {
	private Long mobileChangeid;
	private String mobileOld;
	private String mobileNew;
	private Date createTime;
	private Long isPass;
	private Long checker;
	private Timestamp checkTime;
	private String reason;
	private Long userId;
	private String userName;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public TUserMobileChange(){
	}

	public TUserMobileChange(Long mobileChangeid){
		this.mobileChangeid = mobileChangeid;
	}
	
	public Long getMobileChangeid() {
		return mobileChangeid;
	}

	public void setMobileChangeid(Long mobileChangeid) {
		this.mobileChangeid = mobileChangeid;
	}

	public String getMobileOld() {
		return mobileOld;
	}

	public void setMobileOld(String mobileOld) {
		this.mobileOld = mobileOld;
	}

	public String getMobileNew() {
		return mobileNew;
	}

	public void setMobileNew(String mobileNew) {
		this.mobileNew = mobileNew;
	}



	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getIsPass() {
		return isPass;
	}

	public void setIsPass(Long isPass) {
		this.isPass = isPass;
	}

	public Long getChecker() {
		return checker;
	}

	public void setChecker(Long checker) {
		this.checker = checker;
	}

	public Timestamp getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Timestamp checkTime) {
		this.checkTime = checkTime;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("MobileChange_id",getMobileChangeid())
			.append("M_MobileOld",getMobileOld())
			.append("M_MobileNew",getMobileNew())
			.append("M_CreateTime",getCreateTime())
			.append("M_IsPass",getIsPass())
			.append("M_Checker",getChecker())
			.append("M_CheckTime",getCheckTime())
			.append("M_Reason",getReason())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getMobileChangeid())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TUserMobileChange == false) return false;
		if(this == obj) return true;
		TUserMobileChange other = (TUserMobileChange)obj;
		return new EqualsBuilder()
			.append(getMobileChangeid(),other.getMobileChangeid())
			.isEquals();
	}
}

