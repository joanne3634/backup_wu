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
	<title>发件箱</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/outBox.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="bodyDIV" class="all-100 push-center">
	<div class="title">
		<h3><i class="fa fa-send"></i> 发件箱</h3>
	</div>
	<form action=""   name="pageForm" id="pageForm" method="post">
		<div class="AfIndiv">
			<button onclick="delChecks()" class="ink-button blue"><i class="fa fa-trash-o"></i> 批量删除</button>
		</div>


		<table class="PrDyBackTable ink-table bordered">
			<thead>
			<tr>
				<th><input type="checkbox" name="InvertSelection"/></th>
				<th>序号</th>
				<th>消息内容</th>
				<th>收件人</th>
				<th>发送时间</th>
				<th>操作</th>
			</tr>
			</thead>
			<tbody>
			<c:if test="${empty outBoxData }">
				<tr><td colspan="6"><div style="text-align:center;">暂无数据！</div></td></tr>
			</c:if>
			<c:forEach items="${outBoxData }" var="outBoxData" varStatus="s">
				<tr>
					<td><input type="checkbox" name="checkbox" value="${outBoxData.msgRemindId }" ></td>
					<td>
						<span>${s.index+1 }</span>
						<c:if test="${outBoxData.stateId==0}">
							<img src="${ctx }/crowdfunding/Skin/Default/images/newTag.gif" >
						</c:if>

					</td>
					<td style="max-width: 200px" title="${outBoxData.content }">${outBoxData.content }</td>
					<td>${outBoxData.recevierName}</td>
					<td><fmt:formatDate value="${outBoxData.sendTime}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate></td>
					<td>
						<i class="fa fa-search-plus" title="查看" role="td-btn" data-type="view" data-msg-id="${outBoxData.msgRemindId }"></i>
						<i class="fa fa-trash-o" title="删除" role="td-btn" data-type="delete" data-msg-id="${outBoxData.msgRemindId }"></i>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<pageTag:pagination form="pageForm"/>
	</form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/outBox.js" />"></script>
</body>
</html>