<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.deelon.core.util.AppUtil" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>借款流程</title>
  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
</head>

<body>
	<div class="top">
	<div class="fintop"></div>
	</div>
	<div class="advertisement">
	<img src="${ctx}/styles/dlweixin/image/advertisement.png" width="100%">
	</div>

	<div class="flowcontent text-center text-gray">
		<ul>
			<li>
				<img src="${ctx}/styles/dlweixin/image/flowicont1.png">
				<div><span>1</span>发布借款</div>
			</li>
			<div class="point text-gray2">...</div>
			<li>
				<img src="${ctx}/styles/dlweixin/image/flowicont2.png">
				<div><span>2</span>担保审核</div>
			</li>
			<div class="point text-gray2">...</div>
			<li>
				<img src="${ctx}/styles/dlweixin/image/flowicont3.png">
				<div><span>3</span>平台审核</div>
			</li>
			<li>
				<img src="${ctx}/styles/dlweixin/image/flowicont4.png">
				<div><span>4</span>筹集资金</div>
			</li>
			<div class="point text-gray2">...</div>
			<li>
				<img src="${ctx}/styles/dlweixin/image/flowicont5.png">
				<div><span>5</span>订立合同</div>
			</li>
			<div class="point text-gray2">...</div>
			<li>
				<img src="${ctx}/styles/dlweixin/image/flowicont6.png">
				<div><span>6</span>收到借款</div>
			</li>
			<li>
				<img src="${ctx}/styles/dlweixin/image/flowicont7.png">
				<div><span>7</span>还本付息</div>
			</li>
			<div class="point text-gray2">...</div>
			<li>
				<img src="${ctx}/styles/dlweixin/image/flowicont8.png">
				<div><span>8</span>借款结束</div>
			</li>
		</ul>
	</div>

	<div class="clear"></div>
	<div class="textdiv background1 text-white text-center lbutton" onclick="borrowPage()">
		立即借款
	</div>
	
</body>

<script type="text/javascript">
	function borrowPage(productId){
		window.location.href = "${ctx}/weixin/wxproductsloan/productsLoanList.ht";
			//"${ctx}/weixin/wxproductsloan/project.ht?productId=" + productId;
	}
</script>
</html>