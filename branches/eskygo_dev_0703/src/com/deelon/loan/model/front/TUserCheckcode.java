package com.deelon.loan.model.front;

import java.util.Date;

public class TUserCheckcode {
	
	private long checkCodeId;
	private long userId;
	private String typeId;
    private String fromObj;
    private String checkCode;
    private Date createTime;
    private short isHaveSend;
    private short isPass;
	public long getCheckCodeId() {
		return checkCodeId;
	}
	public void setCheckCodeId(long checkCodeId) {
		this.checkCodeId = checkCodeId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getTypeId() {
		return typeId;
	}
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	public String getFromObj() {
		return fromObj;
	}
	public void setFromObj(String fromObj) {
		this.fromObj = fromObj;
	}
	public String getCheckCode() {
		return checkCode;
	}
	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public short getIsHaveSend() {
		return isHaveSend;
	}
	public void setIsHaveSend(short isHaveSend) {
		this.isHaveSend = isHaveSend;
	}
	public short getIsPass() {
		return isPass;
	}
	public void setIsPass(short isPass) {
		this.isPass = isPass;
	}
	public TUserCheckcode(long checkCodeId, long userId, String typeId,
			String fromObj, String checkCode, Date createTime,
			short isHaveSend, short isPass) {
		super();
		this.checkCodeId = checkCodeId;
		this.userId = userId;
		this.typeId = typeId;
		this.fromObj = fromObj;
		this.checkCode = checkCode;
		this.createTime = createTime;
		this.isHaveSend = isHaveSend;
		this.isPass = isPass;
	}
	
	
	
	public TUserCheckcode() {
		super();
	}
	@Override
	public String toString() {
		return "TUserCheckcode [checkCodeId=" + checkCodeId + ", userId="
				+ userId + ", typeId=" + typeId + ", fromObj=" + fromObj
				+ ", checkCode=" + checkCode + ", createTime=" + createTime
				+ ", isHaveSend=" + isHaveSend + ", isPass=" + isPass + "]";
	}
	
}
