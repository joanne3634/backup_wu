package com.deelon.loan.model.front;

/**
 * TProductsloanAppguide entity. @author MyEclipse Persistence Tools
 */

public class TProductsloanAppguide implements java.io.Serializable {

	// Fields

	private long appGuideId;
	private long productsLoanId;
	private String agDesc;
	private Integer agOrder;

	// Constructors

	/** default constructor */
	public TProductsloanAppguide() {
	}

	/** full constructor */
	public TProductsloanAppguide(long productsLoanId, String agDesc,
			Integer agOrder) {
		this.productsLoanId = productsLoanId;
		this.agDesc = agDesc;
		this.agOrder = agOrder;
	}

	// Property accessors

	public long getAppGuideId() {
		return this.appGuideId;
	}

	public void setAppGuideId(long appGuideId) {
		this.appGuideId = appGuideId;
	}

	public long getProductsLoanId() {
		return this.productsLoanId;
	}

	public void setProductsLoanId(long productsLoanId) {
		this.productsLoanId = productsLoanId;
	}

	public String getAgDesc() {
		return this.agDesc;
	}

	public void setAgDesc(String agDesc) {
		this.agDesc = agDesc;
	}

	public Integer getAgOrder() {
		return this.agOrder;
	}

	public void setAgOrder(Integer agOrder) {
		this.agOrder = agOrder;
	}

}