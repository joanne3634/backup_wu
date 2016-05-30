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
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 免费注册</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/loginWeb.css" />" type="text/css">
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="loginWeb" class="ink-grid push-center all-90">
	<div class="column-group horizontal-gutters">
		<div class="all-50">
			<div class="login-container push-center">
				<h4>免费注册   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;已有账号？立刻<a href="${ctx}/loginWeb.jsp"><font color="#00a0e9">登陆</font></a></h4>
				<div id="register-alert" class="ink-alert basic" style="display:none;" role="alert">
                    <button class="ink-dismiss" onclick="document.getElementById('register-alert').style.display='none'">&times;</button>
                    <p>
                        <strong id="register-alert-content"></strong>
                    </p>
                </div>
				<hr>
				<div id="login-alert" class="ink-alert basic" style="display:none;" role="alert">
					<button class="ink-dismiss" onclick="document.getElementById('login-alert').style.display='none'">&times;</button>
					<p>
						<strong id="login-alert-content"></strong>
					</p>
				</div>
				<form action="${ctx}/user/register.ht" method="post" id="fastRegistForm" class="ink-form">
					<fieldset>
					<div class="control-group required gutters">
						<label for="loginName" class="all-35 align-right">用户名：</label>
						<div class="control all-65">
							<input type="text" name="loginName" id="loginName" data-rules="required">
							<input type="hidden" name="groupId" value="2"/>
						</div>
					</div>
					<div class="control-group required gutters">
						<label for="mobile" class="all-35 align-right">手机号码：</label>
						<div class="control all-65">
							<input type="text" name="mobile" id="mobile" data-rules="required">
						</div>
					</div>
					<div class="control-group required gutters">
						<label for="loginPwd" class="all-35 align-right">登陆密码：</label>
						<div class="control all-65">
							<input type="password" name="loginPwd" id="loginPwd" data-rules="required">
						</div>
					</div>
					<div class="control-group required gutters">
						<label for="rePwd" class="all-35 align-right">确认密码：</label>
						<div class="control all-65">
							<input type="password" name="rePwd" id="rePwd" data-rules="required">
						</div>
					</div>
					<div class="control-group required gutters">
						<label for="code" class="all-35 align-right">验证码：</label>
						<div class="control all-65">
							<input type="text" name="code" id="code" maxlength="4" data-rules="required" style="width:35%">
							<img src="${ctx}/servlet/ValidCode" id="validImg" alt="看不清，换一个" onclick="reload()">
						</div>
					</div>
					<div id="msgcodeDiv" class="control-group required gutters">
                        	 <label for="msgcode" class="all-35 align-right">短信验证码：</label>
							 <div class="control all-65">
							 	<input type="text" name="msgcode" id="msgcode" maxlength="6" data-rules="required" style="width:35%">
                             	<button id="btn-msgcode" type="button" class="getcode ink-button blue-light">获取校验码</button>
                             </div>
                        </div>
					<div class="control-group gutters" id="inviteCodeDiv">
						<label for="ivtCode" class="all-35 align-right">邀请码：</label>
						<div class="control all-65">
							<input type="text" name="ivtCode" id="ivtCode" maxlength="4" data-rules="required">
						</div>
					</div>
					</fieldset>
					<label id="protocol" class="all-80 align-left">
                        <input type="checkbox" checked /> 我已阅读并认可《<a  id="protocolModalTrigger" href="#">用户注册协议</a>》、《<a id="riskNoticeTrigger" href="#">风险提示书</a>》
                    </label>
					<div class="control-group gutters">
						<label class="all-25 align-right">&nbsp;</label>
						<div class="control all-75">
							<input id="submitBtn" class="ink-button blue-dark" type="submit" value="注册为投资人" style="width:45%">
							<a href="${ctx}/user/registerInit.ht?type=2">需要注册为项目方？</a>
						</div>
					</div>
					<input type="hidden" id="inviteRedPacket" value="${inviteRedPacket }" />
				</form>
			</div>
		</div>
		<div class="all-50">
			<div>
				<img src="${ctx}/crowdfunding/resources/img/red.jpg" style="width:85%">
			</div>
		</div>
	</div>
</div>
<div class="ink-shade fade">
    <div id="protocolModal" class="ink-modal fade" data-trigger="#protocolModalTrigger" data-width="80%" data-height="80%" role="dialog" aria-hidden="true" aria-labelled-by="modal-title">
        <div class="modal-body" id="modalContent">
            <iframe frameborder="0" width="100%" height="100%" src="${ctx}/loan/aboutus/TermsServiceList.ht?xieyiid=4"></iframe>
        </div>
        <div class="modal-footer">
            <div class="push-right">
                <button class="ink-button caution ink-dismiss">确 定</button>
            </div>
        </div>
    </div>
</div>

<div class="ink-shade fade">
    <div id="riskNotice" class="ink-modal fade" data-trigger="#riskNoticeTrigger" data-width="80%" data-height="80%" role="dialog" aria-hidden="true" aria-labelled-by="modal-title">
        <div class="modal-body" id="noticeContent">
            <iframe frameborder="0" width="100%" height="100%" src="${ctx}/loan/aboutus/TermsServiceList.ht?xieyiid=5"></iframe>
        </div>
        <div class="modal-footer">
            <div class="push-right">
                <button class="ink-button caution ink-dismiss">确 定</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script type="text/javascript">
	var loginPreUrl = '${loginPreUrl}';
	<%session.setAttribute("loginPreUrl", "");%>
	var referer = '<%= request.getHeader("Referer")%>';
	var serverName = '<%=request.getServerName()%>';
</script>
<script type="text/javascript">
	$(function () {
		if("0"===$("#inviteRedPacket").val()){
			$("#inviteCodeDiv").attr("style","display:none")
		}
	});
</script>
<script src="<h:static type="js" src="/crowdfunding/resources/js/fastRegist.js" />"></script>
</body>
</html>