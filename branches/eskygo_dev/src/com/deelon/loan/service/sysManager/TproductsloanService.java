/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.sysManager;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.productsloan.ProductsLoanDao;
import com.deelon.loan.dao.sysManager.TproductsloanDao;
import com.deelon.loan.model.productsloan.ProductsLoan;
import com.deelon.loan.model.productsloan.ProductsLoanAppGuide;
import com.deelon.loan.model.productsloan.ProductsLoanPrepareData;
import com.deelon.loan.model.productsloan.Tproductsloan;

@ Service
public class TproductsloanService extends BaseService<Tproductsloan>{
	
	@ Resource
	private TproductsloanDao tproductsloanDao;
	@ Resource
	private ProductsLoanDao productsAttchdataDao;
	
	protected IEntityDao<Tproductsloan, Long> getEntityDao()
	{
		return this.tproductsloanDao;
	}
	/**
	 * 新增贷款产品和产品相关申请指南及申请准备材料
	 * @param tproductsloan
	 */
	@Transactional(rollbackFor=Exception.class) 
	public void addproductsAndSumlist(Tproductsloan tproductsloan) {
		try{
			tproductsloanDao.add(tproductsloan);
			//添加产品申请指南
			if(null!=tproductsloan.getAppGuides()&&""!=tproductsloan.getAppGuides()){
				ProductsLoanAppGuide appGuides = new ProductsLoanAppGuide();
				String[] aps = tproductsloan.getAppGuides().split(",");
				for(int i=0;i<aps.length;i++){
					appGuides.setAppGuideId(tproductsloan.getProductsLoanId()+1+i);
					appGuides.setProductsLoanId(tproductsloan.getProductsLoanId());
					appGuides.setAgDesc(aps[i]);
					appGuides.setAgOrder(i+1);
					productsAttchdataDao.saveAppGuides(appGuides);
				}
			}
			//添加产品申请需要材料
			if(null!=tproductsloan.getPrepareDatas()&&""!=tproductsloan.getPrepareDatas()){
				ProductsLoanPrepareData prepareDatas = new ProductsLoanPrepareData();
				String[] pres = tproductsloan.getPrepareDatas().split(",");
				for(int i=0;i<pres.length;i++){
					prepareDatas.setPrepareDataId(tproductsloan.getProductsLoanId()+1+i);
					prepareDatas.setProductsLoanId(tproductsloan.getProductsLoanId());
					prepareDatas.setPdDesc(pres[i]);
					prepareDatas.setPdOrder(i+1);
					productsAttchdataDao.savePrepareDatas(prepareDatas);
				}
			}
		}catch(Exception e){
			throw new RuntimeException(e.getCause());
		}
	}
	/**
	 * 修改贷款产品和产品相关申请指南及申请准备材料
	 * @param tproductsloan
	 */
	@Transactional(rollbackFor=Exception.class) 
	public void updateproductsAndSumlist(Tproductsloan tproductsloan) {
		try{
			tproductsloanDao.update(tproductsloan);
			//添加产品申请指南
			if(null!=tproductsloan.getAppGuides()&&""!=tproductsloan.getAppGuides()){
				ProductsLoanAppGuide appGuides = null;
				String[] aps = tproductsloan.getAppGuides().split(",");
				productsAttchdataDao.delAppGuides(tproductsloan.getProductsLoanId());
				for(int i=0;i<aps.length;i++){
					appGuides = new ProductsLoanAppGuide();
					appGuides.setAppGuideId(tproductsloan.getProductsLoanId()+1+i);
					appGuides.setProductsLoanId(tproductsloan.getProductsLoanId());
					appGuides.setAgDesc(aps[i]);
					appGuides.setAgOrder(i+1);
					productsAttchdataDao.saveAppGuides(appGuides);
				}
			}
			//添加产品申请需要材料
			if(null!=tproductsloan.getPrepareDatas()&&""!=tproductsloan.getPrepareDatas()){
				ProductsLoanPrepareData prepareDatas = null;
				String[] pres = tproductsloan.getPrepareDatas().split(",");
				productsAttchdataDao.delPrepareDatas(tproductsloan.getProductsLoanId());
				for(int i=0;i<pres.length;i++){
					prepareDatas = new ProductsLoanPrepareData();
					prepareDatas.setPrepareDataId(tproductsloan.getProductsLoanId()+1+i);
					prepareDatas.setProductsLoanId(tproductsloan.getProductsLoanId());
					prepareDatas.setPdDesc(pres[i]);
					prepareDatas.setPdOrder(i+1);
					productsAttchdataDao.savePrepareDatas(prepareDatas);
				}
			}
		}catch(Exception e){
			throw new RuntimeException(e.getCause());
		}
	}
	/**
	 * 删除贷款产品和产品相关申请指南及申请准备材料
	 * @param lAryId
	 */
	@Transactional(rollbackFor=Exception.class) 
	public void delByIdsAndsublist(Long[] lAryId) {
		try{
			for (Long pid : lAryId) {
				productsAttchdataDao.delAppGuides(pid);
				productsAttchdataDao.delPrepareDatas(pid);
			}
			delByIds(lAryId);
			 
		}catch(Exception e){
			throw new RuntimeException(e.getCause());
		}
		
	}
	/**
	 * 获取贷款产品和产品相关申请指南及申请准备材料
	 * @param lAryId
	 */
	public Tproductsloan getTproductsloanAndThingsById(Long pkId) {
		Tproductsloan tproductsloan = getById(pkId);
		ProductsLoan products = productsAttchdataDao.getById(pkId);
		if(null!=products.getAppGuides()&&products.getAppGuides().size()>0){
			StringBuffer apsbs = new StringBuffer();
			for(ProductsLoanAppGuide ap:products.getAppGuides()){
				apsbs.append(ap.getAgDesc());
			}
			tproductsloan.setAppGuides(apsbs.toString());
		}
		if(null!=products.getPrepareDatas()&&products.getPrepareDatas().size()>0){
			StringBuffer pdsbs = new StringBuffer();
			for(ProductsLoanPrepareData pd:products.getPrepareDatas()){
				pdsbs.append(pd.getPdDesc());
			}
			tproductsloan.setPrepareDatas(pdsbs.toString());
		}
		return tproductsloan;
	}

}