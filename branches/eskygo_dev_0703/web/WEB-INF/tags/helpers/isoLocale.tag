<%@tag import="com.deelon.core.util.AppConfigUtil" %><%@tag import="java.util.Locale" %><%@tag pageEncoding="utf-8" %><%@ attribute name="locale" required="false" description="java locale" %><%
	String defaultLocale = "en";
 
	if ( null == locale ) {
		Locale tlocale = request.getLocale();
		if ( null == tlocale ) {
			locale = tlocale.toString();
		} else {
			locale = defaultLocale;
		}
	}

	out.print(locale.replace('_', '-'));
%>