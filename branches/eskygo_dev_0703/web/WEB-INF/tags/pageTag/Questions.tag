<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenu"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuService"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="常见问题"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	CmsSiteMenuService cmsSiteMenuService = (CmsSiteMenuService) AppUtil
			.getBean(CmsSiteMenuService.class);
	List<CmsSiteMenu> cmssitemenu = cmsSiteMenuService
			.getMenuPath(menupath);
	for (CmsSiteMenu cms : cmssitemenu) {  
		sb.append("<li><div class=\"iocn-trangle\"></div><a href=\""+application.getAttribute("ctx")+"/loan/aboutus/HelpCenterList.ht?srcurl='"+cms.getMenuPath()+"'\"  target=\"_top\">"+cms.getMenuName()+"</a></li>");
	}
	out.print(sb.toString());
%>