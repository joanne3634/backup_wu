package com.deelon.loan.controller.myAccount;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.controller.BaseController;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TprojectAcceptService;
import com.deelon.loan.service.front.TprojectInvestService;

@Controller
@RequestMapping({"/loan/myAccount/"})
public class ManageMoneyCountController extends BaseController {
	
	@Resource
	private TprojectAcceptService tprojectAcceptService;
	
	@Resource
	private TprojectInvestService tprojectInvestService;
	
	@Action(description="到理财统计页面")
	@RequestMapping({"toManagerMoneyCount"})
	public ModelAndView toManagerMoneyCount(HttpServletRequest request,HttpServletResponse response){
		/*TProjectAccept t=new TProjectAccept();
		t.setProjectId(3L);
		t.setRepaymentId(9L);
		t.setPainvestors(22L);
		t.setPapayBack(new BigDecimal(2011));
		t.setPaprincipal(new BigDecimal(1800));
		t.setPainterest(new BigDecimal(211));
		t.setPapayBackTime(new Date());
		t.setPaisLate(0);
		t.setPalate(new BigDecimal(0));
		t.setPalateDays(0);
		t.setPaisReplacePay(0);
		t.setPareplacePay(new BigDecimal(0));
		t.setPareplacePayTime(null);
		tprojectAcceptService.add(t);*/
		/*
		 * 1.投资者 投标后 ,投资资金冻结， 等待项目资金筹集满标 此过程为项目申请中
		 * 
		 * 
		 * 
		 */
		TUser u=(TUser)request.getSession().getAttribute("user");
		TProjectInvest t=tprojectInvestService.getCountInfo(u.getUserId());
		
		return new ModelAndView("/loan/myAccount/manageMoneyCount.jsp").addObject("TProjectInvest", t);
	}
	
	

}
