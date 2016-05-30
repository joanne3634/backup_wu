<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>系统设置明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">系统设置明细</span>
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
							<th>类型：1系统设置 2 收费设置:</th>	
							<td>${tsettings.typeId}</td>
							<th>设置项代码:</th>	
							<td>${tsettings.setCode}</td>
						</tr>
						<tr>
							<th>设置项值:</th>	
							<td>${tsettings.setValue}</td>
							<th>设置项描述:</th>	
							<td>${tsettings.setDesc}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>