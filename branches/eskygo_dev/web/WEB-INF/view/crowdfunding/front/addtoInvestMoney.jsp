<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/includeFront/taglibs.jsp" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]> <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]> <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>追加投资金额</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp" %>
    <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/addtoInvestMoney.css" />" type="text/css">
    <script type="text/javascript">
        var _ctx = "${ctx}", isLogin;
        var __ctx='<%=request.getContextPath()%>';
        var __jsessionId='<%=session.getId() %>';
    </script>
</head>
<body class="iframe">
<div id="addtoInvestMoney" class="all-100 push-center">
    <form action="${ctx }/crowdfunding/front/doInvest.ht" method="post" id="dofrom" class="ink-form">
        <fieldset>
            <div class="control-group required gutters">
                <label for="piinvest">追加投资金额（单位:万元）：</label>
                <div class="control">
                    <input type="text" id="piinvest" name="piinvest" placeholder="请输入内容" data-rules="required|integer">
                </div>
            </div>
        </fieldset>
        <input type="hidden" id="piisLeader" name="piisLeader" value="${piisLeader }"/>
        <input type="hidden" id="pinvestMinLeader" value="${pinvestMinLeader }"/>
        <input type="hidden" id="pinvestMaxLeader" value="${pinvestMaxLeader }"/>
        <input type="hidden" id="pinvestMinFollow" value="${pinvestMinFollow }"/>
        <input type="hidden" id="pfinancingAmount" value="${pfinancingAmount }"/>
        <input type="hidden" id="investMoney" value="${investMoney }"/>
        <input type="hidden" id="checkFlag" value="${checkFlag }"/>
        <input type="hidden" id="projectId" name="projectId" value="${projectId }"/>
        <div class="push-center align-center">
            <input id="submitBtn" class="ink-button blue-dark" type="submit" value="确认完成">
            <input id="cancelBtn" class="ink-button blue-white" type="button" value="取 消">
        </div>
    </form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp" %>
<script src="<h:static type="js" src="/crowdfunding/resources/js/addtoInvestMoney.js" />"></script>
</body>
</html>