<%@tag import="com.deelon.core.util.AppConfigUtil" %><%@tag pageEncoding="utf-8" %><%@ attribute name="src" required="true" description="静态资源地点" %><%@ attribute name="type" required="true" description="类型" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core"
     prefix="c" %><%
	final String key = "assetPath"; 
    String url = AppConfigUtil.get(key);
    String version = AppConfigUtil.get("staticVersion");
    if ( null == version ) {
    	version = "0";
    }
	if ( null == url ) {
		Object value = application.getAttribute(key);
		if ( null != value ) {
			url = value.toString();
		}
	}
	if ( null == url ) {
		url = "/";
	}
	if ( false == src.contains("?")) {
		src += "?";
	}
	src += "&_cache=" + version;
	if ( url.endsWith("/") && src.startsWith("/")) {
		src = src.substring(1);
	}
	out.print(url+src);
%>