<%@page import="org.springframework.security.authentication.AuthenticationServiceException"%>
<%@page import="org.springframework.security.authentication.AccountExpiredException"%>
<%@page import="org.springframework.security.authentication.DisabledException"%>
<%@page import="org.springframework.security.authentication.LockedException"%>
<%@page import="org.springframework.security.authentication.BadCredentialsException"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="java.util.Properties"%>
<%@ page pageEncoding="UTF-8" %>
<%@page import="org.springframework.security.web.WebAttributes"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><f:description nodeKey="SYS_CONFIG" itemValue="TITLE" propertyKey="itemKey"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctx}/styles/login/login.css"></link>
<%
	Properties configProperties=(Properties)AppUtil.getBean("configproperties");
	String validCodeEnabled=configProperties.getProperty("validCodeEnabled");
%>
<script type="text/javascript">
		if(top!=this){//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
			  top.location='${ctx}/login.jsp';
		}
		
		function reload(){
			var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
			document.getElementById("validImg").src=url;
		}
		
		$(function(){
			$('.main_login').find('input').keydown(function(event){
				if(event.keyCode==13){
					$('#form-login').submit();
				}
			});
		});
		
		function dosur(){
			
			window.location.href = "${ctx }/p2p/front/retrievePwd.ht";
			//
		}
</script>
</head>
<body>
<form id="form-login" action="${ctx}/login.ht" method="post">
	<%-- <div class="top_login">
		<span class="htlogo_login l"></span>
		<span class="r"><f:description nodeKey="SYS_CONFIG" itemValue="TITLE" propertyKey="itemKey"/>&nbsp;&nbsp;&nbsp;</span>
	</div> --%>
	<center>
		<div class="main_login">
			<span class="bpmlogo_login"></span>
			<div class="content_login">
				<div class="column">
					<span>用户名:</span><br>
					<input type="text" name="username" class="login" /><br>	
				</div>
				<div class="column">
					<span>密&nbsp;&nbsp;码:</span><br>
					<input type="password" name="password"/>
				</div>	
				 <%
                          if(validCodeEnabled!=null && "true".equals(validCodeEnabled)){
                     %>
				<div class="vcode column">
					 	<div>
							<span>验证码:</span><br>
						
							<input type="text" name="validCode"  />
						</div>
						<div class="vcode_img">
							<img id="validImg" src="${ctx}/servlet/ValidCode" /><br>
							<a onclick="reload()">看不清，换一张</a>
						</div>
                        
				</div>
				   <%
                          }
                    %>
				<div class="confirm">
					<input type="checkbox" name="_spring_security_remember_me" value="1"/><span>系统记住我</span><a class="reset_btn btn r" onclick="document.getElementById('form-login').reset();">重置</a><a class="login_btn btn r" onclick="document.getElementById('form-login').submit();">登录</a>
				</div>
				
				<%
				Object loginError=(Object)request.getSession().getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
				
				if(loginError!=null ){
					String msg="";
					if(loginError instanceof BadCredentialsException){
						msg="密码输入错误";
					}
					else if(loginError instanceof AuthenticationServiceException){
						AuthenticationServiceException ex=(AuthenticationServiceException)loginError;
						msg=ex.getMessage();
					}
					else{
						msg=loginError.toString();
					}
				%>
				<div class="confirm"><span style="color:#ff0000;"><%=msg %></span></div>
				<%
				}
				%>
			</div>
		</div>
		<div class="copy"><f:description nodeKey="SYS_CONFIG" itemValue="copyright" propertyKey="itemKey"/></div>
	</center>
	
</form>
	
</body>
</html>
