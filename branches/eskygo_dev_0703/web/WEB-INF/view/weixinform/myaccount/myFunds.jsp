<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>资金管理</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	  	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>

	<body>
		<div class="top text-white text-center">我的账户<span onclick="wxloginout();">退出登录</span></div>

		<div class="payment">
			<div class="payusername text-gray">
				<div class="payimg"></div>
				<div>
					<p ><span class="payname text-black2">${tUser.realName}</span>安全等级：<span class="text-orange2">${level}</span></p>
					<p >用户名：${tUser.loginName}</p>
				</div>
				<span class="payicont">〉</span>
			</div>
			</div>
			<div class="fundsboder borderdashed"></div>
			<div class="payment">
			<div class="payListli text-black2">
				<ul>
					<li class="boderbottom text-left"><div class="payListliicont payListliicont1"></div><span class="payListspan">我的资产</span>
					<span class="leftspan"><span class="text-orange2">${userFunds.balance}</span>元</span></li>
					<li class="boderbottom text-left"><div class="payListliicont payListliicont2"></div><span class="payListspan">可用余额</span>
					<span class="leftspan"><span class="">${userFunds.available}</span>元</span></li>
					<li class="boderbottom text-left"><div class="payListliicont payListliicont2"></div><span class="payListspan">冻结余额</span>
					<span class="leftspan"><span class="">${userFunds.freeze}</span>元</span></li>
					<div class="clear"></div>
				</ul>
			</div>
			</div>
			<!-- <div class="fundsbutton text-center text-white">
				<div class="background4 radiu">充值</div>
				<div class="background7 radiu">提现</div>
			</div> -->
	</body>
	<script type="text/javascript">
	function wxloginout(){
		window.location.href = "${ctx}/weixin/wxuser/loginout.ht";
	}
	</script>
</html>