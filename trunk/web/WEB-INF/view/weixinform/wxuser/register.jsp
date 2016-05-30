<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.deelon.core.util.AppUtil" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>注册</title>
	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
</head>
<body>
	<div class="top text-white text-center">用户注册<span onclick="loginPage();">登录</span></div>
	<form id="register_form" action="${ctx}/weixin/wxuser/register.ht" method="post">
		<div class="textdiv bodersolid background2">
		<label for="username" class="labeltext text-center text-black">用户名</label>
	 		<input type="text" name="loginName" id="loginName" class="textinput fintleft1 text-black" placeholder="5-12字符可用中文"/>
	 	</div>
	
		<div class="textdiv bodersolid background2">
		<label for="password" class="labeltext text-center text-black">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
	 		<input type="password" name="loginPwd" id="loginPwd" class="textinput fintleft1 text-black" placeholder="建议大小写混合"/>
	 	</div>
	
	 	<div class="textdiv bodersolid background2" style="position: relative;">
			<label for="mobile" class="labeltext text-center text-black">手&nbsp;&nbsp;机</label>
	 		<input type="text" name="mobile" id="mobile" class="textinput fintleft1 text-black" placeholder="常用手机号码"/>
			<div class="authcode background3 radiu text-gray text-center" id="markBtn" onclick="requestCheckMark()">获取验证码</div>
	 	</div>
	 	<div class="textdiv bodersolid background2">
			<label for="code" class="labeltext text-center text-black">验证码</label>
	 		<input type="text" name="code" id="code" class="textinput fintleft1 text-black" placeholder="请输入收到的验证码" disabled="disabled"/>
	 	</div>
	
		<div class="textdiv background1 text-white text-center lbutton" onclick="register_form_submit();">
			确认注册
		</div>
	</form>
</body>
<script type="text/javascript">
var checkMarkRequesting = false;
var hasRequest = false;
var regex = /^(((1[3456789][0-9]{1})|(15[0-9]{1}))+\d{8})$/;
var counterInterval;
var count = 60;
function register_form_submit(){
	$.ajax({
		url : "${ctx}/weixin/wxuser/register.ht",
		type : 'post',
		data : $('#register_form').serialize(),
		dataType : 'json',
		success : function(rsp) {
			if(rsp.result){
				window.location = "${ctx}/weixin/wxmyaccount/wxmyaccountPage.ht";
			}else{
				alert(rsp.message);
			}		
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("注册异常，请重试");
		}
	});
}
function requestCheckMark(){
	if(checkMarkRequesting){
		return;
	}
	var photeNum = $("#mobile").val();
	if(!regex.test(photeNum)){
		alert("你输入的手机号码不正确！");
		return;
	}
	counterInterval = setInterval(function(){
		count --;
		if(count<=0){
			$("#markBtn").html("获取验证码");
			clearInterval(counterInterval);
			checkMarkRequesting=false;
			count=60;
			return;
		}
		$("#markBtn").html(count+"秒后重试");
	},1000);
	checkMarkRequesting = true;
	$.ajax({
		url:"${ctx}/weixin/wxuser/sendWeixinRegisterCheckCode.ht",
		data:"phone="+photeNum,
		dataType:"json",
		type:'post',
		success:function(rsp){
			if(rsp.result){
				hasRequest = true;
				$("#code").removeAttr("disabled");
			}else{
				alert(rsp.message);
			}
		},
		error:function(){
			alert("网络异常，请稍后重试！");
		}
	});
}
function loginPage(){
	window.location.href = "${ctx}/loginWeixin.jsp";
}
	</script>
</html>