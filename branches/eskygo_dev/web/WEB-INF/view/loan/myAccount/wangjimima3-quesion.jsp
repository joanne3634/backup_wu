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
  <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/wangjimima3step.css" />" type="text/css">
  <script>
    var _success="${success}";
  </script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="reSetPwd" class="ink-grid push-center all-60">

  <div class="zhmm-inputlist mbzh-btn">
    <div class="zhmm-buzhouzhiyin align-center" >
      <div class="zhmm-buzounum one" >
        <div>1</div>
        填写您的账号
      </div>
      <div class="zhmm-fengexian one"></div>
      <div class="zhmm-buzounum one">
        <div>2</div>
        验证问题
      </div>
      <div class="zhmm-fengexian one"></div>
      <div class="zhmm-buzounum one">
        <div>3</div>
        重置密码
      </div>
    </div>
    <div class="formContainer">
      <form action="${ctx }/safe/quesionresetpass.ht" id="reset_pass_form" method="post" class="ink-form push-center all-60">
        <fieldset>
          <div class="control-group required gutters">
            <label for="newPwd" class="all-25 align-right">
              新密码：
            </label>
            <div class="control all-75">
              <input type="password" id="newPwd" name="newPwd" data-rules="required|min_length[6]|max_length[20]|regexNumeric|regexAlpha">
            </div>
          </div>
          <div class="control-group required gutters">
            <label for="rsnewPwd" class="all-25 align-right">
              确认新密码：
            </label>
            <div class="control all-75">
              <input type="password" name="rsnewPwd" id="rsnewPwd"  data-rules="required|matches[newPwd]">
            </div>
          </div>
        </fieldset>
        <div class="control-group gutters">
          <label class="all-25">&nbsp;</label>
          <div class="control all-75">
            <input id="submitBtn" class="ink-button blue-dark" type="submit" value="确 定">
          </div>
        </div>
        <input type="hidden" id="userId" name="userId" value="${userId }"/>
        <input type="hidden" name="resetCode" value="${resetCode}"/>
      </form>
    </div>
  </div>
</div>
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/wangjimima3step.js" />"></script>
</body>
</html>