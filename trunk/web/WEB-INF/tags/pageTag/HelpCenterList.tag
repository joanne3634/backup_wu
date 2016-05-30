<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenu"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuService"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="帮助中心二级菜单"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	CmsSiteMenuService cmsSiteMenuService = (CmsSiteMenuService) AppUtil
			.getBean(CmsSiteMenuService.class);
	List<CmsSiteMenu> cmssitemenu = cmsSiteMenuService
			.getMenuPath(menupath);
	for (CmsSiteMenu cms : cmssitemenu) { 
		sb.append("<li><a href=\"javascript:void(0)\" onclick=\"loadPages('"+application.getAttribute("ctx")+"/loan/aboutus/HelpCenterDetails.ht?menupath="+cms.getMenuPath()+"')\">" + cms.getMenuName()
				+ "</a></li>");
	}
	out.print(sb.toString());
%>