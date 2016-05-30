/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.model.backstage;
import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;

public class TcprojectTeam extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TcprojectTeam";
	public static final String ALIAS_TEAM_ID = "团队ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_PTTYPE_ID = "类型：1股东团队成员 2 非股东团队成员";
	public static final String ALIAS_PTNAME = "姓名";
	public static final String ALIAS_PTDUTY = "职务";
	public static final String ALIAS_PTMIS_FULL_TIME = "是否全职";
	public static final String ALIAS_PTTHE_SHARE = "所占股份(%）";
	public static final String ALIAS_PTREAL_PAY = "实际出租金额 (万元)";
	public static final String ALIAS_PTRELATIONSHIP = "关系描述";
	public static final String ALIAS_PTMEMBER_INFO = "成员简介";
	public static final String ALIAS_PTORDER_ID = "排序";
	public static final String ALIAS_IS_DEL = "是否删除";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long teamId;
	private java.lang.Long projectId;
	private Integer pttypeId;
	private java.lang.String ptname;
	private java.lang.String ptduty;
	private Integer ptmisFullTime;
	private int pttheShare;
	private String ptrealPay;
	private java.lang.String ptrelationship;
	private java.lang.String ptmemberInfo;
	private java.lang.Integer ptorderId;
	private Integer isDel;
	private String ptentryTime;
	private String ptentryTimeStr;
	//columns END

	public TcprojectTeam(){
	}

	public TcprojectTeam(
		java.lang.Long teamId
	){
		this.teamId = teamId;
	}

	public void setTeamId(java.lang.Long value) {
		this.teamId = value;
	}
	
	public java.lang.Long getTeamId() {
		return this.teamId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setPttypeId(Integer value) {
		this.pttypeId = value;
	}
	
	public Integer getPttypeId() {
		return this.pttypeId;
	}
	public void setPtname(java.lang.String value) {
		this.ptname = value;
	}
	
	public java.lang.String getPtname() {
		return this.ptname;
	}
	public void setPtduty(java.lang.String value) {
		this.ptduty = value;
	}
	
	public java.lang.String getPtduty() {
		return this.ptduty;
	}
	public void setPtmisFullTime(Integer value) {
		this.ptmisFullTime = value;
	}
	
	public Integer getPtmisFullTime() {
		return this.ptmisFullTime;
	}
	public void setPttheShare(int value) {
		this.pttheShare = value;
	}
	
	public int getPttheShare() {
		return this.pttheShare;
	}
	public void setPtrealPay(String value) {
		this.ptrealPay = value;
	}
	
	public String getPtrealPay() {
		return this.ptrealPay;
	}
	public void setPtrelationship(java.lang.String value) {
		this.ptrelationship = value;
	}
	
	public java.lang.String getPtrelationship() {
		return this.ptrelationship;
	}
	public void setPtmemberInfo(java.lang.String value) {
		this.ptmemberInfo = value;
	}
	
	public java.lang.String getPtmemberInfo() {
		return this.ptmemberInfo;
	}
	public void setPtorderId(java.lang.Integer value) {
		this.ptorderId = value;
	}
	
	public java.lang.Integer getPtorderId() {
		return this.ptorderId;
	}
	public void setIsDel(Integer value) {
		this.isDel = value;
	}
	
	public Integer getIsDel() {
		return this.isDel;
	}
	
	

	public String getPtentryTime() {
		return ptentryTime;
	}

	public void setPtentryTime(String ptentryTime) {
		this.ptentryTime = ptentryTime;
	}

	public String getPtentryTimeStr() {
		return ptentryTimeStr;
	}

	public void setPtentryTimeStr(String ptentryTimeStr) {
		this.ptentryTimeStr = ptentryTimeStr;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("TeamId",getTeamId())
			.append("ProjectId",getProjectId())
			.append("PttypeId",getPttypeId())
			.append("Ptname",getPtname())
			.append("Ptduty",getPtduty())
			.append("PtmisFullTime",getPtmisFullTime())
			.append("PttheShare",getPttheShare())
			.append("PtrealPay",getPtrealPay())
			.append("Ptrelationship",getPtrelationship())
			.append("PtmemberInfo",getPtmemberInfo())
			.append("PtorderId",getPtorderId())
			.append("IsDel",getIsDel())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getTeamId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectTeam == false) return false;
		if(this == obj) return true;
		TcprojectTeam other = (TcprojectTeam)obj;
		return new EqualsBuilder()
			.append(getTeamId(),other.getTeamId())
			.isEquals();
	}
}

