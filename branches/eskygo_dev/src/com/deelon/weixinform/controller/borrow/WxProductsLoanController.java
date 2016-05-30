package com.deelon.weixinform.controller.borrow;

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
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.productsloan.ProductsLoan;
import com.deelon.loan.service.backstage.TSettingsService;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.productsloan.ProductsLoanService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.platform.model.system.Dictionary;
import com.deelon.platform.service.system.DictionaryService;

/**
 * 微信贷款产品操作控制器
 * 
 * @author qvr
 * 
 */
@Controller
@RequestMapping({ "/weixin/wxproductsloan/" })
public class WxProductsLoanController extends BaseController {

	@Autowired
	private ProductsLoanService productsService;
	@Resource private TSettingsService tSettingsService;
	@Autowired DictionaryService dicService;
	@Autowired TprojectService projectService;
	
	/**
	 * 借款项目列表
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
		return new ModelAndView("/weixinform/borrow/borrowProjectList.jsp");
	}
	
	/**
	 * 跳入借款流程页面
	 * @param request
	 * @return
	 */
	@RequestMapping({ "borrowFlowPage" })
	public ModelAndView borrowFlowPage(HttpServletRequest request) {
		return new ModelAndView("/weixinform/borrow/borrowFlow.jsp");
	}
	
	
	/**
	 * 借款申请操作界面
	 * @param request
	 * @return
	 */
	@RequestMapping({ "project" })
	public ModelAndView project(HttpServletRequest request,HttpServletResponse response) throws Exception{
		TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){
			return new ModelAndView("redirect:/loginWeixin.jsp"); 
		}
		
		ProductsLoan product = null;
		if(!StringUtil.isEmpty(request.getParameter("productId"))){//我的借款列表查看借款信息的按钮不会传产品信息id所以作此处理
			product = productsService.getById(Long.parseLong(request.getParameter("productId"))); 
		}else{
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
			return new ModelAndView("/weixinform/borrow/borrowProjectList.jsp");
		}
		List<Dictionary> dics = dicService.getByParentId(10000001340002L);//字典表的还款类型值
		request.setAttribute("dics", dics);
		if(null!=request.getParameter("projectId")&&""!=request.getParameter("projectId")){
			request.setAttribute("project",projectService.getById(Long.parseLong(request.getParameter("projectId"))));			
		}
		return new ModelAndView("weixinform/borrow/borrowApply.jsp").addObject("product", product);
	}
	
	/**
	 * 跳转到借款费用页面
	 * @param request
	 * @return
	 */
	@RequestMapping({"borrowCosts"})
	public ModelAndView borrowCosts(HttpServletRequest request){
		return new ModelAndView("/weixinform/borrow/borrowcosts.jsp");
	}

	/**
	 * 我要借款   前台展示系统的贷款产品的详情信息跳转页面的控制
	 * @param request
	 * @return
	 */
	@RequestMapping({ "productDetails" })
	public ModelAndView getProductDetails(HttpServletRequest request) {
		ProductsLoan product = productsService.getById(Long.parseLong(request.getParameter("productId")));
		return new ModelAndView("/weixinform/borrow/investmentdetails.jsp").addObject("product", product);
	}

}
