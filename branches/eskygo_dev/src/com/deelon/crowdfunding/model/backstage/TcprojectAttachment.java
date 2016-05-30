/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.model.backstage;
import java.util.HashSet;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TcprojectAttachment extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TcprojectAttachment";
	public static final String ALIAS_ATTACHMENT_ID = "附件ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_PANAME = "标题";
	public static final String ALIAS_PAFILE_NAME = "文件名";
	public static final String ALIAS_PAPATH = "存放路径";
	public static final String ALIAS_CREATOR = "创建人";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long attachmentId;
	private java.lang.Long projectId;
	private java.lang.String paname;
	private java.lang.String pafileName;
	private java.lang.String papath;
	private java.lang.Long creator;
	private java.util.Date createTime;
	//columns END

	public TcprojectAttachment(){
	}

	public TcprojectAttachment(
		java.lang.Long attachmentId
	){
		this.attachmentId = attachmentId;
	}

	public void setAttachmentId(java.lang.Long value) {
		this.attachmentId = value;
	}
	
	public java.lang.Long getAttachmentId() {
		return this.attachmentId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setPaname(java.lang.String value) {
		this.paname = value;
	}
	
	public java.lang.String getPaname() {
		return this.paname;
	}
	public void setPafileName(java.lang.String value) {
		this.pafileName = value;
	}
	
	public java.lang.String getPafileName() {
		return this.pafileName;
	}
	public void setPapath(java.lang.String value) {
		this.papath = value;
	}
	
	public java.lang.String getPapath() {
		return this.papath;
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
			.append("AttachmentId",getAttachmentId())
			.append("ProjectId",getProjectId())
			.append("Paname",getPaname())
			.append("PafileName",getPafileName())
			.append("Papath",getPapath())
			.append("Creator",getCreator())
			.append("CreateTime",getCreateTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getAttachmentId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectAttachment == false) return false;
		if(this == obj) return true;
		TcprojectAttachment other = (TcprojectAttachment)obj;
		return new EqualsBuilder()
			.append(getAttachmentId(),other.getAttachmentId())
			.isEquals();
	}
}

