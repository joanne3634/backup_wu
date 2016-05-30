<%@page import="com.deelon.crowdfunding.model.backstage.Tarea"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=Tarea.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=Tarea.TABLE_ALIAS%>明细</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th>地区名称:</th>	
							<td>${tarea.areaName}</td>
							<th>助记码:</th>	
							<td>${tarea.helpCode}</td>
						</tr>
						<tr>
							<th>上级ID:</th>	
							<td>${tarea.parentId}</td>
							<th>层级:</th>	
							<td>${tarea.nodeLevel}</td>
						</tr>
						<tr>
							<th>排序:</th>	
							<td>${tarea.orderCode}</td>
							<th>邮政编码:</th>	
							<td>${tarea.areaZip}</td>
						</tr>
						<tr>
							<th>区号:</th>	
							<td>${tarea.areaCode}</td>
							<th>推荐项:</th>	
							<td>${tarea.isRecommended}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>