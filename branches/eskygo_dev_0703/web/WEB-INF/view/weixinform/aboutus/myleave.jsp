 <%@page import="com.deelon.loan.model.front.TUser"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="f" uri="http://www.deelon.com/functions"%>
<%@ taglib prefix="pageTag" tagdir="/WEB-INF/tags/pageTag"%>
<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page
	import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>我的留言</title>
  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
  	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
	<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
</head>

<body>
<form id="TUserMessageForm">
<div class="formlist text-black2">
	<ul>
		<li>
			<span class="text-right">标题：</span><input type="text" class="bodersolid radiu background2" name="messageTitle" id="messageTitle">
		</li>
		<li>
			<span class="text-right">留言类型：</span><f:select nodeKey="LYLX" id="messageType"></f:select>
		</li>
		<li>
			<span class="text-right">留言内容：</span><textarea class="Myleave text-black" name="messageContent" id="messageContent" placeholder="请输入您的留言!" rows="10" ></textarea>
		</li>
	</ul>
</div>
	<%
	TUser user =	(TUser)session.getAttribute("user");
	if(user==null){ 
	%>
	<input type="hidden" name="userId" id="userId"  >
	<%} else{%>
	<input type="hidden" name="userId" id="userId" value="<%=user.getUserId()%>">
	<%} %>
	<div class="textdiv background1 text-white text-center lbutton" onclick="submitsave();">立即提交</div>
</form>
</body>

<script type="text/javascript">
function submitsave() {
	var a = $("#TUserMessageForm").serialize();
	$.ajax({
		type : 'POST',
		data : $('#TUserMessageForm').serialize(),
		dataType : 'json',
		url : "${ctx}/weixin/wxaboutus/Messagesave.ht",
		success : function(data) {
			confirm("留言成功,是否继续操作","提示信息",function(rtn){
				if(!rtn){
					window.location.href = "${ctx}/loginWeixin.jsp";
				}else{
					window.location.href = "${ctx}/weixin/wxaboutus/LeaveMessage.ht";
				}
			});

		}, 
	});
}
</script>
</html>