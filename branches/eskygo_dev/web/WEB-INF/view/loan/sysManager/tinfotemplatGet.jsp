<%@page import="com.deelon.loan.model.sysManager.Tinfotemplat"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=Tinfotemplat.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=Tinfotemplat.TABLE_ALIAS%>明细</span>
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
							<th>模板名称:</th>	
							<td>${tinfotemplat.templateName}</td>
							<th>通知类型（1=网站、2=系统、3=APP）:</th>	
							<td>${tinfotemplat.serviceType}</td>
						</tr>
						<tr>
							<th>通知方式：1=SMS，2=EMAIL，3=WEB:</th>	
							<td>${tinfotemplat.infoType}</td>
							<th>通知对象：:</th>	
							<td>${tinfotemplat.infoFlag}</td>
						</tr>
						<tr>
							<th>标题：对Web和Email有效:</th>	
							<td>${tinfotemplat.header}</td>
							<th>消息内容:</th>	
							<td>${tinfotemplat.messasge}</td>
						</tr>
						<tr>
							<th>创建用户:</th>	
							<td>${tinfotemplat.creator}</td>
							<th>创建时间:</th>	
							<td>${tinfotemplat.createTime}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>