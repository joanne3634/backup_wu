/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.model.backstage;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;

public class TcprojectComments extends BaseModel {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5257753849177086310L;
	//alias
	public static final String TABLE_ALIAS = "TcprojectComments";
	public static final String ALIAS_COMMENTS_ID = "讨论ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_PCCONTENT = "讨论内容";
	public static final String ALIAS_PCREPLY = "回复人";
	public static final String ALIAS_PCREPLY_CONTENT = "回复内容";
	public static final String ALIAS_PCREPLY_TIME = "回复时间";
	public static final String ALIAS_CREATOR = "留言人";
	public static final String ALIAS_CRETE_TIME = "留言时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long commentsId;
	private java.lang.Long projectId;
	private int pctypeID;
	private Long pcparentD;
	private java.lang.String pccontent;
	private java.lang.Long creator;
	private java.util.Date creteTime;
	
	private List<TcprojectComments> listProComments;
	//非持久化
	private String pcReqplyname;
	private String creatorName;
	private String pname;
	private String creatorLoginName;
	private String loginName;
	
	private String writeBackContents;//回复内容
	private Date writeBackDate;//回复日期
	private String writeBackCreator;//回复人
	
	private String creteTimeStr;
	private String writeBackDateStr;//回复日期
	
	private Integer count;
	//columns END

	public TcprojectComments(){
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public TcprojectComments(
		java.lang.Long commentsId
	){
		this.commentsId = commentsId;
	}

	public void setCommentsId(java.lang.Long value) {
		this.commentsId = value;
	}
	
	public java.lang.Long getCommentsId() {
		return this.commentsId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setPccontent(java.lang.String value) {
		this.pccontent = value;
	}
	
	public java.lang.String getPccontent() {
		return this.pccontent;
	}
	
	public void setCreator(java.lang.Long value) {
		this.creator = value;
	}
	
	public java.lang.Long getCreator() {
		return this.creator;
	}
	public void setCreteTime(java.util.Date value) {
		this.creteTime = value;
	}
	
	public java.util.Date getCreteTime() {
		return this.creteTime;
	}
	
	

	public String getPcReqplyname() {
		return pcReqplyname;
	}

	public void setPcReqplyname(String pcReqplyname) {
		this.pcReqplyname = pcReqplyname;
	}

	public String getCreatorName() {
		return creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
	
	

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}
	
	

	public List<TcprojectComments> getListProComments() {
		return listProComments;
	}

	public void setListProComments(List<TcprojectComments> listProComments) {
		this.listProComments = listProComments;
	}
	
	

	public String getCreatorLoginName() {
		return creatorLoginName;
	}

	public void setCreatorLoginName(String creatorLoginName) {
		this.creatorLoginName = creatorLoginName;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getWriteBackContents() {
		return writeBackContents;
	}

	public void setWriteBackContents(String writeBackContents) {
		this.writeBackContents = writeBackContents;
	}

	public Date getWriteBackDate() {
		return writeBackDate;
	}

	public void setWriteBackDate(Date writeBackDate) {
		this.writeBackDate = writeBackDate;
	}

	public String getWriteBackCreator() {
		return writeBackCreator;
	}

	public void setWriteBackCreator(String writeBackCreator) {
		this.writeBackCreator = writeBackCreator;
	}
	
	

	public int getPctypeID() {
		return pctypeID;
	}

	public void setPctypeID(int pctypeID) {
		this.pctypeID = pctypeID;
	}

	

	public Long getPcparentD() {
		return pcparentD;
	}

	public void setPcparentD(Long pcparentD) {
		this.pcparentD = pcparentD;
	}

	public String getCreteTimeStr() {
		return creteTimeStr;
	}

	public void setCreteTimeStr(String creteTimeStr) {
		this.creteTimeStr = creteTimeStr;
	}

	public String getWriteBackDateStr() {
		return writeBackDateStr;
	}

	public void setWriteBackDateStr(String writeBackDateStr) {
		this.writeBackDateStr = writeBackDateStr;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("CommentsId",getCommentsId())
			.append("ProjectId",getProjectId())
			.append("Pccontent",getPccontent())
		
			.append("Creator",getCreator())
			.append("CreteTime",getCreteTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getCommentsId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectComments == false) return false;
		if(this == obj) return true;
		TcprojectComments other = (TcprojectComments)obj;
		return new EqualsBuilder()
			.append(getCommentsId(),other.getCommentsId())
			.isEquals();
	}
}

