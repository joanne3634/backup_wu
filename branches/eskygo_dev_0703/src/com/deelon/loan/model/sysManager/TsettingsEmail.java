package com.deelon.loan.model.sysManager;

import java.util.HashSet;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TsettingsEmail extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TsettingsEmail";
	public static final String ALIAS_EMAIL_ID = "emailId";
	public static final String ALIAS_SMTP_SER = "SMTP服务器";
	public static final String ALIAS_PORT_ID = "端口ID";
	public static final String ALIAS_EMAIL = "邮箱";
	public static final String ALIAS_PWD = "密码";
	public static final String ALIAS_SENDER_NAME = "发送人";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long emailId;
	private java.lang.String smtpSer;
	private java.lang.String portId;
	private java.lang.String email;
	private java.lang.String pwd;
	private java.lang.String senderName;
	//columns END

	public TsettingsEmail(){
	}

	public TsettingsEmail(
		java.lang.Long emailId
	){
		this.emailId = emailId;
	}

	public void setEmailId(java.lang.Long value) {
		this.emailId = value;
	}
	
	public java.lang.Long getEmailId() {
		return this.emailId;
	}
	public void setSmtpSer(java.lang.String value) {
		this.smtpSer = value;
	}
	
	public java.lang.String getSmtpSer() {
		return this.smtpSer;
	}
	public void setPortId(java.lang.String value) {
		this.portId = value;
	}
	
	public java.lang.String getPortId() {
		return this.portId;
	}
	public void setEmail(java.lang.String value) {
		this.email = value;
	}
	
	public java.lang.String getEmail() {
		return this.email;
	}
	public void setPwd(java.lang.String value) {
		this.pwd = value;
	}
	
	public java.lang.String getPwd() {
		return this.pwd;
	}
	public void setSenderName(java.lang.String value) {
		this.senderName = value;
	}
	
	public java.lang.String getSenderName() {
		return this.senderName;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("EmailId",getEmailId())
			.append("SmtpSer",getSmtpSer())
			.append("PortId",getPortId())
			.append("Email",getEmail())
			.append("Pwd",getPwd())
			.append("SenderName",getSenderName())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getEmailId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TsettingsEmail == false) return false;
		if(this == obj) return true;
		TsettingsEmail other = (TsettingsEmail)obj;
		return new EqualsBuilder()
			.append(getEmailId(),other.getEmailId())
			.isEquals();
	}
}

