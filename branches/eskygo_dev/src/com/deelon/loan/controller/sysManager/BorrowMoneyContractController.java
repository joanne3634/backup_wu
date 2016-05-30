package com.deelon.loan.controller.sysManager;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TProjectContract;
import com.deelon.loan.service.sysManager.TprojectContractService;

@Controller
@RequestMapping({ "/loan/sysManager/borrowMoneyContract/" })
public class BorrowMoneyContractController extends BaseController {

	@Resource
	private TprojectContractService tprojectContractService;
	
	@Action(description="借款合同")
	 @RequestMapping({"list"})
	  public ModelAndView list(HttpServletRequest request, HttpServletResponse response)
	    throws Exception
	  {
//	    Long contractId = Long.valueOf(RequestUtil.getLong(request, "contractId"));
		 QueryFilter queryFilter=new QueryFilter(request,"contractId");
		 
		 Map<String,Object> map=queryFilter.getFilters();
			String endDate=(String)map.get("endDate");
			if(StringUtil.isNotEmpty(endDate)){
				queryFilter.addFilter("endDate", endDate+" 23:59:59");
			}
			String beginDate=(String)map.get("beginDate");
			if(StringUtil.isNotEmpty(beginDate)){
				queryFilter.addFilter("beginDate", beginDate+" 00:00:00");
			}
	    List<TProjectContract> list = tprojectContractService.getAllContarct(queryFilter);
	    ModelAndView mv = getAutoView().addObject("ListVo", list);
	    
	    return mv;
	  }
}
