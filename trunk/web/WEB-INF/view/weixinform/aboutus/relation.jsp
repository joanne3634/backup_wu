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
		<title>联系我们</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	  	<script type="text/javascript" src="${ctx}/js/javascripts/jquery-1.11.1.min.js"></script>
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>

	<body>
		
		<div class="advertisement text-center">
		<img src="${ctx}/styles/dlweixin/image/advertisement3.png" class="advertiseimg" width="90%"> 
		</div>

		<div class="relation text-black2">
			<p>
				<div class="text-orange2">P2P网贷</div>
				<div><pageTag:ContactUs menupath="P2P网贷"/></div>
			</p>
			<p>
				<div class="text-orange2">公司网址</div>
				<div><pageTag:ContactUs menupath="公司网址"/></div>
			</p>
			<p>
				<div class="text-orange2">客服电话</div>
				<div><pageTag:ContactUs menupath="客服电话"/></div>
			</p>
			<p>
				<div class="text-orange2">其他联系方式</div>
				<div><pageTag:ContactUs menupath="其他联系方式"/></div>
			</p>
			<p>
				<div class="text-orange2"><img src="${ctx}/styles/dlweixin/image/2code.png"></div>
				<div>温馨提示：扫描二维码关注P2P贷微信，获取P2P贷最新新闻动态</div>
			</p>

		</div>
		
	</body>
</html>