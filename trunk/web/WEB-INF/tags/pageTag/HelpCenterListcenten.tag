<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenu"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuService"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="帮助中心centent"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	CmsSiteMenuContentService cmsSiteMenuService = (CmsSiteMenuContentService) AppUtil
			.getBean(CmsSiteMenuContentService.class);
	List<CmsSiteMenuContent> cmssitemenu = cmsSiteMenuService
			.getMenuId(menupath);
	sb.append("<div class=\"index-con\">" );
	for (CmsSiteMenuContent cms : cmssitemenu) {
		sb.append(cms.getContentTitle()+"<br>");
	}
	sb.append("</div>" );
	out.print(sb.toString());
%>