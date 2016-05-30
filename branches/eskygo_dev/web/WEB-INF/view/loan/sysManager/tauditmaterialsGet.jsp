
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
							<th>材料类型:</th>	
							<td>${tauditmaterials.typeId}</td>
							<th>材料名称:</th>	
							<td>${tauditmaterials.name}</td>
						</tr>
						<tr>
							<th>材料说明:</th>	
							<td>${tauditmaterials.description}</td>
							<th>是否必须的:</th>	
							<td>${tauditmaterials.isMust}</td>
						</tr>
						<tr>
							<th>是否需要审核:</th>	
							<td>${tauditmaterials.isAudit}</td>
							<th>审校通过后增加信用:</th>	
							<td>${tauditmaterials.creditAdd}</td>
						</tr>
						<tr>
							<th>是否要上传:</th>	
							<td>${tauditmaterials.isUpload}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>