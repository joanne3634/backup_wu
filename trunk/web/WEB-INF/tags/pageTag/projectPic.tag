<%@tag import="com.deelon.crowdfunding.service.backstage.TcprojectService"%>
<%@tag import="com.deelon.crowdfunding.model.backstage.Tcproject"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="项目图片显示"%>
<%@tag import="java.util.*"%>
<%
		StringBuffer sb = new StringBuffer("");
		String projectId = menupath;
		if(projectId==""){
			projectId = "0";
		}
		TcprojectService projectService=(TcprojectService)AppUtil.getBean(TcprojectService.class);
		Tcproject tcproject = projectService.getById(Long.valueOf(projectId));
		if(null!=tcproject){
			tcproject.getPpic(); 
		    String fileId= tcproject.getFilesIds(); 
		    if(null!=fileId&&!"".equals(fileId)){
		    	String url=application.getAttribute("ctx")+"/platform/system/sysFile/getFileById.ht?fileId="+fileId;
				sb.append("<img	id=\"pic\" src=\""+url+"\"  width=\"220\" height=\"130\" >");
		    }else{
		    	sb.append("<img id=\"pic\"   width=\"220\" height=\"130\"  src=\""+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/zwtp1.jpg\"  class=\"innovationimg\">");
		    }
		}else{
	    	sb.append("<img id=\"pic\"  width=\"220\" height=\"130\"   src=\""+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/zwtp1.jpg\"  class=\"innovationimg\">");
	    }
		out.print(sb.toString());
%>

