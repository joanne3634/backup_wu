<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>认投资格-诚意金缴纳记录</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/pageCenter.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="Afterinvestors" class="all-100 push-center">
	<table class="ink-table bordered">
		<thead>
		<tr>
			<th >流水号</th>
			<th >缴纳时间</th>
			<th >缴纳金额</th>
			<th >缴纳状态</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${not empty listvo}">
			<c:forEach items="${listvo }" var="vo" varStatus="i">
				<tr>
					<td >${vo.flowCode }</td>
					<td >${vo.createTimeS }</td>
					<td ><fmt:formatNumber value="${vo.moneyInOut }" pattern="#####.##"  minFractionDigits="0" /></td>
					<td >
						<f:description nodeKey="JG" itemValue="${vo.resultId }"></f:description>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty listvo}">
			<tr>
				<td colspan="4" >
					暂无数据！
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>
	<form id="pageForm" name="pageForm" action="">
		<pageTag:pagination form="pageForm"/>
	</form>
	</div>
</body>
</html>
