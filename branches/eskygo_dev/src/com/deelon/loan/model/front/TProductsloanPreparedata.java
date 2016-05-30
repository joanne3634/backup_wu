package com.deelon.loan.model.front;

/**
 * TProductsloanPreparedata entity. @author MyEclipse Persistence Tools
 */

public class TProductsloanPreparedata implements java.io.Serializable {

	// Fields

	private long prepareDataId;
	private long productsLoanId;
	private String pdDesc;
	private Integer pdOrder;

	// Constructors

	/** default constructor */
	public TProductsloanPreparedata() {
	}

	/** full constructor */
	public TProductsloanPreparedata(long productsLoanId, String pdDesc,
			Integer pdOrder) {
		this.productsLoanId = productsLoanId;
		this.pdDesc = pdDesc;
		this.pdOrder = pdOrder;
	}

	// Property accessors

	public long getPrepareDataId() {
		return this.prepareDataId;
	}

	public void setPrepareDataId(long prepareDataId) {
		this.prepareDataId = prepareDataId;
	}

	public long getProductsLoanId() {
		return this.productsLoanId;
	}

	public void setProductsLoanId(long productsLoanId) {
		this.productsLoanId = productsLoanId;
	}

	public String getPdDesc() {
		return this.pdDesc;
	}

	public void setPdDesc(String pdDesc) {
		this.pdDesc = pdDesc;
	}

	public Integer getPdOrder() {
		return this.pdOrder;
	}

	public void setPdOrder(Integer pdOrder) {
		this.pdOrder = pdOrder;
	}

}