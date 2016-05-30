package com.deelon.loan.controller.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TBankcard;
import com.deelon.loan.model.front.TProjectContract;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TbankcardService;

@Controller
@RequestMapping({ "/loan/front/bankcard/" })
public class TBankCardController extends BaseController {
	
	@Resource
	private TbankcardService tbankcardService; 
	
	 @RequestMapping({"list"})
	 @ Action( description = "查看Tbankcard分页列表")
	  public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
		 try {
			//begin 获得查询条件
			 String userName = request.getParameter("userName");
			 String cardId = request.getParameter("cardId");
			 String bankName = request.getParameter("bankName");
			//end
			 QueryFilter queryFilter=new QueryFilter(request,"bankCardItem");//分页
			 queryFilter.addFilter("userName", userName);
			 queryFilter.addFilter("cardId", cardId);
			 queryFilter.addFilter("bankName", bankName);
			 List<TBankcard> list = tbankcardService.getAll(queryFilter);//查询分页列表数据
			 return new ModelAndView("/loan/front/tBankCardList.jsp").addObject("bangkCardList", list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return null;
	  }
}
