<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenu"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuService"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="新手入门-安全保障"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	CmsSiteMenuService cmsSiteMenuService = (CmsSiteMenuService) AppUtil.getBean(CmsSiteMenuService.class);
	CmsSiteMenuContentService cmsSiteMenuContentService = (CmsSiteMenuContentService) AppUtil.getBean(CmsSiteMenuContentService.class); 
	List<CmsSiteMenu> cmssitemenu = cmsSiteMenuService.getMenuPath(menupath);
	for (CmsSiteMenu cms:cmssitemenu) { 
		sb.append("<div class=\"big-tit\">" + cms.getMenuName()
				+ "</div>");
	List<CmsSiteMenuContent> cmsSiteMenuContentlist =cmsSiteMenuContentService.getMenuId(cms.getMenuPath()); 
	for(CmsSiteMenuContent cmsSiteMenuContent:cmsSiteMenuContentlist){
   sb.append("<div class=\"h2\">"+cmsSiteMenuContent.getContentTitle()+"</div>");
   sb.append(cmsSiteMenuContent.getContentText());
	}
	}
	out.print(sb.toString());
%>