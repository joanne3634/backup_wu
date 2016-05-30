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

public class TuserReportFollowup extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TuserReportFollowup";
	public static final String ALIAS_FOLLOWUP_ID = "跟进记录ID";
	public static final String ALIAS_REPORT_ID = "举报ID";
	public static final String ALIAS_NOTES = "跟进记录";
	public static final String ALIAS_LINK_WAY = "联系方式";
	public static final String ALIAS_CREATOR = "跟进人";
	public static final String ALIAS_CREATE_TIME = "跟进时间";
	public static final String ALIAS_STATE_ID = "跟进状态";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long followupId;
	private java.lang.Long reportId;
	private java.lang.String notes;
	private java.lang.String linkWay;
	private java.lang.Long creator;
	private java.util.Date createTime;
	private java.lang.Integer stateId;
	//columns END

	public TuserReportFollowup(){
	}

	public TuserReportFollowup(
		java.lang.Long followupId
	){
		this.followupId = followupId;
	}

	public void setFollowupId(java.lang.Long value) {
		this.followupId = value;
	}
	
	public java.lang.Long getFollowupId() {
		return this.followupId;
	}
	public void setReportId(java.lang.Long value) {
		this.reportId = value;
	}
	
	public java.lang.Long getReportId() {
		return this.reportId;
	}
	public void setNotes(java.lang.String value) {
		this.notes = value;
	}
	
	public java.lang.String getNotes() {
		return this.notes;
	}
	public void setLinkWay(java.lang.String value) {
		this.linkWay = value;
	}
	
	public java.lang.String getLinkWay() {
		return this.linkWay;
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

	public java.lang.Integer getStateId() {
		return stateId;
	}

	public void setStateId(java.lang.Integer stateId) {
		this.stateId = stateId;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("FollowupId",getFollowupId())
			.append("ReportId",getReportId())
			.append("Notes",getNotes())
			.append("LinkWay",getLinkWay())
			.append("Creator",getCreator())
			.append("CreateTime",getCreateTime())
			.append("StateID",getStateId())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getFollowupId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TuserReportFollowup == false) return false;
		if(this == obj) return true;
		TuserReportFollowup other = (TuserReportFollowup)obj;
		return new EqualsBuilder()
			.append(getFollowupId(),other.getFollowupId())
			.isEquals();
	} 
}

