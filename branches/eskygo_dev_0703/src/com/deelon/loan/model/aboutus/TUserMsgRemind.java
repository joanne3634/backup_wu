package com.deelon.loan.model.aboutus;

import java.util.Date;

import com.deelon.core.model.BaseModel;

public class TUserMsgRemind extends BaseModel {
	/**
	 * 需要持久化的字段
	 */
	private Long msgRemindId;	// 消息提醒ID
	private Long projectId;		//项目ID
	private Integer typeId;		//类型：1私信 2约谈信 3收藏项目的投资人 4、向我推荐项目 5系统通知
	private Long senderId;		//发送人ID
	private Date sendTime;		//发送时间
	private String content;		//消息、提醒内容
	private long receiverId;	//接收人ID
	private Integer stateId;		//状态ID:0  未读,1已读
	
	private Date readTime;		//读取时间
	private Long replyID;       //恢复ID
	private Long isReply;       //是否恢复：0代表未回复 1代表已回复
	private Long isDel;         //1、代表删除 0、代表未删除
	
	
	/**
	 * 不需要持久化的字段
	 * @return
	 */
	private String senderName;
	private String recevierName;
	private String replyTimes;
	private Integer isDelReceive;
	private String pName;
	
	public Long getIsDel() {
		return isDel;
	}
	public void setIsDel(Long isDel) {
		this.isDel = isDel;
	}
	public String getReplyTimes() {
		return replyTimes;
	}
	public void setReplyTimes(String replyTimes) {
		this.replyTimes = replyTimes;
	}
	
	public Long getReplyID() {
		return replyID;
	}
	public void setReplyID(Long replyID) {
		this.replyID = replyID;
	}
	public Long getIsReply() {
		return isReply;
	}
	public void setIsReply(Long isReply) {
		this.isReply = isReply;
	}
	
	
	
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public String getRecevierName() {
		return recevierName;
	}
	public void setRecevierName(String recevierName) {
		this.recevierName = recevierName;
	}

	public Long getMsgRemindId() {
		return msgRemindId;
	}
	public void setMsgRemindId(Long msgRemindId) {
		this.msgRemindId = msgRemindId;
	}
	public Long getProjectId() {
		return projectId;
	}
	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public Long getSenderId() {
		return senderId;
	}
	public void setSenderId(Long senderId) {
		this.senderId = senderId;
	}
	public Date getSendTime() {
		return sendTime;
	}
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(long receiverId) {
		this.receiverId = receiverId;
	}
	public Integer getStateId() {
		return stateId;
	}
	public void setStateId(Integer stateId) {
		this.stateId = stateId;
	}
	public Date getReadTime() {
		return readTime;
	}
	public void setReadTime(Date readTime) {
		this.readTime = readTime;
	}
	
	public Integer getIsDelReceive() {
		return isDelReceive;
	}
	public void setIsDelReceive(Integer isDelReceive) {
		this.isDelReceive = isDelReceive;
	}
	
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	@Override
	public String toString() {
		return "TUserMsgRemind [msgRemindId=" + msgRemindId + ", projectId="
				+ projectId + ", typeId=" + typeId + ", senderId=" + senderId
				+ ", sendTime=" + sendTime + ", content=" + content
				+ ", receiverId=" + receiverId + ", stateId=" + stateId
				+ ", readTime=" + readTime + "]";
	}
}
