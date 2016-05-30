<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"></span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th style="width:25%;">发送人:</th>	
							<td class="form_input"><f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tuserMsgRemind.senderId }"/> </td>
						 </tr> 
						 <tr>
							<th>发送时间:</th>	
							<td class="form_input">	<fmt:formatDate value="${tuserMsgRemind.sendTime}" pattern="yyyy-MM-dd HH:mm"/></td>
						 </tr> 
						<tr>
							<th>接收人:</th>	
							<td class="form_input"><f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tuserMsgRemind.receiverId }"/> </td>
						 </tr> 
						  <tr>
						<th>状态:</th>	
							<td class="form_input"><f:description itemValue="${tuserMsgRemind.stateId}" nodeKey="LYZT" /></td> 
						 </tr> 	
						 <tr>
							<th>读取时间:</th>	
							<td class="form_input">	<fmt:formatDate value="${tuserMsgRemind.readTime}" pattern="yyyy-MM-dd HH:mm"/></td> 
						 </tr> 
						 
						<tr >
						<th>消息内容:</th>
							<td class="form_input">${tuserMsgRemind.content}</td>
						</tr>
					</table>
				</form>
		</div>
</div>
</body>
</html>