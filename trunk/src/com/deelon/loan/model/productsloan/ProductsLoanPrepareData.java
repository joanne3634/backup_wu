package com.deelon.loan.model.productsloan;

/**
 * 贷款产品准备材料
 * 
 * @author qvn
 * 
 */
public class ProductsLoanPrepareData {

	private long prepareDataId;//PrepareData_id材料ID
	private long productsLoanId;//ProductsLoan_id贷款产品ID
	private String pdDesc;//PD_Desc材料描述
	private int pdOrder;//PD_Order材料顺序
	public long getPrepareDataId() {
		return prepareDataId;
	}
	public void setPrepareDataId(long prepareDataId) {
		this.prepareDataId = prepareDataId;
	}
	public long getProductsLoanId() {
		return productsLoanId;
	}
	public void setProductsLoanId(long productsLoanId) {
		this.productsLoanId = productsLoanId;
	}
	public String getPdDesc() {
		return pdDesc;
	}
	public void setPdDesc(String pdDesc) {
		this.pdDesc = pdDesc;
	}
	public int getPdOrder() {
		return pdOrder;
	}
	public void setPdOrder(int pdOrder) {
		this.pdOrder = pdOrder;
	}
	
}
