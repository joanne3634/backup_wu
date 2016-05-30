 <%@tag import="com.deelon.loan.model.front.TProject"%>
<%@tag import="com.deelon.loan.service.sysManager.TprojectService"%>
<%@tag import="com.deelon.core.util.AppUtil"%>  
<%@tag import="java.lang.Long"%>
<%@tag import="java.lang.Integer"%>
<%@tag import="java.util.*"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="项目名"%>

<%
	StringBuffer sb = new StringBuffer(""); 
   String  id=menupath; 
  String a="2";
  long projectid=Long.valueOf(id.trim()).longValue(); 
  TprojectService tprojectService=(TprojectService)AppUtil.getBean(TprojectService.class);
   TProject tproject=tprojectService.getById(projectid);
	sb.append(tproject.getPname() ); 
	out.print(sb.toString()); 
%>