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
  <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/wangjimima2-mobile.css" />" type="text/css">
  <script>
    var _error="${error}";
  </script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="findByQuestion" class="ink-grid push-center all-60">

  <div class="zhmm-inputlist mbzh-btn">
    <div class="zhmm-buzhouzhiyin align-center">
      <div class="zhmm-buzounum one">
        <div>1</div>
        填写绑定邮箱
      </div>
      <div class="zhmm-fengexian one"></div>
      <div class="zhmm-buzounum one">
        <div>2</div>
        验证邮箱
      </div>
      <div class="zhmm-fengexian"></div>
      <div class="zhmm-buzounum">
        <div>3</div>
        重置密码
      </div>
    </div>
    <div class="formContainer">
      <div class="desc align-center">验证邮件已发送至 <span>${email }</span>，若收件箱没有邮件，请尝试在垃圾邮件夹找回。</div>
      <form action="${ctx }/safe/valiBindEmailcode.ht" id="email_verify_form" method="post" class="ink-form push-center all-80">
        <input type="hidden" id="userId" name="userId" value="${userId }"/>
        <input id="email" name="email" value="${email }" type="hidden"/>
        <fieldset>
          <div class="control-group required gutters">
            <label for="email_code" class="all-25 align-right">
              收到的验证码：
            </label>
            <div class="control all-75">
              <input type="text" id="email_code" name="email_code">
            </div>
          </div>
        </fieldset>
        <div class="control-group gutters">
          <label class="all-25">&nbsp;</label>
          <div class="control all-75">
            <input id="submitBtn" class="ink-button blue-dark" type="submit" value="确 定">
          </div>
        </div>
      </form>
    </div>
  </div>
  <div style="margin-bottom:35px;text-align:center;font-size:14px;color:#999;">没收到邮件？请联系客服<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></div>
</div>
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/wangjimima2-email.js" />"></script>
</body>
</html>