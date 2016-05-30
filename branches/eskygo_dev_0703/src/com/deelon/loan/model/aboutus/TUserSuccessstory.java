package com.deelon.loan.model.aboutus;

import java.sql.Timestamp;

public class TUserSuccessstory {
	private int successstoryId;//主键
	private int userId;       //会员ID
	private String subject; //标题
	private String shareContent;//分享内容
	private Long creator;//创建人
	private java.util.Date createTime;//创建时间
	
	private String groupId;
	
	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public TUserSuccessstory() {
	}
	
	public TUserSuccessstory(int successstoryId,int userId,String subject,String 
			shareContent,Long creator,Timestamp createTime,String groupId) {
		super();
		this.successstoryId = successstoryId;
		this.userId = userId;
		this.subject = subject;
		this.shareContent = shareContent;
		this.creator = creator;
		this.createTime = createTime;
		this.groupId = groupId;
	}

	public int getSuccessstoryId() {
		return successstoryId;
	}

	public void setSuccessstoryId(int successstoryId) {
		this.successstoryId = successstoryId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getShareContent() {
		return shareContent;
	}

	public void setShareContent(String shareContent) {
		this.shareContent = shareContent;
	}

	public Long getCreator() {
		return creator;
	}

	public void setCreator(Long creator) {
		this.creator = creator;
	}

	public java.util.Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(java.util.Date createTime) {
		this.createTime = createTime;
	}

 
}