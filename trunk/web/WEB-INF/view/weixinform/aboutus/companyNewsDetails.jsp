<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>公司新闻详情</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
		<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
	</head>

	<body>
		<div class="synopsis text-black">
			<h3>${cms.contentTitle }</h3>
			<div><div>时间：<span>${cms.contentCreateDate}</span></div><div>来源：<span>${cms.contentAuthor}</span></div></div>
			<p>${cms.contentText}</p>
		</div>
	</body>
</html>