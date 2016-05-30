<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>发私信</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp"%>
    <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/sendPrivateMessages.css" />" type="text/css">
    <script type="text/javascript">
        var _ctx="${ctx}", isLogin;
    </script>
</head>
<body class="iframe">
<div id="sendPrivateMessages" class="all-100 push-center">
<c:choose>
    <c:when test="${alsnInfo eq '1'}">
        你今天已经约谈过一次了,每个项目每天只能约谈一次!
    </c:when>
    <c:otherwise>
        <form action="${ctx}/crowdfunding/front/sendPrivateMsg.ht" method="post" id="sendForm" class="ink-form">
            <fieldset>
                <div class="control-group required gutters">
                    <label for="receiverName" class="all-20 align-right">
                        <c:choose>
                            <c:when test="${type_id eq '2' }">约谈人：</c:when>
                            <c:otherwise>收信人：</c:otherwise>
                        </c:choose>
                    </label>
                    <div class="control all-80">
                        <input type="text" id="receiverName" name="receiverName" readonly="readonly" value="${receiverName }" data-rules="required">
                        <input type="hidden" id="receiverId" name="receiverId" value="${receiverId }">
                        <input type="hidden" id="projectId" name="projectId" value="${projectId }">
                        <input type="hidden" id="type_id" name="type_id" value="${type_id }">
                        <input type="hidden" id="alsnInfo" name="alsnInfo" value="${alsnInfo }">
                    </div>
                </div>
                <div class="control-group required gutters">
                    <label for="content_id" class="all-20 align-right">
                        <c:choose>
                            <c:when test="${type_id eq '2' }">约谈留言：</c:when>
                            <c:otherwise>内容：</c:otherwise>
                        </c:choose>
                    </label>
                    <div class="control all-80">
                        <c:choose>
                            <c:when test="${type_id eq '2' }"><textarea data-rules="required" rows="5"  name="content_id" id="content_id" placeholder="请输入内容,建议填写约谈理由、时间、地点、联系电话等。"></textarea></c:when>
                            <c:otherwise><textarea data-rules="required" rows="5" name="content_id"  id="content_id" placeholder="请输入内容"></textarea></c:otherwise>
                        </c:choose>
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
    </c:otherwise>
</c:choose>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/sendPrivateMessages.js" />"></script>
</body>
</html>