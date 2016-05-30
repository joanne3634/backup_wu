<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]> <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]> <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<%
		TUser  u=TUserUtil.getLogUser( request );
		if(null!=u){
			response.sendRedirect(request.getContextPath()+"/index-web.jsp");
		}
	%>
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 用户登录</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/loginWeb.css" />" type="text/css">
	<script type="text/javascript">
		if (top != this) {
			//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
			top.location = '${ctx}/index-web.jsp';
		}
	</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="loginWeb" class="ink-grid push-center all-90">
	<div class="column-group horizontal-gutters">
		<div class="all-50">
			<div class="login-container push-center">
				<h3 class="title">会员登录</h3>
				<div id="login-alert" class="ink-alert basic" style="display:none;" role="alert">
					<button class="ink-dismiss" onclick="document.getElementById('login-alert').style.display='none'">&times;</button>
					<p>
						<strong id="login-alert-content"></strong>
					</p>
				</div>
				<form action="${ctx}/user/login.ht" method="post" id="loginForm" class="ink-form" onkeydown="login_form_submit_enter_event(event)">
					<fieldset>
					<div class="control-group required gutters">
						<label for="loginName" class="all-25 align-right">用户名：</label>
						<div class="control all-75">
							<input type="text" name="loginName" id="loginName" data-rules="required">
						</div>
					</div>
					<div class="control-group required gutters">
						<label for="loginPwd" class="all-25 align-right">密码：</label>
						<div class="control all-75">
							<input type="password" name="loginPwd" id="loginPwd" data-rules="required">
						</div>
					</div>
					<div class="control-group required gutters">
						<label for="code" class="all-25 align-right">验证码：</label>
						<div class="control all-75">
							<input type="text" name="code" id="code" maxlength="4" data-rules="required">
							<img src="${ctx}/servlet/ValidCode" id="validImg" alt="看不清，换一个" onclick="reload()">
							<a id="refreshCode" href="javascript:;" onclick="reload()">看不清，换一个</a>
						</div>
					</div>
					<span class="all-25">&nbsp;</span>
					<div id="status" class="all-75">
						<a class="push-left" href="${ctx }/safe/wangjimimapage.ht">忘记密码</a>
					</div>
					</fieldset>
					<div class="control-group gutters">
						<label class="all-25 align-right">&nbsp;</label>
						<div class="control all-75">
							<input id="submitBtn" class="ink-button blue-dark" type="submit" value="登 录">
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="all-50">
			<div class="login-register align-center">
				<h3>还没有无忧筹账号？一分钟免费注册！rwee2qwfesfsfe</h3>
				<div class="all-50">
					<a class="ink-button blue-dark push-right" href="${ctx }/user/registerInit.ht?type=2">投资方注册</a>
				</div>
				<div class="all-50">
					<a class="ink-button blue-dark push-left" href="${ctx }/user/registerInit.ht?type=1">项目方注册</a>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/loginWeb.js" />"></script>
<script type="text/javascript">
	var loginPreUrl = '${loginPreUrl}';
	<%session.setAttribute("loginPreUrl", "");%>
	var referer = '<%= request.getHeader("Referer")%>';
	var serverName = '<%=request.getServerName()%>';
</script>
</body>
</html>