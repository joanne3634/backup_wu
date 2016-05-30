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
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
						<th>标题:</th>	
							<td class="form_input">${tuserSuccessstory.subject}</td>  
							<th>分享人:</th>	
							<td class="form_input"><f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tuserSuccessstory.userId }"/></td>
						  </tr> 
						<tr>
						<tr><th>创建时间:</th>	
							<td class="form_input" colspan="3"><fmt:formatDate value="${tuserSuccessstory.createTime}" pattern="yyyy-MM-dd"/></td>
						  </tr> 
						<tr>
						<th>消息内容:</th>	
							<td class="form_input" colspan="3">${tuserSuccessstory.shareContent}</td>
						</tr>
					</table>
				</form>
		</div>
</div>
</body>
</html>