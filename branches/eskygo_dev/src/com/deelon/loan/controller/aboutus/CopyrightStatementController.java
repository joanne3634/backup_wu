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
 * @version法律服务
 * 
 */
@Controller
@RequestMapping({ "/site/CopyrightStatement/" })
public class CopyrightStatementController extends BaseController {
	
	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "CopyrightStatementList" })
	@ Action( description = "法律服务显示" )
	public ModelAndView CopyrightStatementList(HttpServletRequest request,
			HttpServletResponse response) {
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService
				.getMenuId("BQSM");
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
		return new ModelAndView("/loan/aboutus/CopyrightStatement.jsp").addObject(
				"cms", cms).addObject("fileid", fileId);
	}
	
	
	@RequestMapping({ "CopyrightStatement" })
	@ Action( description = "法律服务显示" )
	public ModelAndView CopyrightStatement(HttpServletRequest request,
			HttpServletResponse response) {
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService
				.getMenuId("BQSM");
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
		return new ModelAndView("/crowdfunding/front/CopyrightStatement.jsp").addObject(
				"cms", cms).addObject("fileid", fileId);
	}
}
