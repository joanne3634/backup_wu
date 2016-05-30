package com.deelon.loan.model.sysManager;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.deelon.core.model.BaseModel;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Temailinformation extends BaseModel {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1762640137678482111L;
	//alias
	public static final String TABLE_ALIAS = "Temailinformation";
	public static final String ALIAS_INFO_ID = "消息ID";
	public static final String ALIAS_SERVICE_TYPE = "通知类型（1=网站、2=系统、3=APP）";
	public static final String ALIAS_EMAIL_ADDR = "EMAIL通知邮件地址";
	public static final String ALIAS_HEADER = "消息标题";
	public static final String ALIAS_MESSASGE = "短信内容";
	public static final String ALIAS_STATUS = "通知状态：0=成功，1=失败";
	public static final String ALIAS_CREATOR = "创建人ID";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long infoId;
	private java.lang.Integer serviceType;
	private java.lang.String emailAddr;
	private java.lang.String header;
	private java.lang.String messasge;
	private java.lang.Integer status;
	private java.lang.Long creator;
	private java.util.Date createTime;
	//columns END
	
	private Timestamp beginDate;
	private Timestamp endDate;

	public Timestamp getBeginDate() {
		return beginDate;
	}



	public void setBeginDate(Timestamp beginDate) {
		this.beginDate = beginDate;
	}



	public Timestamp getEndDate() {
		return endDate;
	}



	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}



	public Temailinformation(){
	}

	
	
	public Temailinformation(Integer serviceType, String emailAddr,
			String header, String messasge, Integer status, Long creator,
			Date createTime) {
		super();
		this.serviceType = serviceType;
		this.emailAddr = emailAddr;
		this.header = header;
		this.messasge = messasge;
		this.status = status;
		this.creator = creator;
		this.createTime = createTime;
	}



	public Temailinformation(
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
	public void setEmailAddr(java.lang.String value) {
		this.emailAddr = value;
	}
	
	public java.lang.String getEmailAddr() {
		return this.emailAddr;
	}
	public void setHeader(java.lang.String value) {
		this.header = value;
	}
	
	public java.lang.String getHeader() {
		return this.header;
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
			.append("EmailAddr",getEmailAddr())
			.append("Header",getHeader())
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
		if(obj instanceof Temailinformation == false) return false;
		if(this == obj) return true;
		Temailinformation other = (Temailinformation)obj;
		return new EqualsBuilder()
			.append(getInfoId(),other.getInfoId())
			.isEquals();
	}
}

