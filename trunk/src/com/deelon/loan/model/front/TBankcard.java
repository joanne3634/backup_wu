package com.deelon.loan.model.front;

import java.sql.Timestamp;
import java.util.Date;

/**
 * TBankcard entity. @author MyEclipse Persistence Tools
 */

public class TBankcard implements java.io.Serializable {

	// Fields

	private long bankCardId;
	private long userId;
	private String realName;
	private String idNo;
	private String cardId;
	private Long bankId;
	private String city;
	private String opening;
	private short audit;
	private long checker;
	private Date checkTime;
	private String remark;
	private Date createTime;
	private short isBindSsucceed;
	private String mobileNum;//开卡手机 
	private String cardPwd;
	
	private String userName;
	private String bankName;
	
	private String cityNumber;
	private String openingNumber;
	
	private String bankCode;

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getCityNumber() {
		return cityNumber;
	}

	public void setCityNumber(String cityNumber) {
		this.cityNumber = cityNumber;
	}

	public String getOpeningNumber() {
		return openingNumber;
	}

	public void setOpeningNumber(String openingNumber) {
		this.openingNumber = openingNumber;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	//非持久化
	private String tradingPwd;

	// Constructors

	/** default constructor */
	public TBankcard() {
	}

	/** full constructor */
	public TBankcard(long userId, String realName, String idNo, String cardId,
			Long bankId, String city, String opening, short audit,
			long checker, Timestamp checkTime, String remark, Timestamp createTime,
			short isBindSsucceed) {
		this.userId = userId;
		this.realName = realName;
		this.idNo = idNo;
		this.cardId = cardId;
		this.bankId = bankId;
		this.city = city;
		this.opening = opening;
		this.audit = audit;
		this.checker = checker;
		this.checkTime = checkTime;
		this.remark = remark;
		this.createTime = createTime;
		this.isBindSsucceed = isBindSsucceed;
	}

	// Property accessors

	public long getBankCardId() {
		return this.bankCardId;
	}

	public void setBankCardId(long bankCardId) {
		this.bankCardId = bankCardId;
	}

	public long getUserId() {
		return this.userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getRealName() {
		return this.realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getIdNo() {
		return this.idNo;
	}

	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}

	public String getCardId() {
		return this.cardId;
	}

	public void setCardId(String cardId) {
		this.cardId = cardId;
	}

	public Long getBankId() {
		return bankId;
	}

	public void setBankId(Long bankId) {
		this.bankId = bankId;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getOpening() {
		return this.opening;
	}

	public void setOpening(String opening) {
		this.opening = opening;
	}

	public short getAudit() {
		return this.audit;
	}

	public void setAudit(short audit) {
		this.audit = audit;
	}

	public long getChecker() {
		return this.checker;
	}

	public void setChecker(long checker) {
		this.checker = checker;
	}

	public Date getCheckTime() {
		return this.checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public short getIsBindSsucceed() {
		return this.isBindSsucceed;
	}

	public void setIsBindSsucceed(short isBindSsucceed) {
		this.isBindSsucceed = isBindSsucceed;
	}

	public String getMobileNum() {
		return mobileNum;
	}

	public void setMobileNum(String mobileNum) {
		this.mobileNum = mobileNum;
	}

	public String getCardPwd() {
		return cardPwd;
	}

	public void setCardPwd(String cardPwd) {
		this.cardPwd = cardPwd;
	}

	public String getTradingPwd() {
		return tradingPwd;
	}

	public void setTradingPwd(String tradingPwd) {
		this.tradingPwd = tradingPwd;
	}

	
	
}