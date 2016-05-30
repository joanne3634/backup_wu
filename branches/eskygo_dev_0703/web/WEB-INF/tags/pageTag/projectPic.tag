<%@tag import="com.deelon.crowdfunding.service.backstage.TcprojectService"%>
<%@tag import="com.deelon.crowdfunding.model.backstage.Tcproject"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="项目图片显示"%>
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
		    	String url=application.getAttribute("ctx")+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+fileId;
				sb.append("<img id='pic' src=\""+url+"\">");
		    }else{
		    	sb.append("<img id='pic' src=\""+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/zwtp1.jpg"+"\">");
		    }
		}else{
	    	sb.append("<img id='pic' src=\""+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/zwtp1.jpg"+"\">");
	    }
		out.print(sb.toString());
%>

