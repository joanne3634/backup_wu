/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.model.sysManager;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.deelon.core.model.BaseModel;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Tauditmaterials extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "Tauditmaterials";
	public static final String ALIAS_MATERIALS_ID = "materialsId";
	public static final String ALIAS_TYPE_ID = "材料类型";
	public static final String ALIAS_NAME = "材料名称";
	public static final String ALIAS_DESCRIPTION = "材料说明";
	public static final String ALIAS_IS_MUST = "是否必须的";
	public static final String ALIAS_IS_AUDIT = "是否需要审核";
	public static final String ALIAS_CREDIT_ADD = "审校通过后增加信用";
	public static final String ALIAS_IS_UPLOAD = "是否要上传";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long materialsId;
	private java.lang.String typeId;
	private java.lang.String name;
	private java.lang.String description;
	private Integer isMust;
	private Integer isAudit;
	private java.lang.Integer creditAdd;
	private Integer isUpload;
	private Integer isType;

	//非持久化字段
	private String reasons;
	private int count;
	private Date lastTime;
	private Integer isPass;
	
	private String userId;
	private Date checkDate;
	private String auditDate;
	//columns END

	public Integer getIsType() {
		return isType;
	}

	public void setIsType(Integer isType) {
		this.isType = isType;
	}
	
	public Integer getIsPass() {
		return isPass;
	}

	public void setIsPass(Integer isPass) {
		this.isPass = isPass;
	}

	public String getReasons() {
		return reasons;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Date getLastTime() {
		return lastTime;
	}

	public void setLastTime(Date lastTime) {
		this.lastTime = lastTime;
	}

	public void setReasons(String reasons) {
		this.reasons = reasons;
	}

	public Tauditmaterials(){
	}

	public Tauditmaterials(
		java.lang.Long materialsId
	){
		this.materialsId = materialsId;
	}

	public void setMaterialsId(java.lang.Long value) {
		this.materialsId = value;
	}
	
	public java.lang.Long getMaterialsId() {
		return this.materialsId;
	}
	public void setTypeId(java.lang.String value) {
		this.typeId = value;
	}
	
	public java.lang.String getTypeId() {
		return this.typeId;
	}
	public void setName(java.lang.String value) {
		this.name = value;
	}
	
	public java.lang.String getName() {
		return this.name;
	}
	public void setDescription(java.lang.String value) {
		this.description = value;
	}
	
	public java.lang.String getDescription() {
		return this.description;
	}
	public void setIsMust(Integer value) {
		this.isMust = value;
	}
	
	public Integer getIsMust() {
		return this.isMust;
	}
	public void setIsAudit(Integer value) {
		this.isAudit = value;
	}
	
	public Integer getIsAudit() {
		return this.isAudit;
	}
	public void setCreditAdd(java.lang.Integer value) {
		this.creditAdd = value;
	}
	
	public java.lang.Integer getCreditAdd() {
		return this.creditAdd;
	}
	public void setIsUpload(Integer value) {
		this.isUpload = value;
	}
	
	public Integer getIsUpload() {
		return this.isUpload;
	}
	
	

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	

	public String getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(String auditDate) {
		this.auditDate = auditDate;
	}
	
	

	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("MaterialsId",getMaterialsId())
			.append("TypeId",getTypeId())
			.append("Name",getName())
			.append("Description",getDescription())
			.append("IsMust",getIsMust())
			.append("IsAudit",getIsAudit())
			.append("CreditAdd",getCreditAdd())
			.append("IsUpload",getIsUpload())
			.append("IsType",getIsType())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getMaterialsId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof Tauditmaterials == false) return false;
		if(this == obj) return true;
		Tauditmaterials other = (Tauditmaterials)obj;
		return new EqualsBuilder()
			.append(getMaterialsId(),other.getMaterialsId())
			.isEquals();
	}
}

