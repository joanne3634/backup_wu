package com.deelon.loan.model.front;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TuserTaskcomplete extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TuserTaskcomplete";
	public static final String ALIAS_TASK_COMPLETE_ID = "完成任务ID";
	public static final String ALIAS_USER_ID = "用户ID";
	public static final String ALIAS_TASK_ID = "任务ID";
	public static final String ALIAS_CREDIT_ADD = "增加信用度";
	public static final String ALIAS_IS_COMPLETE = "是否完成";
	public static final String ALIAS_COMPLETE_TIME = "完成时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Integer taskCompleteId;
	private java.lang.Long userId;
	private java.lang.Integer taskId;
	private java.lang.Integer creditAdd;
	private Integer isComplete;
	private java.util.Date completeTime;
	//columns END

	public TuserTaskcomplete(){
	}

	public TuserTaskcomplete(
		java.lang.Integer taskCompleteId
	){
		this.taskCompleteId = taskCompleteId;
	}

	public void setTaskCompleteId(java.lang.Integer value) {
		this.taskCompleteId = value;
	}
	
	public java.lang.Integer getTaskCompleteId() {
		return this.taskCompleteId;
	}
	public void setUserId(java.lang.Long value) {
		this.userId = value;
	}
	
	public java.lang.Long getUserId() {
		return this.userId;
	}
	public void setTaskId(java.lang.Integer value) {
		this.taskId = value;
	}
	
	public java.lang.Integer getTaskId() {
		return this.taskId;
	}
	public void setCreditAdd(java.lang.Integer value) {
		this.creditAdd = value;
	}
	
	public java.lang.Integer getCreditAdd() {
		return this.creditAdd;
	}
	public void setIsComplete(Integer value) {
		this.isComplete = value;
	}
	
	public Integer getIsComplete() {
		return this.isComplete;
	}
	public void setCompleteTime(java.util.Date value) {
		this.completeTime = value;
	}
	
	public java.util.Date getCompleteTime() {
		return this.completeTime;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("TaskCompleteId",getTaskCompleteId())
			.append("UserId",getUserId())
			.append("TaskId",getTaskId())
			.append("CreditAdd",getCreditAdd())
			.append("IsComplete",getIsComplete())
			.append("CompleteTime",getCompleteTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getTaskCompleteId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TuserTaskcomplete == false) return false;
		if(this == obj) return true;
		TuserTaskcomplete other = (TuserTaskcomplete)obj;
		return new EqualsBuilder()
			.append(getTaskCompleteId(),other.getTaskCompleteId())
			.isEquals();
	}
}

