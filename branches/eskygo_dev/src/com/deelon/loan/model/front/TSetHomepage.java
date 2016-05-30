package com.deelon.loan.model.front;

/**
 * TSetHomepage entity. @author MyEclipse Persistence Tools
 */

public class TSetHomepage implements java.io.Serializable {

	// Fields

	private Integer homePageId;
	private String code;
	private String rdesc;
	private short isVisiable;
	private Integer records;

	// Constructors

	/** default constructor */
	public TSetHomepage() {
	}

	/** full constructor */
	public TSetHomepage(String code, String rdesc, short isVisiable,
			Integer records) {
		this.code = code;
		this.rdesc = rdesc;
		this.isVisiable = isVisiable;
		this.records = records;
	}

	// Property accessors

	public Integer getHomePageId() {
		return this.homePageId;
	}

	public void setHomePageId(Integer homePageId) {
		this.homePageId = homePageId;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getRdesc() {
		return this.rdesc;
	}

	public void setRdesc(String rdesc) {
		this.rdesc = rdesc;
	}

	public short getIsVisiable() {
		return this.isVisiable;
	}

	public void setIsVisiable(short isVisiable) {
		this.isVisiable = isVisiable;
	}

	public Integer getRecords() {
		return this.records;
	}

	public void setRecords(Integer records) {
		this.records = records;
	}

}