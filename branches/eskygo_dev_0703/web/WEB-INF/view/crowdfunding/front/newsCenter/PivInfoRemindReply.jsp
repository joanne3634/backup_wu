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
	<title>私信回复</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/sendNewMessage.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="sendNewMeg" class="all-100 push-center">
	<div class="content">
		<form action="${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht?replyId=${replyId}&receiverName=${receiverName }&isReply=1" method="post" id="sendForm" class="ink-form">
			<fieldset>
				<div class="control-group required gutters">
					<label for="receiverName" class="all-15 align-left">
						<c:choose>
							<c:when test="${type_id eq '2' }">约谈人：</c:when>
							<c:otherwise>收信人：</c:otherwise>
						</c:choose>
					</label>
					<div class="control all-70">
						<input type="text" id="receiverName" readonly name="receiverName" value="${receiverName }" data-rules="required">
					</div>
				</div>
				<div class="control-group required gutters">
					<label for="sendContent" class="all-15 align-left">
						<c:choose>
							<c:when test="${type_id eq '2' }">约谈留言：</c:when>
							<c:otherwise>内容：</c:otherwise>
						</c:choose>
					</label>
					<div class="control all-70">
						<c:choose>
							<c:when test="${type_id eq '2' }"><textarea data-rules="required" rows="5" name="sendContent"  id="sendContent" placeholder="请输入内容,建议填写约谈理由、时间、地点、联系电话等。"></textarea></c:when>
							<c:otherwise><textarea data-rules="required" rows="5" name="sendContent"  id="sendContent" placeholder="请输入内容"></textarea></c:otherwise>
						</c:choose>
					</div>
				</div>
			</fieldset>
			<div class="control all-100 align-center">
				<input id="submitBtn" class="ink-button blue" type="submit" value="确 定">
			</div>
		</form>
	</div>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/PivInfoRemindReply.js" />"></script>
</body>
</html>