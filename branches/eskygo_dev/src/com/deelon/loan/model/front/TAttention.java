package com.deelon.loan.model.front;


import java.util.Date;

import com.deelon.core.model.BaseModel;

/**
 * TProject entity. @author MyEclipse Persistence Tools
 */

public class TAttention extends BaseModel implements java.io.Serializable {
	//alias
	public static final String TABLE_ALIAS = "Tattention";
	public static final String ALIAS_ATTENTION_ID = "关注记录ID";
	public static final String ALIAS_TYPE_ID = "类别：1关注2收藏";
	public static final String ALIAS_USER_ID = "用户ID";
	public static final String ALIAS_PROJECT_ID = "被关注项目ID";
	public static final String ALIAS_BE_USER_ID = "被关注用户ID";
	public static final String ALIAS_CREATE_TIME = "关注时间";
	public static final String ALIAS_IS_DEL = "取消关注";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long attentionId;
	private java.lang.String typeId;
	private java.lang.Long userId;
	private java.lang.Long projectId;
	private java.lang.Long beUserId;
	private java.util.Date createTime;
	private Integer isDel;
	//columns END

	public TAttention(){
	}

	public TAttention(
		java.lang.Long attentionId
	){
		this.attentionId = attentionId;
	}

	public void setAttentionId(java.lang.Long value) {
		this.attentionId = value;
	}
	
	public java.lang.Long getAttentionId() {
		return this.attentionId;
	}
	public void setTypeId(java.lang.String value) {
		this.typeId = value;
	}
	
	public java.lang.String getTypeId() {
		return this.typeId;
	}
	public void setUserId(java.lang.Long value) {
		this.userId = value;
	}
	
	public java.lang.Long getUserId() {
		return this.userId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setBeUserId(java.lang.Long value) {
		this.beUserId = value;
	}
	
	public java.lang.Long getBeUserId() {
		return this.beUserId;
	}
	public void setCreateTime(java.util.Date value) {
		this.createTime = value;
	}
	
	public java.util.Date getCreateTime() {
		return this.createTime;
	}
	public void setIsDel(Integer value) {
		this.isDel = value;
	}
	
	public Integer getIsDel() {
		return this.isDel;
	}

	

}