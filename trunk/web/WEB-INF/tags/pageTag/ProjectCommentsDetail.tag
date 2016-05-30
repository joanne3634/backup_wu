<%@tag import="com.deelon.loan.model.front.TUser"%>
<%@tag import="com.deelon.loan.service.front.TUserService"%>
<%@tag import="com.deelon.core.web.util.RequestUtil"%>
<%@tag import="com.deelon.core.web.query.QueryFilter"%>
<%@tag import="java.text.SimpleDateFormat"%>
<%@tag import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@tag import="com.deelon.core.page.PageBean"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.crowdfunding.service.backstage.TcprojectCommentsService"%>
<%@tag import="com.deelon.crowdfunding.model.backstage.TcprojectComments"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="取项目下的所有项目评论"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	String id = menupath;
	TUserService tUserService = (TUserService)AppUtil.getBean(TUserService.class);
		TUser user = tUserService.getById(Long.parseLong(id));
		if(user.getMyPhoto()==""){
			sb.append("<img src=\'"+application.getAttribute("ctx")+"/crowdfunding/upload/getFileById.ht?path="+user.getMyPhoto()+"\'>");
		}else{
			sb.append("<img src=\'"+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/headportrait3.png\'>");
		}
	out.print(sb.toString());
%>