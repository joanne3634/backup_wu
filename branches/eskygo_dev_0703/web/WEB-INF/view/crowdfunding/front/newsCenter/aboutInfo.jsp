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
	<title>收件箱--约谈信</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/inBOX.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="bodyDiv" class="all-100 push-center">
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
				<th>回复</th>
				<th>发件人</th>
				<th>发送时间</th>
				<th>操作</th>
			</tr>
			</thead>
			<tbody>
			<c:if test="${empty aboutInformInfos }">
				<tr><td colspan="7"><div style="text-align:center;">暂无数据！</div></td></tr>
			</c:if>
			<c:forEach items="${aboutInformInfos }" var="aboutInformInfo" varStatus="s">
				<tr>
					<td><input type="checkbox" name="checkbox" value="${aboutInformInfo.msgRemindId }" ></td>
					<td>
						<span>${s.index+1 }</span>
						<c:if test="${aboutInformInfo.stateId==0}">
							<img src="${ctx }/crowdfunding/Skin/Default/images/newTag.gif" >
						</c:if>

					</td>
					<td style="max-width: 200px" title="${aboutInformInfo.content }">${aboutInformInfo.content }</td>
					<td>${aboutInformInfo.replyTimes}</td>
					<td>${aboutInformInfo.senderName}</td>
					<td><fmt:formatDate value="${aboutInformInfo.sendTime}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate></td>
					<td>
						<i class="fa fa-search-plus" title="查看" role="td-btn" data-type="view" data-msg-id="${aboutInformInfo.msgRemindId }"></i>
						<i class="fa fa-comment" title="约谈" role="td-btn" data-type="reply" data-msg-id="${aboutInformInfo.msgRemindId }" data-sender-name="${aboutInformInfo.senderName}"></i>
						<i class="fa fa-trash-o" title="删除" role="td-btn" data-type="delete" data-msg-id="${aboutInformInfo.msgRemindId }"></i>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<pageTag:pagination form="pageForm"/>
	</form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/inBOX.js" />"></script>
</body>
</html>