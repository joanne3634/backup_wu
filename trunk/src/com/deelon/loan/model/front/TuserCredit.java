/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.model.front;
import java.util.HashSet;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TuserCredit extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TuserCredit";
	public static final String ALIAS_CREDIT_ID = "信用记录";
	public static final String ALIAS_USER_ID = "用户ID";
	public static final String ALIAS_TYPE_ID = "类型ID";
	public static final String ALIAS_KEY_ID = "相关主键ID";
	public static final String ALIAS_CREDIT_ADD = "增加信用";
	public static final String ALIAS_DESCRIPTION = "描述";
	public static final String ALIAS_CREATE_TIME = "添加时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long creditId;
	private java.lang.Long userId;
	private java.lang.Integer typeId;
	private java.lang.Long keyId;
	private java.lang.Integer creditAdd;
	private java.lang.String description;
	private java.util.Date createTime;
	//columns END

	public TuserCredit(){
	}

	public TuserCredit(
		java.lang.Long creditId
	){
		this.creditId = creditId;
	}

	public void setCreditId(java.lang.Long value) {
		this.creditId = value;
	}
	
	public java.lang.Long getCreditId() {
		return this.creditId;
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
	public void setKeyId(java.lang.Long value) {
		this.keyId = value;
	}
	
	public java.lang.Long getKeyId() {
		return this.keyId;
	}
	public void setCreditAdd(java.lang.Integer value) {
		this.creditAdd = value;
	}
	
	public java.lang.Integer getCreditAdd() {
		return this.creditAdd;
	}
	public void setDescription(java.lang.String value) {
		this.description = value;
	}
	
	public java.lang.String getDescription() {
		return this.description;
	}
	public void setCreateTime(java.util.Date value) {
		this.createTime = value;
	}
	
	public java.util.Date getCreateTime() {
		return this.createTime;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("CreditId",getCreditId())
			.append("UserId",getUserId())
			.append("TypeId",getTypeId())
			.append("KeyId",getKeyId())
			.append("CreditAdd",getCreditAdd())
			.append("Description",getDescription())
			.append("CreateTime",getCreateTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getCreditId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TuserCredit == false) return false;
		if(this == obj) return true;
		TuserCredit other = (TuserCredit)obj;
		return new EqualsBuilder()
			.append(getCreditId(),other.getCreditId())
			.isEquals();
	}
}

