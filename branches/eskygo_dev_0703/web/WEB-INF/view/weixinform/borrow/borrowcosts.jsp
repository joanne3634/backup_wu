<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>借款费用</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>

	<body>
		<div class="borrowingcosts text-gray">
			<p>充值手续费：1% </p>
			<p>提现手续费：0.02% </p>
			<p>申请贷款，扣除担保金的比例是0.21% </p>
			<p>投资成功交易费：0.82% </p>
			<p>借款成功交易费：0.0081% </p>
			<p>逾期还款，罚息比例：0.70% </p>
			<div class="text-center">
				<img src="${ctx}/styles/dlweixin/image/gold.png">
			</div>
		</div>
	</body>
</html>