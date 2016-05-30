package com.deelon.loan.model.front;

import java.util.Date;

/**
 * TUserContact entity. @author MyEclipse Persistence Tools
 */

public class TUserContact implements java.io.Serializable {

	// Fields

	private long contactId;
	private long userId;
	private String CName;
	private String CRelation;
	private String CMobile;
	private String COtherName;
	private String COtherRelation;
	private String COtherMobile;
	private Date CUpdateTime;
	private String statusID;
	private Date checkTime;

	// Constructors

	/** default constructor */
	public TUserContact() {
	}

	/** full constructor */
	public TUserContact(long userId, String CName, String CRelation,
			String CMobile, String COtherName, String COtherRelation,
			String COtherMobile, Date CUpdateTime) {
		this.userId = userId;
		this.CName = CName;
		this.CRelation = CRelation;
		this.CMobile = CMobile;
		this.COtherName = COtherName;
		this.COtherRelation = COtherRelation;
		this.COtherMobile = COtherMobile;
		this.CUpdateTime = CUpdateTime;
	}

	// Property accessors

	public long getContactId() {
		return this.contactId;
	}

	public void setContactId(long contactId) {
		this.contactId = contactId;
	}

	public long getUserId() {
		return this.userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getCName() {
		return this.CName;
	}

	public void setCName(String CName) {
		this.CName = CName;
	}

	public String getCRelation() {
		return this.CRelation;
	}

	public void setCRelation(String CRelation) {
		this.CRelation = CRelation;
	}

	public String getCMobile() {
		return this.CMobile;
	}

	public void setCMobile(String CMobile) {
		this.CMobile = CMobile;
	}

	public String getCOtherName() {
		return this.COtherName;
	}

	public void setCOtherName(String COtherName) {
		this.COtherName = COtherName;
	}

	public String getCOtherRelation() {
		return this.COtherRelation;
	}

	public void setCOtherRelation(String COtherRelation) {
		this.COtherRelation = COtherRelation;
	}

	public String getCOtherMobile() {
		return this.COtherMobile;
	}

	public void setCOtherMobile(String COtherMobile) {
		this.COtherMobile = COtherMobile;
	}

	public Date getCUpdateTime() {
		return this.CUpdateTime;
	}

	public void setCUpdateTime(Date CUpdateTime) {
		this.CUpdateTime = CUpdateTime;
	}

	public String getStatusID() {
		return statusID;
	}

	public void setStatusID(String statusID) {
		this.statusID = statusID;
	}

	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

}