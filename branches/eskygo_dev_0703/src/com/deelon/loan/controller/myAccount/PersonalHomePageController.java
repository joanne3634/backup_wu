package com.deelon.loan.controller.myAccount;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.sysManager.TtaskService;
import com.deelon.loan.service.sysManager.TuserFundsService;


@Controller
@RequestMapping({ "/loan/myAccount/" })
public class PersonalHomePageController extends BaseController {

	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TtaskService ttaskService;
	@Resource
	private TUserService tUserService;
	
	@RequestMapping({ "myaccountPage" })
	public ModelAndView myaccountPage(HttpServletRequest request,
			HttpServletResponse response) {
		try {
		//	long userId = ContextUtil.getCurrentTUser().getUserId();
			//TUserFunds sf=tuserFundsService.getTUserFundsByUserId(1L);//暂时
			
			String forwordUrl=request.getParameter("forwordUrl");//次属性用来跳转到指定页面
			
			
			String flag = RequestUtil.getString(request, "flag");
			
			TUser u = TUserUtil.getLogUser(request);
			TUser user = tUserService.getById(u.getUserId());
			TUserFunds tuserFunds = tuserFundsService.getByUserId(user.getUserId()); //资金
			return new ModelAndView("/crowdfunding/front/MyAccountCenter.jsp").addObject("flag", flag)
					.addObject( "tuserFunds", tuserFunds ).addObject("user", user)
					.addObject("forwordUrl", forwordUrl);//.addObject("TUserFunds", sf);//addObject("ImageId", sf.getFileId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
