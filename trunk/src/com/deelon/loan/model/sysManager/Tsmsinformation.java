package com.deelon.loan.model.sysManager;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.deelon.core.model.BaseModel;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Tsmsinformation extends BaseModel {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 116087109258156870L;
	//alias
	public static final String TABLE_ALIAS = "Tsmsinformation";
	public static final String ALIAS_INFO_ID = "消息ID";
	public static final String ALIAS_SERVICE_TYPE = "通知类型（1=网站、2=系统、3=APP）";
	public static final String ALIAS_MOBILE_NUM = "手机号码";
	public static final String ALIAS_MESSASGE = "短信内容";
	public static final String ALIAS_STATUS = "通知状态：0=成功，1=失败";
	public static final String ALIAS_CREATOR = "创建人ID";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	
	private java.lang.Long infoId;
	private java.lang.Integer serviceType;
	private java.lang.String mobileNum;
	private java.lang.String messasge;
	private java.lang.Integer status;
	private java.lang.Long creator;
	private java.util.Date createTime;
	private java.util.Date sendTime;
	//columns END





	public Tsmsinformation(){
	}

	
	




	public Tsmsinformation(Long infoId, Integer serviceType, String mobileNum,
			String messasge, Integer status, Long creator, Date createTime,
			Date sendTime) {
		super();
		this.infoId = infoId;
		this.serviceType = serviceType;
		this.mobileNum = mobileNum;
		this.messasge = messasge;
		this.status = status;
		this.creator = creator;
		this.createTime = createTime;
		this.sendTime = sendTime;
	}







	public Tsmsinformation(
		java.lang.Long infoId
	)
	
	{
		this.infoId = infoId;
	}

	public void setInfoId(java.lang.Long value) {
		this.infoId = value;
	}
	
	public java.lang.Long getInfoId() {
		return this.infoId;
	}
	public void setServiceType(java.lang.Integer value) {
		this.serviceType = value;
	}
	
	public java.lang.Integer getServiceType() {
		return this.serviceType;
	}
	public void setMobileNum(java.lang.String value) {
		this.mobileNum = value;
	}
	
	public java.lang.String getMobileNum() {
		return this.mobileNum;
	}
	public void setMessasge(java.lang.String value) {
		this.messasge = value;
	}
	
	public java.lang.String getMessasge() {
		return this.messasge;
	}
	public void setStatus(java.lang.Integer value) {
		this.status = value;
	}
	
	public java.lang.Integer getStatus() {
		return this.status;
	}
	public void setCreator(java.lang.Long value) {
		this.creator = value;
	}
	
	public java.lang.Long getCreator() {
		return this.creator;
	}
	public void setCreateTime(java.util.Date value) {
		this.createTime = value;
	}
	
	public java.util.Date getCreateTime() {
		return this.createTime;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("InfoId",getInfoId())
			.append("ServiceType",getServiceType())
			.append("MobileNum",getMobileNum())
			.append("Messasge",getMessasge())
			.append("Status",getStatus())
			.append("Creator",getCreator())
			.append("CreateTime",getCreateTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getInfoId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof Tsmsinformation == false) return false;
		if(this == obj) return true;
		Tsmsinformation other = (Tsmsinformation)obj;
		return new EqualsBuilder()
			.append(getInfoId(),other.getInfoId())
			.isEquals();
	}
	
	public java.util.Date getSendTime() {
		return sendTime;
	}



	public void setSendTime(java.util.Date sendTime) {
		this.sendTime = sendTime;
	}
}

