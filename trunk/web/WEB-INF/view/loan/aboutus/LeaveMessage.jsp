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
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<link rel="stylesheet"
	href="${ctx }/styles/p2p/Skin/Default/LeaveMessage.css">
<script type="text/javascript">
	function submitsave() {
		var a = $("#TUserMessageForm").serialize();
		var suburl = $("#subctx").val();
		$.ajax({
					type : 'POST',
					data : $('#TUserMessageForm').serialize(),
					dataType : 'json',
					url : suburl + "/loan/aboutus/Messagesave.ht",
					success : function(data) {
						$.ligerDialog.confirm("留言成功,是否继续操作","提示信息",function(rtn){
							if(!rtn){
								window.location.href = suburl + "/index-web.jsp";
							}else{
								window.location.href = "${ctx}/loan/aboutus/LeaveMessage.ht";
							}
						});

					/* 	var r = confirm("留言成功是否继续留言");
						if (r == true) {
							window.location.href = "${ctx}/loan/aboutus/LeaveMessage.ht";

						} else {
							window.location.href = suburl + "/index-web.jsp";
						} */
					}, 
				});
	}
</script> 
</head>
<body>
<form id="TUserMessageForm">
	<div class="con">
		<dl>
			<dt>标题</dt>
			<dd>
				<input type="text" name="messageTitle" id="messageTitle">
			</dd>
			<dt>留言类型</dt>
			<dd>
				<f:select nodeKey="LYLX" id="messageType"></f:select>
			</dd>
			<dt>留言内容</dt>
			<dd style="height: auto;">
				<textarea name="messageContent" id="messageContent" cols="60"
					rows="8"></textarea>
			</dd>
			<input type="hidden" name="subctx" id="subctx" value="${ctx }"> 
			<%
			TUser user =	(TUser)session.getAttribute("user");
			if(user==null){ 
			%>
			<input type="hidden" name="userId" id="userId"  >
			<%} else{%>
			<input type="hidden" name="userId" id="userId" value="<%=user.getUserId()%>">
			<%} %>
		</dl>
		<input id="save" type="button" value="立即提交" onclick="submitsave();">
	</div>
	</form>
	</div>