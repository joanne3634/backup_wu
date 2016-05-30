<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.deelon.core.util.AppUtil" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>修改密码</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>

	<body>
		<div class="top">
		<div class="fintop"></div>
		</div>
		
		<div class="newpassword">
  		<input type="text" name="password" id="password" class="fintleft1 text-black bodersolid background2 radiu" placeholder="请输入原登录密码"/>
		
  		<input type="text" name="newpassword" id="newpassword" class="fintleft1 text-black bodersolid background2 radiu" placeholder="请输入新登录密码"/>
		
  		<input type="text" name="newpassword" id="newpassword" class="fintleft1 text-black bodersolid background2 radiu" placeholder="请再次输入新密码"/>
  		</div>
		<div class="textdiv background1 text-white text-center lbutton">修&nbsp;&nbsp;&nbsp;改</div>
		
	</body>
</html>