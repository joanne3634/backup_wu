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
	<title>发私信</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/zijianMyProject.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="zijianMyProject" class="all-100 push-center">
<c:choose>
	<c:when test="${not empty htmlContent}">
		${htmlContent}
	</c:when>
	<c:otherwise>
	<form action="${ctx}/crowdfunding/front/sendPrivateMsg.ht" method="post" id="recomendForm" class="ink-form">
		<fieldset>
			<div class="control-group required gutters">
				<label for="receiverName" class="all-20 align-right">收信人：</label>
				<div class="control all-80">
					<input type="text" id="receiverName" name="receiverName" readonly="readonly" value="${receiverName }" data-rules="required">
					<input type="hidden" id="receiverId" name="receiverId" value="${receiverId }">
					<input type="hidden" id="type_id" name="type_id" value="4"/>
				</div>
			</div>
			<div class="control-group required gutters">
				<label for="projectId" class="all-20 align-right">我的项目：</label>
				<div class="control all-80">
					<select id="projectId" name="projectId" data-rules="required">
						<option></option>
						<c:forEach items="${projectList }" var="list">
							<option value="${list.projectId }">${list.pname }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="control-group required gutters">
				<label for="content_id" class="all-20 align-right">内容：</label>
				<div class="control all-80">
					<textarea data-rules="required" rows="5" name="content_id"  id="content_id" placeholder="请输入内容"></textarea>
				</div>
			</div>
			<div class="control-group required gutters">
				<label for="code" class="all-20 align-right">验证码：</label>
				<div class="control all-80">
					<input type="text" name="validCode" id="code" maxlength="4" data-rules="required">
					<img src="${ctx}/servlet/ValidCode" id="validImg" alt="看不清，换一个" onclick="reload()">
					<a id="refreshCode" href="javascript:;" onclick="reload()">看不清，换一个</a>
				</div>
			</div>
		</fieldset>
		<div class="control-group gutters">
			<label class="all-20 align-right">&nbsp;</label>
			<div class="control all-80">
				<input id="submitBtn" class="ink-button blue-dark" type="submit" value="确 定">
			</div>
		</div>
	</form>
	</c:otherwise>
</c:choose>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/zijianMyProject.js" />"></script>
</body>
</html>
