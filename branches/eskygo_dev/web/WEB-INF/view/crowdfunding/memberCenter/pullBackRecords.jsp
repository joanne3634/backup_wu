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
	<title>认投资格-我的反悔记录</title>
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
			<th >项目名称</th>
			<th >认投时间</th>
			<th >认投金额</th>
			<th >项目最终估值</th>
			<th >反悔时间</th>

		</tr>
		</thead>
		<tbody>
		<c:if test="${not empty listv}">
			<c:forEach items="${listv }" var="vo" varStatus="i">
				<tr>
					<td >${vo.pname }</td>
					<td >${vo.piinvestTimeS }</td>
					<td ><fmt:formatNumber value="${vo.piinvest }" pattern="######"   minFractionDigits="2" />元</td>
					<td ><fmt:formatNumber value="${vo.pvaluationFinal*10000 }" pattern="######"   minFractionDigits="2" />元</td>
					<td ><fmt:formatDate value="${vo.piCancelTime }" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty listv}">
			<tr>
				<td colspan="5" >
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
