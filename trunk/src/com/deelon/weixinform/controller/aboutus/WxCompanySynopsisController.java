package com.deelon.weixinform.controller.aboutus;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.cmsform.service.site.CmsSiteMenuContentService;

/**
 * 公司简介
 * @author qin
 *
 */
@Controller
@RequestMapping({"/weixin/wxaboutus/"})
public class WxCompanySynopsisController {

	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;
	
	@RequestMapping({ "companySynopsis" })
	public ModelAndView companySynopsis() {
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService
				.getMenuId("GSJJ");
		String fileIds = null;
		String fileId = null;
		CmsSiteMenuContent cms = null;
		if (list == null || list.size() == 0) {

		} else {
			cms = list.get(0);
			fileIds = cms.getContentFileIds();
			if (fileIds == null || "".equals(fileIds)) {
				fileIds = null;
			} else {
				fileId = fileIds.split(",")[0];
				for (int j = 0; j < 2; j++) {
					int a = fileId.indexOf(":");
					fileId = fileId.substring(a + 1);
				}
				fileId = fileId.replaceAll("'", "");
			}
		}
		return new ModelAndView("/weixinform/aboutus/synopsis.jsp").addObject(
				"cms", cms).addObject("fileid", fileId);
	}
}
