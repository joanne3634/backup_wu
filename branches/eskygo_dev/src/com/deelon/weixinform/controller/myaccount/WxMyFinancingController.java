package com.deelon.weixinform.controller.myaccount;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TprojectInvestService;

/**
 * 我的理财
 * @author qin
 *
 */
@Controller
@RequestMapping({ "/weixin/wxmyfinancing/" })
public class WxMyFinancingController {

	@Resource
	private TprojectInvestService tprojecInvestService;
	
	/**
	 *  跳转到我的理财界面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "myFinancingPage" })
	public ModelAndView myFinancingPage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		TUser u=(TUser)request.getSession().getAttribute("user");
		if(null == u){
			response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
			return null;
		}
		
		String projectStatus = request.getParameter("projectStatus")==null?"0":request.getParameter("projectStatus");
		String piTransferStateId = request.getParameter("piTransferStateId");//转让状态，0未转让 1转让中 2成功 3失败
		String piIsPayOff = request.getParameter("piIsPayOff");//0=未还清，1=已还清
		String piHavedPay = request.getParameter("piHavedPay");//0=未完成打款，1=已完成打款
		String dsktype = "dsktype";//代收款判断
		String skztype = "skztype";//收款中判断
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.addFilter("userId", u.getUserId());
		//projectStatus：0=代收款，1=正在收款中，2=已还清
		if("2".equals(projectStatus)){
			queryFilter.addFilter("PI_IsPayOff", piIsPayOff);
		}else if("1".equals(projectStatus)){
			queryFilter.addFilter("PI_HavedPay", piHavedPay);
			queryFilter.addFilter("PI_TransferStateID", piTransferStateId);
			queryFilter.addFilter("skztype", skztype);
		}else if("0".equals(projectStatus)){
			queryFilter.addFilter("PI_HavedPay", piHavedPay);
			queryFilter.addFilter("PI_TransferStateID", piTransferStateId);
			queryFilter.addFilter("dsktype", dsktype);
		}
		queryFilter.addFilter("P_Del", 0);//未删除
		queryFilter.addFilter("P_IsBreak", 0);//未流标
		List<TProjectInvest> tpojectInvestList = tprojecInvestService.getBySqlKeyAll(queryFilter, TProjectInvest.class, "getTProjectInvestByUserIdAndWhere");
		
		return new ModelAndView("/weixinform/myaccount/myfinancing.jsp").addObject("tpojectInvestList", tpojectInvestList).addObject("projectStatus", projectStatus);	
	}
}
