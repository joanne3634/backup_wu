package com.deelon.loan.model.front;

import java.sql.Timestamp;

/**
 * TBankcard entity. @author MyEclipse Persistence Tools
 */

public class TBank implements java.io.Serializable {

	// Fields

	private long bankId;
	private String bankName;
	private long parentID;
	private String bankPic;
	private Long creator;
	private Timestamp createTime;
	
	//非持久化
	private String tradingPwd;

	// Constructors

	/** default constructor */
	public TBank() {
	}

	/** full constructor */
	public TBank(long bankId,String bankName,long parentID,
			String bankPic,Long creator,Timestamp createTime) {
		this.bankId = bankId;
		this.bankName = bankName;
		this.parentID = parentID;
		this.bankPic = bankPic;
		this.creator = creator;
		this.createTime = createTime;
	}

	public long getBankId() {
		return bankId;
	}

	public void setBankId(long bankId) {
		this.bankId = bankId;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public long getParentID() {
		return parentID;
	}

	public void setParentID(long parentID) {
		this.parentID = parentID;
	}

	public String getBankPic() {
		return bankPic;
	}

	public void setBankPic(String bankPic) {
		this.bankPic = bankPic;
	}

	public Long getCreator() {
		return creator;
	}

	public void setCreator(Long creator) {
		this.creator = creator;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getTradingPwd() {
		return tradingPwd;
	}

	public void setTradingPwd(String tradingPwd) {
		this.tradingPwd = tradingPwd;
	}

}