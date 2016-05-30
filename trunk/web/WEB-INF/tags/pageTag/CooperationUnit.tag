<%@tag import="java.io.File"%>
<%@tag import="com.deelon.platform.service.util.ServiceUtil"%>
<%@tag import="com.deelon.platform.controller.system.SysFileController"%>
<%@tag import="com.deelon.platform.model.system.SysFile"%>
<%@tag import="com.deelon.platform.service.system.SysFileService"%>
<%@tag import="com.fr.base.core.json.JSONObject"%>
<%@tag import="com.fr.base.core.json.JSONArray"%>
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag
	import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="合作机构"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService = (HomeIndexPageService) AppUtil.getBean(HomeIndexPageService.class);
	TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("partner");//获取合作伙伴
	if (null != homepageMoudle && homepageMoudle.getIsVisiable() == 1) {
		CmsSiteMenuContentService cmsSiteMenuContentService = (CmsSiteMenuContentService) AppUtil.getBean(CmsSiteMenuContentService.class);
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenuId(menupath);
		
		sb.append("<div class=\"companion clear\"> <h3><img src=\""+application.getAttribute("ctx") + "/crowdfunding/Skin/Default/images/trianglegray.png\">合作伙伴<a href=\"" + application.getAttribute("ctx") + "/site/AboutUs/AboutUsList.ht?srcurl='site/CooperatingAgency/CooperatingAgencyList.ht'&&urlname=6\"  target=\"_blank\">查看更多</a></h3><div class=\"companionContent clear\">  ");
		int len = 0;
		if (list.size() > homepageMoudle.getRecords()) {
			len = homepageMoudle.getRecords();
		} else {
			len = list.size();
		}
		for (int i = 0; i < len; i++) {
			CmsSiteMenuContent cmsSiteMenuContent = (CmsSiteMenuContent) list.get(i);
			cmsSiteMenuContent.getContentFileIds();
			String fileId = cmsSiteMenuContent.getFilesIds();
			String url = application.getAttribute("PLATFORM-SYSTEM-URL") + "/platform/system/sysFile/getFileById.ht?fileId=" + fileId;
			if (cmsSiteMenuContent.getContentUrl() == null || "".equals(cmsSiteMenuContent.getContentUrl())) {
				sb.append("  <img src=\"" + url + "\" alt=\"\">");//<a href=\"#\"  target=\"_blank\"></a> 
			} else {
				sb.append("  <a href=\"" + cmsSiteMenuContent.getContentUrl() + "\" target=\"_blank\"><img src=\"" + url + "\" alt=\"\"></a> ");
			}
		}
		sb.append("  </div> </div>");
	}
	out.print(sb.toString());
%>