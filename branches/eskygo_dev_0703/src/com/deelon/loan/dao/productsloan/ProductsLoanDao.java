package com.deelon.loan.dao.productsloan;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.productsloan.ProductsLoan;
import com.deelon.loan.model.productsloan.ProductsLoanAppGuide;
import com.deelon.loan.model.productsloan.ProductsLoanPrepareData;

/**
 * 贷款产品数据库操作
 * 
 * @author qvr
 * 
 */
@Repository

public class ProductsLoanDao  extends BaseDao<ProductsLoan> {

	@Override
	public Class<ProductsLoan> getEntityClass() {
		return ProductsLoan.class;
	}
	/**
	 * 新增产品
	 * @param productsloan
	 * @return ID
	 */
	public long saveProducts(ProductsLoan productsloan) {
		insert("insertProducts", productsloan);
		return productsloan.getProductsLoanId();
	}
	/**
	 * 修改贷款产品信息
	 * @param productsloan
	 */
	public void updateProducts(ProductsLoan productsloan) {
		update("updateProducts", productsloan);
	}
	/**
	 * 查询获取所有的产品列表信息 
	 * @return List<ProductsLoan>
	 */
	public List<ProductsLoan> getAllProducts() {
		return getBySqlKey("getProducts");
	}
	
	/**
	 * 新增产品申请指南
	 * @param productsloan
	 * @return ID
	 */
	public long saveAppGuides(ProductsLoanAppGuide appGuides) {
		insert("insertAppGuides", appGuides);
		return appGuides.getProductsLoanId();
	}
	/**
	 * 删除产品申请指南
	 * @param productsloan
	 * @return ID
	 */
	public long delAppGuides(Long productloanId) {
		return update("delAppGuides", productloanId);
	}
	
	/**
	 * 新增产品要求材料
	 * @param productsloan
	 * @return ID
	 */
	public long savePrepareDatas(ProductsLoanPrepareData prepareDatas) {
		insert("insertPrepareDatas", prepareDatas);
		return prepareDatas.getProductsLoanId();
	}
	/**
	 * 删除产品要求材料
	 * @param productsloan
	 * @return ID
	 */
	public long delPrepareDatas(Long productloanId) {
		return update("delPrepareDatas", productloanId);
	}
}
