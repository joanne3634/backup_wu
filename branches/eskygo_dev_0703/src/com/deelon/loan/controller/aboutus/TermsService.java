package com.deelon.loan.controller.aboutus;

import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.cmsform.service.site.CmsSiteMenuContentService;
import com.deelon.core.annotion.Action;
import com.deelon.core.web.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * @author Administrator
 *@version 条款协议
 * 
 */
@Controller
@RequestMapping({ "/loan/aboutus/" })
public class TermsService extends BaseController {
	
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;
	
	@RequestMapping({ "TermsServiceList" })
	@Action( description = " 取出条款协议" )
	public ModelAndView TermsServiceList(HttpServletRequest request,
			HttpServletResponse response) { 
		int i=Integer.parseInt(request.getParameter("xieyiid"));
		CmsSiteMenuContent cms=null;
		String name="";
		String path = "TKXY";
		if (i == 1) {
			name = "服务协议";
		} else if (i == 2) {
			name = "借入协议";
		} else if (i == 3) {
			name = "借出协议";
		} else if (i == 4) {
			name = "用户注册协议";
		} else if (i == 5) {
			name = "风险提示书";
		} else if (i == 6) {
			name = "领头人承诺书";
		}
		cms = cmsSiteMenuContentService.getContentTitle(path, name).get(0);
		return new ModelAndView("/loan/aboutus/TermsService.jsp").addObject("cms",cms) ;
	}
}
