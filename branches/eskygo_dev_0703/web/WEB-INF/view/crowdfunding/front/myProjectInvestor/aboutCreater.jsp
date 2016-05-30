<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%
    String createrId = request.getParameter("createrId");
    String projectId = request.getParameter("projectId");
%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>约谈的项目</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp"%>
    <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/aboutCreater.css" />" type="text/css">
    <script type="text/javascript">
        var _ctx="${ctx}", isLogin;
    </script>
</head>
<body class="iframe">
<div id="aboutCreater" class="all-100 push-center">
    <form action="${ctx}/loan/tuserMsgRemind/saveAboutInfo.ht?createrId=<%=createrId%>&projectId=<%=projectId%>" method="post" id="sendForm" class="ink-form">
        <fieldset>
            <div class="control-group required gutters">
                <label for="receiverName" class="all-20 align-right">约谈人：</label>
                <div class="control all-80">
                    <input type="text" id="receiverName" name="receiverName" readonly="readonly" value="${receiverName }" data-rules="required">
                </div>
            </div>
            <div class="control-group required gutters">
                <label for="sendContent" class="all-20 align-right">内容：</label>
                <div class="control all-80">
                    <c:choose>
                        <c:when test="${type_id eq '2' }"><textarea data-rules="required" rows="5"  name="sendContent" id="sendContent" placeholder="请输入内容,建议填写约谈理由、时间、地点、联系电话等。"></textarea></c:when>
                        <c:otherwise><textarea data-rules="required" rows="5" name="sendContent"  id="sendContent" placeholder="请输入内容"></textarea></c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="control-group required gutters">
                <label for="code" class="all-20 align-right">验证码：</label>
                <div class="control all-80">
                    <input type="text" name="validCode" id="code" maxlength="4" data-rules="required">
                    <img src="${ctx}/servlet/ValidCode" id="validImg" alt="看不清，换一个" onclick="reload()">
                    <a id="refreshCode" href="javascript:;" onclick="reload()">看不清，换一个</a>
                </div>
            </div>
        </fieldset>
        <div class="control-group gutters">
            <label class="all-20 align-right">&nbsp;</label>
            <div class="control all-80">
                <input id="submitBtn" class="ink-button blue-dark" type="submit" value="确 定">
            </div>
        </div>
    </form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/aboutCreater.js" />"></script>
</body>
</html>