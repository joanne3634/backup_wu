<%@page import="com.deelon.loan.model.TuserLog"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TuserLog.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=TuserLog.TABLE_ALIAS%>明细</span>
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
							<th>会员:</th>	
							<td><f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tuserLog.userId }"/></td>
							<th>日志类型<!-- ：1登录,2退出,3操作 -->:</th>	
							<td><f:description nodeKey="YHRZLX"  itemValue="${tuserLog.typeId}"/></td>
						</tr>
						<tr>
							<th>操作状态<!-- ID：1成功 2失败 -->:</th>	
							<td><f:description nodeKey="JG"  itemValue="${tuserLog.resultId}"/></td>
							<th>模块名称:</th>	
							<td>${tuserLog.modelName}</td>
						</tr>
						<tr>
							<th>操作名称:</th>	
							<td>${tuserLog.actionName}</td>
							<th>发生时间:</th>	
							<td><fmt:formatDate value="${tuserLog.actionTime}" pattern="yyyy-MM-dd HH:mm"/></td>
						</tr>
						<tr>
							<th>平台<!-- ：1电脑,2手机 -->:</th>	
							<td><f:description nodeKey="PTLX"  itemValue="${tuserLog.platformId}"/></td>
							<th>访问IP:</th>	
							<td>${tuserLog.clientIpdeviceId}</td>
						</tr>
						<tr>
							<th>操作描述:</th>	
							<td colspan="3">${tuserLog.remarks}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>