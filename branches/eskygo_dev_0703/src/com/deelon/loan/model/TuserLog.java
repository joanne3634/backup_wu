/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.model;
import java.util.HashSet;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TuserLog extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TuserLog";
	public static final String ALIAS_LOGIN_LOG_ID = "日志ID";
	public static final String ALIAS_USER_ID = "会员ID";
	public static final String ALIAS_TYPE_ID = "日志类型：1登录,2退出,3操作";
	public static final String ALIAS_MODEL_ID = "模块ID";
	public static final String ALIAS_MODEL_NAME = "模块名称";
	public static final String ALIAS_ACTION_NAME = "操作名称";
	public static final String ALIAS_ACTION_TIME = "发生时间";
	public static final String ALIAS_PLATFORM_ID = "平台：1电脑,2手机";
	public static final String ALIAS_CLIENT_IPDEVICE_ID = "客户IP/客户设备ID(手机)";
	public static final String ALIAS_RESULT_ID = "结果ID：1成功 2失败";
	public static final String ALIAS_REMARKS = "操作描述";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long loginLogId;
	private java.lang.Long userId;
	private java.lang.Integer typeId;
	private java.lang.String modelId;
	private java.lang.String modelName;
	private java.lang.String actionName;
	private java.util.Date actionTime;
	private java.lang.String platformId;
	private java.lang.String clientIpdeviceId;
	private java.lang.String resultId;
	private java.lang.String remarks;
	private String loginName;
	
	//columns END

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public TuserLog(){
	}

	public TuserLog(
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
	public void setTypeId(java.lang.Integer value) {
		this.typeId = value;
	}
	
	public java.lang.Integer getTypeId() {
		return this.typeId;
	}
	public void setModelId(java.lang.String value) {
		this.modelId = value;
	}
	
	public java.lang.String getModelId() {
		return this.modelId;
	}
	public void setModelName(java.lang.String value) {
		this.modelName = value;
	}
	
	public java.lang.String getModelName() {
		return this.modelName;
	}
	public void setActionName(java.lang.String value) {
		this.actionName = value;
	}
	
	public java.lang.String getActionName() {
		return this.actionName;
	}
	public void setActionTime(java.util.Date value) {
		this.actionTime = value;
	}
	
	public java.util.Date getActionTime() {
		return this.actionTime;
	}
	public void setPlatformId(java.lang.String value) {
		this.platformId = value;
	}
	
	public java.lang.String getPlatformId() {
		return this.platformId;
	}
	public void setClientIpdeviceId(java.lang.String value) {
		this.clientIpdeviceId = value;
	}
	
	public java.lang.String getClientIpdeviceId() {
		return this.clientIpdeviceId;
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
			.append("ModelId",getModelId())
			.append("ModelName",getModelName())
			.append("ActionName",getActionName())
			.append("ActionTime",getActionTime())
			.append("PlatformId",getPlatformId())
			.append("ClientIpdeviceId",getClientIpdeviceId())
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
		if(obj instanceof TuserLog == false) return false;
		if(this == obj) return true;
		TuserLog other = (TuserLog)obj;
		return new EqualsBuilder()
			.append(getLoginLogId(),other.getLoginLogId())
			.isEquals();
	}
}

