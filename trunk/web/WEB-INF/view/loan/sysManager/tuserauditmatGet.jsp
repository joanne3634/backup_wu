
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
				<span class="tbar-label">明细</span>
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
							<td>${tuserAuditmat.userId}</td>
							<th>材料ID:</th>	
							<td>${tuserAuditmat.materialsId}</td>
						</tr>
						<tr>
							<th>是否审核通过:</th>	
							<td>${tuserAuditmat.isPass}</td>
							<th>审核人:</th>	
							<td>${tuserAuditmat.checker}</td>
						</tr>
						<tr>
							<th>审核时间:</th>	
							<td>${tuserAuditmat.checkTime}</td>
							<th>末通过理由:</th>	
							<td>${tuserAuditmat.reasons}</td>
						</tr>
						<tr>
							<th>是否重新审核:</th>	
							<td>${tuserAuditmat.isRePass}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>