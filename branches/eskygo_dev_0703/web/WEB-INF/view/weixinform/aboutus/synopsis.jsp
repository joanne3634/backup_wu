<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.deelon.core.util.AppUtil" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>公司简介</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>

	<body>
		
		<div class="advertisement text-center">
		<img src="${ctx }/wuyouchou/system/sysFile/getFileById.ht?fileId=${fileid}" class="advertiseimg" width="90%"> 
		</div>

		<div class="synopsis text-black">
			<p>${cms.contentText}</p>
		</div>
	</body>
</html>