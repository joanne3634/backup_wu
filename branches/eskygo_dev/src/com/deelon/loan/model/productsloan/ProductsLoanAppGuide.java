package com.deelon.loan.model.productsloan;
/**
 * 贷款产品申请指南
 * @author qvr
 *
 */
public class ProductsLoanAppGuide implements java.io.Serializable {

	private long appGuideId;//AppGuide_id申请指南ID
	private long productsLoanId;//ProductsLoan_id贷款产品ID
	private String agDesc;//AG_Desc描述
	private int agOrder;//AG_Order排序
	public long getAppGuideId() {
		return appGuideId;
	}
	public void setAppGuideId(long appGuideId) {
		this.appGuideId = appGuideId;
	}
	public long getProductsLoanId() {
		return productsLoanId;
	}
	public void setProductsLoanId(long productsLoanId) {
		this.productsLoanId = productsLoanId;
	}
	public String getAgDesc() {
		return agDesc;
	}
	public void setAgDesc(String agDesc) {
		this.agDesc = agDesc;
	}
	public int getAgOrder() {
		return agOrder;
	}
	public void setAgOrder(int agOrder) {
		this.agOrder = agOrder;
	}
	
}
