package com.deelon.loan.service.productsloan;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.loan.dao.productsloan.ProductsLoanDao;
import com.deelon.loan.model.productsloan.ProductsLoan;

/**
 * 贷款产品接口服务类
 * 
 * @author qvr
 * 
 */
@Service
public class ProductsLoanService {

	@Resource
	private ProductsLoanDao productsDao;

	/**
	 * 新增贷款产品
	 * 
	 * @param productsLoan
	 *           贷款产品对象
	 */
	public void addProducts(ProductsLoan productsLoan) {
		productsDao.saveProducts(productsLoan);
	}
	/**
	 * 修改贷款产品
	 * 
	 * @param productsLoan
	 *           贷款产品对象
	 */
	public void updateProducts(ProductsLoan productsLoan) {
		productsDao.updateProducts(productsLoan);
	}
	/**
	 * 获取所有贷款产品信息
	 * 
	 * @param productsLoan
	 *           贷款产品对象
	 * @return List<ProductsLoan>
	 */
	public List<ProductsLoan> listProductsLoan() {
		return productsDao.getAllProducts();
	}
	/**
	 * 获取id关联贷款产品信息
	 * 
	 * @param id
	 *           贷款产品ID
	 * @return ProductsLoan
	 */
	public ProductsLoan getById(long id) {
		return productsDao.getById(id);
	}
	
}
