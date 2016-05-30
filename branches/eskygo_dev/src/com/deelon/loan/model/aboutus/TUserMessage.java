package com.deelon.loan.model.aboutus;

public class TUserMessage {
	private int messageId;//主键
	private int userId;       //会员ID
	private String messageTitle; //留言标题
	private int messageType;//留言类型
	private String messageContent;//留言内容
	private String messageRemark;//备注
	private int messageState;//状态 1.已读，2.未读
	private int messageIsReply;//回复状态2.已回复，1.未回复
	private int messageReplyWay;//回复方式1.短信，2.邮件
	private String messageReplyAbout;//回复内容
	private String messageMobile;//手机
	private String messageEmail;//邮件
	public TUserMessage() {
	}
	
	public TUserMessage(int messageId, int userId, String messageTitle,
			int messageType, String messageContent, String messageRemark,
			int messageState, int messageIsReply, int messageReplyWay,
			String messageReplyAbout, String messageMobile, String messageEmail) {
		super();
		this.messageId = messageId;
		this.userId = userId;
		this.messageTitle = messageTitle;
		this.messageType = messageType;
		this.messageContent = messageContent;
		this.messageRemark = messageRemark;
		this.messageState = messageState;
		this.messageIsReply = messageIsReply;
		this.messageReplyWay = messageReplyWay;
		this.messageReplyAbout = messageReplyAbout;
		this.messageMobile = messageMobile;
		this.messageEmail = messageEmail;
	}

	public int getMessageId() {
		return messageId;
	}
	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getMessageTitle() {
		return messageTitle;
	}
	public void setMessageTitle(String messageTitle) {
		this.messageTitle = messageTitle;
	}
	public int getMessageType() {
		return messageType;
	}
	public void setMessageType(int messageType) {
		this.messageType = messageType;
	}
	public String getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	public String getMessageRemark() {
		return messageRemark;
	}
	public void setMessageRemark(String messageRemark) {
		this.messageRemark = messageRemark;
	}
	public int getMessageState() {
		return messageState;
	}
	public void setMessageState(int messageState) {
		this.messageState = messageState;
	}
	public int getMessageIsReply() {
		return messageIsReply;
	}
	public void setMessageIsReply(int messageIsReply) {
		this.messageIsReply = messageIsReply;
	}
	public int getMessageReplyWay() {
		return messageReplyWay;
	}
	public void setMessageReplyWay(int messageReplyWay) {
		this.messageReplyWay = messageReplyWay;
	}
	public String getMessageReplyAbout() {
		return messageReplyAbout;
	}
	public void setMessageReplyAbout(String messageReplyAbout) {
		this.messageReplyAbout = messageReplyAbout;
	}
	public String getMessageMobile() {
		return messageMobile;
	}
	public void setMessageMobile(String messageMobile) {
		this.messageMobile = messageMobile;
	}
	public String getMessageEmail() {
		return messageEmail;
	}
	public void setMessageEmail(String messageEmail) {
		this.messageEmail = messageEmail;
	}
	
}