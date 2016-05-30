package com.deelon.loan.controller.aboutus;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.cmsform.service.site.CmsSiteMenuContentService;
import com.deelon.core.annotion.Action;
import com.deelon.core.web.controller.BaseController;
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
		List<CmsSiteMenuContent> list=cmsSiteMenuContentService.getMenuId("TKXY"); 
		CmsSiteMenuContent cms=null;
		String name="";
		//根据传入值来取相对应的条款协议  1=服务协议，2=借入协议，3=借出协议 4=注册协议
		if(i==1){
			name="服务协议";
		}else if(i==2){
			name="借入协议";
		} else if(i==3){
			name="借出协议";
		} else if(i==4){
			name="注册协议";
		}
		
		for(CmsSiteMenuContent cmsSiteMenuContent:list){
			 if(name.equals(cmsSiteMenuContent.getContentTitle())){
				 cms=cmsSiteMenuContent; 
			 }
		}
		return new ModelAndView("/loan/aboutus/TermsService.jsp").addObject("cms",cms) ;
	}
}
