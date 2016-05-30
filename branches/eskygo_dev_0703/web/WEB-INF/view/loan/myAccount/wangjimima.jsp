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
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 找回密码</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/wangjimima.css" />" type="text/css">
<script>
	var _error="${error}";
	var _identifying="${identifying}";
</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="findPwd" class="ink-grid push-center all-90">
		  <div id="findWays">
			  <a class="active" id="sjzh-btn" href="javascript:;">使用绑定手机找回密码</a>
			  <a id="yxzh-btn" href="javascript:;">使用绑定邮箱找回密码</a>
			  <a id="mbzh-btn" href="javascript:;">使用密保问题找回密码</a>
		  </div>
	        <div class="zhmm-inputlist sjzh-btn all-100">
				<div class="zhmm-buzhouzhiyin push-center all-45">
					<div class="zhmm-buzounum one">
						<div>1</div>
						填写绑定手机号
					</div>
					<div class="zhmm-fengexian"></div>
					<div class="zhmm-buzounum">
						<div>2</div>
						验证手机号
					</div>
					<div class="zhmm-fengexian"></div>
					<div class="zhmm-buzounum">
						<div>3</div>
						重置密码
					</div>
				</div>
				<div class="formContainer push-center all-80">
				<form id="mobile_find_pass" action="${ctx }/safe/valiBindPhone.ht" method="post" class="ink-form push-center all-70">
					<fieldset>
						<div class="control-group required gutters">
							<label for="mobile" class="all-25 align-right">
								手机号：
							</label>
							<div class="control all-75">
								<input type="text" id="mobile" name="mobile" data-rules="required|mobile" value="${mobile}">
							</div>
						</div>
						<div class="control-group required gutters">
							<label for="code" class="all-25 align-right">
								验证码：
							</label>
							<div class="control all-75">
								<input type="text" name="code" id="code" class="code" maxlength="4" data-rules="required">
								<img src="${ctx}/servlet/ValidCode" id="phoneValidImg" class="validImg" alt="看不清，换一个" onclick="reload('phoneValidImg')">
								<a id="refreshCode" class="refreshCode" href="javascript:;" onclick="reload('phoneValidImg')">看不清，换一个</a>
							</div>
						</div>
					</fieldset>
					<div class="control-group gutters">
						<label class="all-25 align-right">&nbsp;</label>
						<div class="control all-75">
							<input id="submitBtn" class="ink-button blue-dark" type="submit" value="确 定">
						</div>
					</div>
				</form>
				</div>
			</div>
			<div class="zhmm-inputlist yxzh-btn all-100" style="display:none;">
				<div class="zhmm-buzhouzhiyin push-center all-45">
					<div class="zhmm-buzounum one" >
						<div>1</div>
						填写绑定邮箱
					</div>
					<div class="zhmm-fengexian"></div>
					<div class="zhmm-buzounum">
						<div>2</div>
						验证邮箱
					</div>
					<div class="zhmm-fengexian"></div>
					<div class="zhmm-buzounum">
						<div>3</div>
						重置密码
					</div>
				</div>
				<div class="formContainer push-center all-80">
					<form action="${ctx }/safe/valiBindEmail.ht" method="post" id="email_find_pass" class="ink-form  push-center all-70">
					<fieldset>
						<div class="control-group required gutters">
							<label for="email" class="all-25 align-right">
								邮箱地址：
							</label>
							<div class="control all-75">
								<input type="email" id="email" name="email" data-rules="required|email" value="${email}">
							</div>
						</div>
						<div class="control-group required gutters">
							<label for="code" class="all-25 align-right">
								验证码：
							</label>
							<div class="control all-75">
								<input type="text" name="code" id="code" class="code" maxlength="4" data-rules="required">
								<img src="${ctx}/servlet/ValidCode" id="emailValidImg" class="validImg" alt="看不清，换一个" onclick="reload('emailValidImg')">
								<a id="refreshCode" class="refreshCode" href="javascript:;" onclick="reload('emailValidImg')">看不清，换一个</a>
							</div>
						</div>
					</fieldset>
					<div class="control-group gutters">
						<label class="all-25 align-right">&nbsp;</label>
						<div class="control all-75">
							<input id="submitBtn" class="ink-button blue-dark" type="submit" value="确 定">
						</div>
					</div>
				</form>
				</div>
			</div>
		  <div class="zhmm-inputlist mbzh-btn all-100" style="display:none;">
			<div class="zhmm-buzhouzhiyin push-center all-45" >
			  <div class="zhmm-buzounum one" >
				<div>1</div>
				填写您的账号
			  </div>
			  <div class="zhmm-fengexian"></div>
			  <div class="zhmm-buzounum">
				<div>2</div>
				验证问题
			  </div>
			  <div class="zhmm-fengexian"></div>
			  <div class="zhmm-buzounum">
				<div>3</div>
				重置密码
			  </div>
			</div>
			  <div class="formContainer push-center all-80">
				<form action="${ctx }/safe/valiBindQuesion.ht" id="quesion_find_pass" method="post" class="ink-form  push-center all-70">
				<fieldset>
					<div class="control-group required gutters">
						<label for="loginName" class="all-25 align-right">
							请输入您的账号：
						</label>
						<div class="control all-75">
							<input type="text" id="loginName" name="loginName" data-rules="required">
						</div>
					</div>
					<div class="control-group required gutters">
						<label for="code" class="all-25 align-right">
							验证码：
						</label>
						<div class="control all-75">
							<input type="text" name="code" id="code" class="code" maxlength="4" data-rules="required">
							<img src="${ctx}/servlet/ValidCode" id="quesionValidImg" class="validImg" alt="看不清，换一个" onclick="reload('quesionValidImg')">
							<a id="refreshCode" class="refreshCode" href="javascript:;" onclick="reload('quesionValidImg')">看不清，换一个</a>
						</div>
					</div>
				</fieldset>
				<div class="control-group gutters">
					<label class="all-25 align-right">&nbsp;</label>
					<div class="control all-75">
						<input id="submitBtn" class="ink-button blue-dark" type="submit" value="确 定">
					</div>
				</div>
				</form>
			  </div>
		  </div>
		  <div style="margin-bottom:35px;text-align:center;font-size:14px;color:#999;">若您无法使用上述方法找回，请联系客服400-888-5568</div>
  </div>
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/wangjimima.js" />"></script>
</body>
</html>