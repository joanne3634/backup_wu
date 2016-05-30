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
 * @version公司简介
 * 
 */
@Controller
@RequestMapping({ "/site/AboutUs/" })
public class AboutUsController extends BaseController {
	
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "AboutUs" })
	@ Action( description = "公司简介显示" )
	public ModelAndView AboutUsList(HttpServletRequest request,
			HttpServletResponse response) {
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService
				.getMenuId("GSJJ");
		String fileIds = null;
		String fileId = null;
		CmsSiteMenuContent cms = null;
		//遍历fileId
		if (list == null || list.size() == 0) {

		} else {
			cms = list.get(0);
			fileIds = cms.getContentFileIds();
			if (fileIds == null || "".equals(fileIds)) {
				fileIds = null;
			} else { 
				fileId = fileIds.split(",")[0];//截取fileid
				for (int j = 0; j < 2; j++) {
					int a = fileId.indexOf(":");
					fileId = fileId.substring(a + 1);
				}
				fileId = fileId.replaceAll("'", "");
			}
		}
		return new ModelAndView("/loan/aboutus/AboutUs.jsp").addObject(
				"cms", cms).addObject("fileid", fileId);
	}

	@RequestMapping({ "AboutUsList" })
	@ Action( description = "关于我们框架页面" )
	public ModelAndView AboutUs(HttpServletRequest request,
			HttpServletResponse response) { 
		String srcurl=request.getParameter("srcurl");
		request.setAttribute("urlname", request.getParameter("urlname"));
		return new ModelAndView("/loan/aboutus/AboutUsList.jsp").addObject("srcurl",srcurl) ;
	}
}
