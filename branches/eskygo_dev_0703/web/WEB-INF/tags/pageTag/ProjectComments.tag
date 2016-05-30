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
	String projectId = menupath;
	TcprojectCommentsService tcprojectCommentsService = (TcprojectCommentsService)AppUtil.getBean(TcprojectCommentsService.class);
	TUserService tUserService = (TUserService)AppUtil.getBean(TUserService.class);
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("projectId", projectId);
	PageBean pb = (PageBean)request.getAttribute("page_bean");
	List<TcprojectComments> list = tcprojectCommentsService.getTcprojectCommentsByProId(map,pb);
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:MM");
	if(list.size() == 0){
		sb.append("<li>暂无评论！</li>");
	}else{
	for(TcprojectComments tcprojectComments : list){
		TcprojectComments t = tcprojectCommentsService.getCount(tcprojectComments.getCommentsId());
		TUser user = tUserService.getById(tcprojectComments.getCreator());
		if(t.getCount()==null){
			t.setCount(0);
		}
		sb.append("<li>");
		if(user.getMyPhoto()==""){
			sb.append("<div class=\"commentsListLeft f_l\"><img src=\'"+application.getAttribute("ctx")+"/crowdfunding/upload/getFileById.ht?path="+user.getMyPhoto()+"\'></div>");
		}else{
			sb.append("<div class=\"commentsListLeft f_l\"><img src=\'"+application.getAttribute("ctx")+"/crowdfunding/resources/img/head_blank.png\'></div>");
		}
		sb.append("<div class=\"commentsListRight f_l\">");
		sb.append("<div class=\"commentscontent\"><span>"+tcprojectComments.getCreatorLoginName()+":</span>"+tcprojectComments.getPccontent()+"</div>");
		sb.append("<div class=\"commentsTime\">");
		sb.append("评论于&nbsp;&nbsp;"+format.format(tcprojectComments.getCreteTime())+"&nbsp;&nbsp;|&nbsp;&nbsp;");
		sb.append("<img src=\'"+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/replyIcont2.png\'>");
		sb.append("<span class=\"ProjectReviewReply\" onClick=\"reply("+tcprojectComments.getCommentsId()+")\">回复</span>&nbsp;&nbsp;&nbsp;&nbsp;");
		sb.append("<img src=\'"+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/deleteIcont2.png\'>");
		sb.append("<span class=\"ProjectReviewDelete\" onclick=\"del("+tcprojectComments.getCommentsId()+")\">删除</span>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("<div class=\"ProjectReviewNo f_r\">"+t.getCount()+"</div>");
		sb.append("<div class=\"clear\"></div>");
		sb.append("</li>");
	}
	}
	out.print(sb.toString());
%>