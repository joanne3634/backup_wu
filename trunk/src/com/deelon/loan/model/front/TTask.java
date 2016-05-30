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

public class TTask extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "Ttask";
	public static final String ALIAS_TASK_ID = "浠诲姟ID";
	public static final String ALIAS_GROUP_ID = "鐢ㄦ埛缁�";
	public static final String ALIAS_TASK_DESC = "浠诲姟鎻忚堪";
	public static final String ALIAS_IMG_SRC = "鍥剧墖";
	public static final String ALIAS_CREDIT_ADD = "瀹屾垚浠诲姟澧炲姞淇＄敤搴�";
	public static final String ALIAS_LINK_URL = "閾炬帴鍒伴〉闈�";
	public static final String ALIAS_TARGET_TYPE = "閾炬帴绫诲瀷";
	 
	//鍙互鐩存帴浣跨敤: @Length(max=50,message="鐢ㄦ埛鍚嶉暱搴︿笉鑳藉ぇ浜�0")鏄剧ず閿欒娑堟伅
	//columns START
	private java.lang.Integer taskId;
	private java.lang.String groupId;
	private java.lang.String taskDesc;
	private java.lang.String imgSrc;
	private java.lang.Integer creditAdd;
	private java.lang.String linkUrl;
	private java.lang.String targetType;
	//columns END
	
	//非持久数据
	private int isComplete;

	public int getIsComplete() {
		return isComplete;
	}

	public void setIsComplete(int isComplete) {
		this.isComplete = isComplete;
	}

	public TTask(){
	}

	public TTask(
		java.lang.Integer taskId
	){
		this.taskId = taskId;
	}

	public void setTaskId(java.lang.Integer value) {
		this.taskId = value;
	}
	
	public java.lang.Integer getTaskId() {
		return this.taskId;
	}
	public void setGroupId(java.lang.String value) {
		this.groupId = value;
	}
	
	public java.lang.String getGroupId() {
		return this.groupId;
	}
	public void setTaskDesc(java.lang.String value) {
		this.taskDesc = value;
	}
	
	public java.lang.String getTaskDesc() {
		return this.taskDesc;
	}
	public void setImgSrc(java.lang.String value) {
		this.imgSrc = value;
	}
	
	public java.lang.String getImgSrc() {
		return this.imgSrc;
	}
	public void setCreditAdd(java.lang.Integer value) {
		this.creditAdd = value;
	}
	
	public java.lang.Integer getCreditAdd() {
		return this.creditAdd;
	}
	public void setLinkUrl(java.lang.String value) {
		this.linkUrl = value;
	}
	
	public java.lang.String getLinkUrl() {
		return this.linkUrl;
	}
	public void setTargetType(java.lang.String value) {
		this.targetType = value;
	}
	
	public java.lang.String getTargetType() {
		return this.targetType;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("TaskId",getTaskId())
			.append("GroupId",getGroupId())
			.append("TaskDesc",getTaskDesc())
			.append("ImgSrc",getImgSrc())
			.append("CreditAdd",getCreditAdd())
			.append("LinkUrl",getLinkUrl())
			.append("TargetType",getTargetType())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getTaskId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TTask == false) return false;
		if(this == obj) return true;
		TTask other = (TTask)obj;
		return new EqualsBuilder()
			.append(getTaskId(),other.getTaskId())
			.isEquals();
	}
}

