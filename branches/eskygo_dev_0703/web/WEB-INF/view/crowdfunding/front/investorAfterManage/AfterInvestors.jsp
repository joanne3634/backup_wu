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
	<title>投资者-投后管理</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/AfterInvestors.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="Afterinvestors" class="all-100 push-center">
	<div class="title">
		<h3><i class="fa fa-th-list"></i> 投后管理 </h3>
	</div>
	<table class="ink-table bordered">
		<thead>
		<tr>
			<th >序号</th>
			<th >项目</th>
			<th >标题</th>
			<th >发送时间</th>
			<th >操作</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${not empty tcprojectAfterInvestorList}">
			<c:forEach items="${tcprojectAfterInvestorList }" var="pa" varStatus="i">
				<tr>
					<td >${i.index + 1 }</td>
					<td >${pa.projectName }</td>
					<td >${pa.paTitle}</td>
					<td ><fmt:formatDate value="${pa.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
					<td class="align-center">
						<button onclick="detail('${pa.afterId}')" class="ink-button blue">
							查看
						</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty tcprojectAfterInvestorList}">
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
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/AfterInvestors.js" />"></script>
</body>
</html>