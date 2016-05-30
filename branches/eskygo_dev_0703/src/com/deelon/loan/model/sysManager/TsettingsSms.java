package com.deelon.loan.model.sysManager;




import java.util.HashSet;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TsettingsSms extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TsettingsSms";
	public static final String ALIAS_SMSID = "短信设置ID";
	public static final String ALIAS_IS_OPEN = "是否开启";
	public static final String ALIAS_ACCOUNT = "账号";
	public static final String ALIAS_SUB_ACCOUNT = "子账号";
	public static final String ALIAS_PWD = "密码";
	public static final String ALIAS_INTERFACE_URL = "短信接口地址";
	public static final String ALIAS_UPATED = "更新人";
	public static final String ALIAS_UPATE_TIME = "更新时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long smsid;
	private Integer isOpen;
	private java.lang.String account;
	private java.lang.String subAccount;
	private java.lang.String pwd;
	private java.lang.String interfaceUrl;
	private java.lang.Long upated;
	private java.util.Date upateTime;
	//columns END

	public TsettingsSms(){
	}

	public TsettingsSms(
		java.lang.Long smsid
	){
		this.smsid = smsid;
	}

	public void setSmsid(java.lang.Long value) {
		this.smsid = value;
	}
	
	public java.lang.Long getSmsid() {
		return this.smsid;
	}
	public void setIsOpen(Integer value) {
		this.isOpen = value;
	}
	
	public Integer getIsOpen() {
		return this.isOpen;
	}
	public void setAccount(java.lang.String value) {
		this.account = value;
	}
	
	public java.lang.String getAccount() {
		return this.account;
	}
	public void setSubAccount(java.lang.String value) {
		this.subAccount = value;
	}
	
	public java.lang.String getSubAccount() {
		return this.subAccount;
	}
	public void setPwd(java.lang.String value) {
		this.pwd = value;
	}
	
	public java.lang.String getPwd() {
		return this.pwd;
	}
	public void setInterfaceUrl(java.lang.String value) {
		this.interfaceUrl = value;
	}
	
	public java.lang.String getInterfaceUrl() {
		return this.interfaceUrl;
	}
	public void setUpated(java.lang.Long value) {
		this.upated = value;
	}
	
	public java.lang.Long getUpated() {
		return this.upated;
	}
	public void setUpateTime(java.util.Date value) {
		this.upateTime = value;
	}
	
	public java.util.Date getUpateTime() {
		return this.upateTime;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("Smsid",getSmsid())
			.append("IsOpen",getIsOpen())
			.append("Account",getAccount())
			.append("SubAccount",getSubAccount())
			.append("Pwd",getPwd())
			.append("InterfaceUrl",getInterfaceUrl())
			.append("Upated",getUpated())
			.append("UpateTime",getUpateTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getSmsid())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TsettingsSms == false) return false;
		if(this == obj) return true;
		TsettingsSms other = (TsettingsSms)obj;
		return new EqualsBuilder()
			.append(getSmsid(),other.getSmsid())
			.isEquals();
	}
}

