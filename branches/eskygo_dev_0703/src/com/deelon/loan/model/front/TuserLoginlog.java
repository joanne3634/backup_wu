package com.deelon.loan.model.front;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import java.util.HashSet;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TuserLoginlog extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TuserLoginlog";
	public static final String ALIAS_LOGIN_LOG_ID = "日志ID";
	public static final String ALIAS_USER_ID = "会员ID";
	public static final String ALIAS_TYPE_ID = "类型：1登录,2退出";
	public static final String ALIAS_PLATFORM_ID = "平台：1电脑,2手机";
	public static final String ALIAS_CLIENT_IP = "客户IP";
	public static final String ALIAS_DEVICE_ID = "客户设备ID(手机)";
	public static final String ALIAS_ACTION_TIME = "发生时间";
	public static final String ALIAS_RESULT_ID = "结果ID：1成功 2失败";
	public static final String ALIAS_REMARKS = "备注";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long loginLogId;
	private java.lang.Long userId;
	private java.lang.String typeId;
	private java.lang.String platformId;
	private java.lang.String clientIp;
	private java.lang.String deviceId;
	private java.util.Date actionTime;
	private java.lang.String resultId;
	private java.lang.String remarks;
	//columns END

	public TuserLoginlog(){
	}

	public TuserLoginlog(
		java.lang.Long loginLogId
	){
		this.loginLogId = loginLogId;
	}

	public void setLoginLogId(java.lang.Long value) {
		this.loginLogId = value;
	}
	
	public java.lang.Long getLoginLogId() {
		return this.loginLogId;
	}
	public void setUserId(java.lang.Long value) {
		this.userId = value;
	}
	
	public java.lang.Long getUserId() {
		return this.userId;
	}
	public void setTypeId(java.lang.String value) {
		this.typeId = value;
	}
	
	public java.lang.String getTypeId() {
		return this.typeId;
	}
	public void setPlatformId(java.lang.String value) {
		this.platformId = value;
	}
	
	public java.lang.String getPlatformId() {
		return this.platformId;
	}
	public void setClientIp(java.lang.String value) {
		this.clientIp = value;
	}
	
	public java.lang.String getClientIp() {
		return this.clientIp;
	}
	public void setDeviceId(java.lang.String value) {
		this.deviceId = value;
	}
	
	public java.lang.String getDeviceId() {
		return this.deviceId;
	}
	public void setActionTime(java.util.Date value) {
		this.actionTime = value;
	}
	
	public java.util.Date getActionTime() {
		return this.actionTime;
	}
	public void setResultId(java.lang.String value) {
		this.resultId = value;
	}
	
	public java.lang.String getResultId() {
		return this.resultId;
	}
	public void setRemarks(java.lang.String value) {
		this.remarks = value;
	}
	
	public java.lang.String getRemarks() {
		return this.remarks;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("LoginLogId",getLoginLogId())
			.append("UserId",getUserId())
			.append("TypeId",getTypeId())
			.append("PlatformId",getPlatformId())
			.append("ClientIp",getClientIp())
			.append("DeviceId",getDeviceId())
			.append("ActionTime",getActionTime())
			.append("ResultId",getResultId())
			.append("Remarks",getRemarks())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getLoginLogId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TuserLoginlog == false) return false;
		if(this == obj) return true;
		TuserLoginlog other = (TuserLoginlog)obj;
		return new EqualsBuilder()
			.append(getLoginLogId(),other.getLoginLogId())
			.isEquals();
	}
}

