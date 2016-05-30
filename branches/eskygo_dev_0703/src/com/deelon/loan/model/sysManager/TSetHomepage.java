package com.deelon.loan.model.sysManager;

/**
 * TSetHomepage entity. @author MyEclipse Persistence Tools
 */

public class TSetHomepage implements java.io.Serializable {

	// Fields

	private Long homePageId;
	private String code_num;
	private String rdesc_name;
	private short isVisiable;
	private Integer records;
	private int  sortID;
	private int alignID;

	// Constructors

	/** default constructor */
	public TSetHomepage() {
	}

	/** full constructor */
	public TSetHomepage(String code_num, String rdesc_name, short isVisiable,
			Integer records) {
		this.code_num = code_num;
		this.rdesc_name = rdesc_name;
		this.isVisiable = isVisiable;
		this.records = records;
	}

	// Property accessors

	public Long getHomePageId() {
		return this.homePageId;
	}

	public void setHomePageId(Long homePageId) {
		this.homePageId = homePageId;
	}

	public String getCode_num() {
		return this.code_num;
	}

	public void setCode_num(String code_num) {
		this.code_num = code_num;
	}

	public String getRdesc_name() {
		return this.rdesc_name;
	}

	public void setRdesc_name(String rdesc_name) {
		this.rdesc_name = rdesc_name;
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

	public int getSortID() {
		return sortID;
	}

	public void setSortID(int sortID) {
		this.sortID = sortID;
	}

	public int getAlignID() {
		return alignID;
	}

	public void setAlignID(int alignID) {
		this.alignID = alignID;
	}
	
	

}