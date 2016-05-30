	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
						</div>	
					</div>
				</div>
				<c:forEach items="${tuserAuditMatUpload }" var="t">
					<img  src="${ctx }/loan/sysManager/tuserauditmat/getFileById.ht?fileId=${t.uploadId}"/>
					</c:forEach>
	</div>
</body>
</html>
