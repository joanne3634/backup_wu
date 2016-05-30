/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.model.sysManager;
import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;

public class TuserReport extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TuserReport";
	public static final String ALIAS_REPORT_ID = "举报ID";
	public static final String ALIAS_USER_ID = "被举报用户ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_STATE_ID = "跟进状态 1未处理 2处理中 3已关闭";
	public static final String ALIAS_REPORT_REASON = "举报原因";
	public static final String ALIAS_REMARKS = "备注说明";
	public static final String ALIAS_CREATOR = "举报人";
	public static final String ALIAS_CREATE_TIME = "举报时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long reportId;
	private java.lang.Long userId;
	private java.lang.Long projectId;
	private java.lang.String stateId;
	private java.lang.String reportReason;
	private java.lang.String remarks;
	private java.lang.Long creator;
	private java.util.Date createTime;
	private String createTimes;
	//columns END
	
	//非持久化
	private String proname;
	private String personHands;//举报人
	private String personHands2;//被举报人
	private String linkWay;//处理方式  电话、邮件
	private String notes;//处理记录
	private Date endTimes;//处理时间
	private String endTimesS;//处理时间
	
	public TuserReport(){
	}

	public TuserReport(
		java.lang.Long reportId
	){
		this.reportId = reportId;
	}

	public void setReportId(java.lang.Long value) {
		this.reportId = value;
	}
	
	public java.lang.Long getReportId() {
		return this.reportId;
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
	public void setStateId(java.lang.String value) {
		this.stateId = value;
	}
	
	public java.lang.String getStateId() {
		return this.stateId;
	}
	public void setReportReason(java.lang.String value) {
		this.reportReason = value;
	}
	
	public java.lang.String getReportReason() {
		return this.reportReason;
	}
	public void setRemarks(java.lang.String value) {
		this.remarks = value;
	}
	
	public java.lang.String getRemarks() {
		return this.remarks;
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

	public String getPersonHands() {
		return personHands;
	}

	public void setPersonHands(String personHands) {
		this.personHands = personHands;
	}

	public String getLinkWay() {
		return linkWay;
	}

	public void setLinkWay(String linkWay) {
		this.linkWay = linkWay;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	

	
	public Date getEndTimes() {
		return endTimes;
	}

	public void setEndTimes(Date endTimes) {
		this.endTimes = endTimes;
	}

	

	public String getEndTimesS() {
		return endTimesS;
	}

	public void setEndTimesS(String endTimesS) {
		this.endTimesS = endTimesS;
	}

	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
	}

	
	public String getPersonHands2() {
		return personHands2;
	}

	public void setPersonHands2(String personHands2) {
		this.personHands2 = personHands2;
	}

	
	public String getCreateTimes() {
		return createTimes;
	}

	public void setCreateTimes(String createTimes) {
		this.createTimes = createTimes;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("ReportId",getReportId())
			.append("UserId",getUserId())
			.append("ProjectId",getProjectId())
			.append("StateId",getStateId())
			.append("ReportReason",getReportReason())
			.append("Remarks",getRemarks())
			.append("Creator",getCreator())
			.append("CreateTime",getCreateTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getReportId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TuserReport == false) return false;
		if(this == obj) return true;
		TuserReport other = (TuserReport)obj;
		return new EqualsBuilder()
			.append(getReportId(),other.getReportId())
			.isEquals();
	}
}

