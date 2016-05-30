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

public class Tarea extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "Tarea";
	public static final String ALIAS_AREA_ID = "地区ID";
	public static final String ALIAS_AREA_NAME = "地区名称";
	public static final String ALIAS_HELP_CODE = "dasdas";
	public static final String ALIAS_PARENT_ID = "上级ID";
	public static final String ALIAS_NODE_LEVEL = "层级";
	public static final String ALIAS_ORDER_CODE = "排序";
	public static final String ALIAS_AREA_ZIP = "邮政编码";
	public static final String ALIAS_AREA_CODE = "区号";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long areaId;
	private java.lang.String areaName;
	private java.lang.String helpCode;
	private java.lang.Long parentId;
	private java.lang.Integer nodeLevel;
	private java.lang.String orderCode;
	private java.lang.String areaZip;
	private java.lang.String areaCode;
	private java.lang.Long isRecommended;
	private java.lang.Integer areaNumber;
	//private int isrecommended;
	//columns END

	public Tarea(){
	}

	public Tarea(
		java.lang.Long areaId
	){
		this.areaId = areaId;
	}


	public java.lang.Integer getAreaNumber() {
		return areaNumber;
	}

	public void setAreaNumber(java.lang.Integer areaNumber) {
		this.areaNumber = areaNumber;
	}

	public void setAreaId(java.lang.Long value) {
		this.areaId = value;
	}
	
	public java.lang.Long getAreaId() {
		return this.areaId;
	}
	public void setAreaName(java.lang.String value) {
		this.areaName = value;
	}
	
	public java.lang.String getAreaName() {
		return this.areaName;
	}
	public void setHelpCode(java.lang.String value) {
		this.helpCode = value;
	}
	
	public java.lang.String getHelpCode() {
		return this.helpCode;
	}
	public void setParentId(java.lang.Long value) {
		this.parentId = value;
	}
	
	public java.lang.Long getParentId() {
		return this.parentId;
	}
	public void setNodeLevel(java.lang.Integer value) {
		this.nodeLevel = value;
	}
	
	public java.lang.Integer getNodeLevel() {
		return this.nodeLevel;
	}
	public void setOrderCode(java.lang.String value) {
		this.orderCode = value;
	}
	
	public java.lang.String getOrderCode() {
		return this.orderCode;
	}
	public void setAreaZip(java.lang.String value) {
		this.areaZip = value;
	}
	
	public java.lang.String getAreaZip() {
		return this.areaZip;
	}
	public void setAreaCode(java.lang.String value) {
		this.areaCode = value;
	}
	
	public java.lang.String getAreaCode() {
		return this.areaCode;
	}
	public java.lang.Long getIsRecommended() {
		return isRecommended;
	}

	public void setIsRecommended(java.lang.Long isRecommended) {
		this.isRecommended = isRecommended;
	}
	/*public int getIsrecommended() {
		return isrecommended;
	}

	public void setIsrecommended(int isrecommended) {
		this.isrecommended = isrecommended;
	}*/
	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("AreaId",getAreaId())
			.append("AreaName",getAreaName())
			.append("HelpCode",getHelpCode())
			.append("ParentId",getParentId())
			.append("NodeLevel",getNodeLevel())
			.append("OrderCode",getOrderCode())
			.append("AreaZip",getAreaZip())
			.append("AreaCode",getAreaCode())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getAreaId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof Tarea == false) return false;
		if(this == obj) return true;
		Tarea other = (Tarea)obj;
		return new EqualsBuilder()
			.append(getAreaId(),other.getAreaId())
			.isEquals();
	}
}

