<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="法律服务"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	String url=application.getAttribute("PLATFORM-SYSTEM-URL")+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+menupath;
	sb.append("<img src=\""+url+"\">");
	out.print(sb.toString());
%>