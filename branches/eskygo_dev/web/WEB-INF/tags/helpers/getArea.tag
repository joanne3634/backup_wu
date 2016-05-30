<%@tag import="com.deelon.core.util.AppUtil" %>
<%@tag import="com.deelon.crowdfunding.common.util.TAreaUtil" %>
<%@tag import="com.deelon.loan.model.front.Tarea" %>
<%@tag import="java.util.Locale" %>
<%@tag import="com.deelon.core.util.StringUtil" %>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="areaId" required="true" description="地区ID"%>
<%
	TAreaUtil areaUtil = (TAreaUtil)AppUtil.getBean(TAreaUtil.class);
	if(StringUtil.isEmpty(areaId)){
		out.println("");
	}else{
		try {
			Tarea tarea = areaUtil.getAreaById(Long.parseLong(areaId));
			out.println(tarea.getAreaName());
		} catch (Exception e) {
			out.println("");
		}
	}
%>