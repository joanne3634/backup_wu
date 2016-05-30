<%@tag import="com.deelon.loan.model.front.TUser"%>
<%@tag import="com.deelon.loan.service.front.TUserService"%>
<%@tag import="com.deelon.loan.model.front.TUserCompany"%>
<%@tag import="com.deelon.loan.service.front.TuserCompanyService"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="所有用户"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer(""); 
      TUserService tuserService = (TUserService)AppUtil.getBean(TUserService.class);
      List<TUser> tuser=tuserService.getAll(); 
	 sb.append("<select name=\"userId\"  id=\"userId\">");
      for(TUser t:tuser){
    	  if(t.getUserId()==Long.parseLong(menupath.trim())){
    	 
    		  sb.append("<option value=\""+t.getUserId()+"\" selected>"+t.getLoginName()+"</option>"); 
    	  }else{
    		  sb.append("<option value=\""+t.getUserId()+"\" >"+t.getLoginName()+"</option>"); 
    	  }
    	  
      }
	  sb.append("</select>");
	  out.print(sb.toString());
%>