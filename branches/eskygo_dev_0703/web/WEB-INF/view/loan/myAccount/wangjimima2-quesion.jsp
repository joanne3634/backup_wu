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
  <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/wangjimima2-question.css" />" type="text/css">
  <script>
    var _error="${error}";
  </script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="findByQuestion" class="ink-grid push-center all-60">

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
      <div class="zhmm-fengexian"></div>
      <div class="zhmm-buzounum">
        <div>3</div>
        重置密码
      </div>
    </div>
    <div class="formContainer align-center ">
      <form action="${ctx }/safe/valiBindquesionAnswer.ht" id="quesion_verify_form" method="post" class="ink-form">
        <fieldset>
          <div class="control-group required gutters">
            <label for="a1" class="all-100">
              问题一：
              <f:description nodeKey="SALE_ISSUE" itemValue="${userSafe.q1 }"></f:description>?
            </label>
            <div class="control all-100">
              <input type="text" id="a1" name="a1" data-rules="required" value="${a1 }">
            </div>
          </div>
          <div class="control-group required gutters">
              <label for="a2" class="all-100">
                问题二：
                <f:description nodeKey="SALE_ISSUE" itemValue="${userSafe.q2 }"></f:description>?
              </label>
              <div class="control all-100">
                <input type="text" id="a2" name="a2" data-rules="required" value="${a2 }">
            </div>
          </div>
          <div class="control-group required gutters">
                <label for="a3" class="all-100">
                  问题三：
                  <f:description nodeKey="SALE_ISSUE" itemValue="${userSafe.q3 }"></f:description>?
                </label>
                <div class="control all-100">
                  <input type="text" id="a3" name="a3" data-rules="required" value="${a3 }">
                  <input type="hidden" id="userId" name="userId" value="${userSafe.userId }"/>
                </div>
          </div>
        </fieldset>
        <div class="control-group gutters">
          <label class="all-100">&nbsp;</label>
          <div class="control all-100">
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
<script src="<h:static type="js" src="/crowdfunding/resources/js/wangjimima2-question.js" />"></script>
</body>
</html>