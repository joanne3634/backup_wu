<%@page import="com.deelon.loan.model.sysManager.Tinfotemplatparam"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=Tinfotemplatparam.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=Tinfotemplatparam.TABLE_ALIAS%>明细</span>
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
							<th>参数说明:</th>	
							<td>${tinfotemplatparam.comments}</td>
							<th>创建人ID:</th>	
							<td>${tinfotemplatparam.creator}</td>
						</tr>
						<tr>
							<th>创建时间:</th>	
							<td>${tinfotemplatparam.createTime}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>