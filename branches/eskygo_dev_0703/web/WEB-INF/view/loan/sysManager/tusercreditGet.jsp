<%@page import="com.deelon.loan.model.front.TuserCredit"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TuserCredit.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=TuserCredit.TABLE_ALIAS%>明细</span>
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
							<th>用户ID:</th>	
							<td>${tuserCredit.userId}</td>
							<th>类型ID:</th>	
							<td>${tuserCredit.typeId}</td>
						</tr>
						<tr>
							<th>相关主键ID:</th>	
							<td>${tuserCredit.keyId}</td>
							<th>增加信用:</th>	
							<td>${tuserCredit.creditAdd}</td>
						</tr>
						<tr>
							<th>描述:</th>	
							<td>${tuserCredit.description}</td>
							<th>添加时间:</th>	
							<td>${tuserCredit.createTime}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>