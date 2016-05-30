/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.model.sysManager;
import java.util.HashSet;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Tinfotemplat extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "Tinfotemplat";
	public static final String ALIAS_INFO_TEMPLATE_ID = "模板ID";
	public static final String ALIAS_TEMPLATE_NAME = "模板名称";
	public static final String ALIAS_SERVICE_TYPE = "通知类型（1=网站、2=系统、3=APP）";
	public static final String ALIAS_INFO_TYPE = "通知方式：1=SMS，2=EMAIL，3=WEB";
	public static final String ALIAS_INFO_FLAG = "通知对象：";
	public static final String ALIAS_HEADER = "标题：对Web和Email有效";
	public static final String ALIAS_MESSASGE = "消息内容";
	public static final String ALIAS_CREATOR = "创建用户";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long infoTemplateId;
	private java.lang.String templateName;
	private java.lang.Integer serviceType;
	private java.lang.Integer infoType;
	private java.lang.String infoFlag;
	private java.lang.String header;
	private java.lang.String messasge;
	private java.lang.Long creator;
	private java.util.Date createTime;
	//columns END

	public Tinfotemplat(){
	}

	public Tinfotemplat(
		java.lang.Long infoTemplateId
	){
		this.infoTemplateId = infoTemplateId;
	}

	public void setInfoTemplateId(java.lang.Long value) {
		this.infoTemplateId = value;
	}
	
	public java.lang.Long getInfoTemplateId() {
		return this.infoTemplateId;
	}
	public void setTemplateName(java.lang.String value) {
		this.templateName = value;
	}
	
	public java.lang.String getTemplateName() {
		return this.templateName;
	}
	public void setServiceType(java.lang.Integer value) {
		this.serviceType = value;
	}
	
	public java.lang.Integer getServiceType() {
		return this.serviceType;
	}
	public void setInfoType(java.lang.Integer value) {
		this.infoType = value;
	}
	
	public java.lang.Integer getInfoType() {
		return this.infoType;
	}
	public void setInfoFlag(java.lang.String value) {
		this.infoFlag = value;
	}
	
	public java.lang.String getInfoFlag() {
		return this.infoFlag;
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
			.append("InfoTemplateId",getInfoTemplateId())
			.append("TemplateName",getTemplateName())
			.append("ServiceType",getServiceType())
			.append("InfoType",getInfoType())
			.append("InfoFlag",getInfoFlag())
			.append("Header",getHeader())
			.append("Messasge",getMessasge())
			.append("Creator",getCreator())
			.append("CreateTime",getCreateTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getInfoTemplateId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof Tinfotemplat == false) return false;
		if(this == obj) return true;
		Tinfotemplat other = (Tinfotemplat)obj;
		return new EqualsBuilder()
			.append(getInfoTemplateId(),other.getInfoTemplateId())
			.isEquals();
	}
}

