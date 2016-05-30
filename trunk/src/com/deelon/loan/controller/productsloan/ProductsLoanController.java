package com.deelon.loan.controller.productsloan;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.loan.model.backstage.TSettings;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TProjectRepayment;
import com.deelon.loan.model.productsloan.ProductsLoan;
import com.deelon.loan.service.backstage.TSettingsService;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.productsloan.ProductsLoanService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.platform.model.system.Dictionary;
import com.deelon.platform.service.system.DictionaryService;

/**
 * 贷款产品操作控制器
 * 
 * @author qvr
 * 
 */
@Controller
@RequestMapping({ "/loan/productsloan/" })
public class ProductsLoanController extends BaseController {

	@Autowired
	private ProductsLoanService productsService;
	@Resource private TSettingsService tSettingsService;
	@Autowired DictionaryService dicService;
	@Autowired TprojectService projectService;
	/**
	 * 测试方法，目前产品添加走后台sysmanager的控制请求（产品维护属于系统后台维护）
	 * @param productsLoan
	 * @return
	 */
	@RequestMapping({ "addProductLoan" })
	public ModelAndView addSettings(ProductsLoan productsLoan) {
		productsLoan.setProductsLoanId(3L);
		productsLoan.setpName("宜人贷");
		productsLoan.setpAmountMin(new BigDecimal(99.00));
		productsLoan.setpAmountMax(new BigDecimal(99.00)) ;
		productsLoan.setpRateMin(new BigDecimal(99.00)) ;
		productsLoan.setpRateMax(new BigDecimal(99.00)) ;
		productsLoan.setpDeadlineMin(new BigDecimal(99.00)) ;
		productsLoan.setpDeadlineMax(new BigDecimal(99.00)) ;
		productsLoan.setpAuditDaysMin(100) ;
		productsLoan.setpAuditDaysMax(100) ;
		productsLoan.setpVotingDaysMin(100) ;
		productsLoan.setpVotingDaysMax(100) ;
		productsLoan.setpRepayWay("1") ;
		productsLoan.setpFee("AS") ;
		productsLoan.setpGood("Good") ;
		productsLoan.setpRecommend("") ;
		productsLoan.setpRepayGuide("") ;
		productsLoan.setCreator(1) ;
		productsLoan.setCreateTime(new Date());
		productsService.addProducts(productsLoan);
		return new ModelAndView();
	}
	/**
	 * 我要借款   前台展示系统的贷款产品信息
	 * @param request
	 * @return
	 */
	@RequestMapping({ "productsLoanList" })
	public ModelAndView productsLoanList(HttpServletRequest request) {
		List<ProductsLoan> products = productsService.listProductsLoan();
		int i=1;
		for(ProductsLoan p:products){
			if(i%10==1){
				p.setStyleStr("#f0681e");
			}else if(i%10==2){
				p.setStyleStr("#fdc51f");
			}else if(i%10==3){
				p.setStyleStr("#7aba58");
			}else if(i%10==4){
				p.setStyleStr("#e9834c");
			}else if(i%10==5){
				p.setStyleStr("#4d9d55");
			}else if(i%10==6){
				p.setStyleStr("#5b8cd4");
				i=0;
			} 
			i++;
		}
		request.setAttribute("productsloan", products);
		return new ModelAndView("loan/products/productsloan.jsp");
	}
	/**
	 * 我要借款   前台展示系统的贷款产品的详情信息跳转页面的控制
	 * @param request
	 * @return
	 */
	@RequestMapping({ "productDetails" })
	public ModelAndView getProductDetails(HttpServletRequest request) {
		ProductsLoan product = productsService.getById(Long.parseLong(request.getParameter("productId")));
		//request.setAttribute("product", product);
		return new ModelAndView("loan/products/productdetails.jsp").addObject("product", product);
	}
	/**
	 * 我要借款   前台申请产品借款信息录入主页面，查看时也调用次跳转控制
	 * @param request
	 * @return
	 */
	@RequestMapping({ "project" })
	public ModelAndView project(HttpServletRequest request) {
		ProductsLoan product = null;
		if(!StringUtil.isEmpty(request.getParameter("productId"))){//我的借款列表查看借款信息的按钮不会传产品信息id所以作此处理
			product = productsService.getById(Long.parseLong(request.getParameter("productId"))); 
		}
		//此处字典数据查询必须通过初始化系统字典表的数据才可正常查询到数据
		List<Dictionary> dics = dicService.getByParentId(10000001340002L);//字典表的还款类型值
		request.setAttribute("dics", dics);
		if(null!=request.getParameter("projectId")&&""!=request.getParameter("projectId")){
			request.setAttribute("project",projectService.getById(Long.parseLong(request.getParameter("projectId"))));			
		}
		return new ModelAndView("loan/products/project.jsp").addObject("product", product);
	}
	/**
	 * 我要借款   前台收益计算器的控制跳转页面
	 * @param request
	 * @return
	 */
	@RequestMapping({ "projectincomelist" })
	public ModelAndView projectincomelist(HttpServletRequest request) {
		String principal = request.getParameter("principal");
		String months = request.getParameter("months");
		String rate = request.getParameter("rate");
		String prepayWay = request.getParameter("prepayWay");
		List<TProjectRepayment> list = null;
		TProjectRepayment tr = null;
		BigDecimal psumPricipal = new BigDecimal(0);//总本金，用于等额本息不知道每期还本金的情况统计已还本金
		//以下四种还款方式的收益方式的类别实现其利息和分期的算法
		if(!StringUtil.isEmpty(principal)&&!StringUtil.isEmpty(months)&&!StringUtil.isEmpty(rate)){
			list = new ArrayList<TProjectRepayment>();
			if("3".equals(prepayWay)){//用等额本息法算得每期利息情况
				for(int i=1;i<=Integer.parseInt(months);i++){
					tr = new TProjectRepayment();
					tr.setPrCurrent(i);
					tr.setPrPay(new BigDecimal(principal).multiply(new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP))
							.multiply((new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).add(new BigDecimal(1))).pow(Integer.parseInt(months)))
							.divide(((new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).add(new BigDecimal(1))).pow(Integer.parseInt(months))).subtract(new BigDecimal(1)),9,RoundingMode.HALF_UP).setScale(2, BigDecimal.ROUND_HALF_UP));
					tr.setPrInterest((new BigDecimal(principal).subtract(psumPricipal)).multiply(new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP)).setScale(2, BigDecimal.ROUND_HALF_UP));
					tr.setPrPrincipal(tr.getPrPay().subtract(tr.getPrInterest()).setScale(2, BigDecimal.ROUND_HALF_UP));
					psumPricipal = psumPricipal.add(tr.getPrPrincipal());
					list.add(tr);
				}		
				request.setAttribute("per", tr.getPrPay().setScale(2, BigDecimal.ROUND_HALF_UP));
				request.setAttribute("perate", new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).setScale(2, BigDecimal.ROUND_HALF_UP));
				request.setAttribute("total", tr.getPrPay().multiply(new BigDecimal(Integer.parseInt(months))).setScale(2, BigDecimal.ROUND_HALF_UP));
			}else if("2".equals(prepayWay)){//用先利息后本金的还款法
				for(int i=1;i<=Integer.parseInt(months);i++){
					tr = new TProjectRepayment();
					tr.setPrCurrent(i);
					if(i==Integer.parseInt(months)){
						tr.setPrPrincipal(new BigDecimal(principal));	
					}else{
						tr.setPrPrincipal(new BigDecimal(0.00));
					}
					tr.setPrInterest(new BigDecimal(principal).multiply(new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP)).setScale(2, BigDecimal.ROUND_HALF_UP));
					tr.setPrPay(tr.getPrInterest().add(tr.getPrPrincipal()));
					list.add(tr);
				}
				request.setAttribute("perate", new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).setScale(2, BigDecimal.ROUND_HALF_UP));
				request.setAttribute("total", tr.getPrPay().add(new BigDecimal(Integer.parseInt(months)-1).multiply(tr.getPrInterest())).setScale(2, BigDecimal.ROUND_HALF_UP));
			}else if("1".equals(prepayWay)){//用一次还清的还款法
				tr = new TProjectRepayment();
				tr.setPrCurrent(1);
				tr.setPrPrincipal(new BigDecimal(principal).setScale(2, BigDecimal.ROUND_HALF_UP));
				tr.setPrInterest(new BigDecimal(principal).multiply(new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).multiply(new BigDecimal(Integer.parseInt(months)))).setScale(2, BigDecimal.ROUND_HALF_UP));
				tr.setPrPay(tr.getPrInterest().add(tr.getPrPrincipal()));
				list.add(tr);
				request.setAttribute("perate", new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).setScale(2, BigDecimal.ROUND_HALF_UP));
				request.setAttribute("total", tr.getPrPay());
			}else if("4".equals(prepayWay)){//用等额本金法算得每期利息情况
				BigDecimal totalInterest = new BigDecimal(0);
				BigDecimal totalrepay = new BigDecimal(0);
				for(int i=1;i<=Integer.parseInt(months);i++){
					tr = new TProjectRepayment();
					tr.setPrCurrent(i);
					tr.setPrPrincipal(new BigDecimal(principal).divide(new BigDecimal(Integer.parseInt(months)),9,RoundingMode.HALF_UP).setScale(2, BigDecimal.ROUND_HALF_UP));	
					tr.setPrInterest((new BigDecimal(principal).subtract(tr.getPrPrincipal().multiply(new BigDecimal(i-1)))).multiply(new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP)).setScale(2, BigDecimal.ROUND_HALF_UP));
					tr.setPrPay(tr.getPrInterest().add(tr.getPrPrincipal()));
					totalrepay = totalrepay.add(tr.getPrPay());
					totalInterest = totalInterest.add(tr.getPrInterest());
					if(Integer.parseInt(months)==i){
						tr.setPrPayless(new BigDecimal(principal).add(totalInterest).setScale(2, BigDecimal.ROUND_HALF_UP));
					}else{
						tr.setPrPayless(totalrepay);//用来前台计算本息余额
					}
					list.add(tr);
				}
				request.setAttribute("perate", new BigDecimal(rate).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).setScale(2, BigDecimal.ROUND_HALF_UP));
				request.setAttribute("total", new BigDecimal(principal).add(totalInterest).setScale(2, BigDecimal.ROUND_HALF_UP));
			}
			
			request.setAttribute("principal",principal);
			request.setAttribute("months",months);
			request.setAttribute("rate",rate);
			request.setAttribute("prepayWay",prepayWay);
			request.setAttribute("product", list);
		}
		//此处字典数据查询必须通过初始化系统字典表的数据才可正常查询到数据
		List<Dictionary> dics = dicService.getByParentId(10000001340002L);//字典表的还款类型值
		request.setAttribute("dics", dics);
		return new ModelAndView("loan/products/projectincomelist.jsp");
	}
	/**
	 * 我要借款   前台申请借款页面资费方式链接页面（其中读取的数据为平台系统收费设置的值）
	 * @param request
	 * @return
	 */
	@RequestMapping({"rate"})
	public ModelAndView RateList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<TSettings> list = tSettingsService.getAll();
		return new ModelAndView("/loan/products/rates.jsp");
	}

}
