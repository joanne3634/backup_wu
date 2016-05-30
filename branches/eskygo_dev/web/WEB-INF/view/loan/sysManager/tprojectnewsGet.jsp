<%@page import="com.deelon.crowdfunding.model.backstage.TcprojectNews"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TcprojectNews.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=TcprojectNews.TABLE_ALIAS%>明细</span>
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
							<th>项目ID:</th>	
							<td>${tprojectNews.projectId}</td>
							<th>类型:1项目动态 2项目信息披露:</th>	
							<td>${tprojectNews.pntypeId}</td>
						</tr>
						<tr>
							<th>标题:</th>	
							<td>${tprojectNews.pntitle}</td>
							<th>内容:</th>	
							<td>${tprojectNews.pncontent}</td>
						</tr>
						<tr>
							<th>创建人:</th>	
							<td>${tprojectNews.creator}</td>
							<th>创建时间:</th>	
							<td>${tprojectNews.createTime}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>