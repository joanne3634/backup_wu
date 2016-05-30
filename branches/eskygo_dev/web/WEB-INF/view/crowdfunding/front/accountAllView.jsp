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
    <title>资金概览</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp" %>
    <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/accountAllView.css" />" type="text/css">
    <script type="text/javascript">
        var _ctx = "${ctx}", isLogin;
        var __ctx='<%=request.getContextPath()%>';
        var __jsessionId='<%=session.getId() %>';
    </script>
</head>
<body class="iframe">
<div id="accountAllView" class="all-100 push-center">
    <div class="title">
        <h3><i class="fa fa-money"></i> 资金概览</h3>
    </div>
    <div class="asset">
        总资产：${tcprojectInvest.piinvestTotal+askPricesincerity }<em>=</em>投资金额：
        <fmt:formatNumber value="${tcprojectInvest.piinvestTotal}" pattern="#####.##"  minFractionDigits="0" />
        <em>+</em>
        意向金：<fmt:formatNumber value="${askPricesincerity}" pattern="#####.##"  minFractionDigits="0" />
    </div>
    <table class="ink-table bordered">
        <thead>
        <tr>
            <th class="align-left">项目</th>
            <th class="align-left">投资金额</th>
            <th class="align-left">投资时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="item" varStatus="status">
            <tr>
                <td>
                    <c:choose>
                        <c:when test="${ not empty item.pname}">${fn:substring(item.pname,0,14)}...</c:when>
                        <c:otherwise> ${item.pname}</c:otherwise>
                    </c:choose>
                </td>
                <td><fmt:formatNumber value="${item.piinvest}" pattern="###,###.##"  minFractionDigits="2"  /></td>
                <td><fmt:formatDate value="${item.piinvestTime}" pattern="yyyy-MM-dd HH:mm"/></td>
            </tr>
        </c:forEach>
        <c:if test="${empty list}">
            <tr>
                <td colspan="3">您还没有投资记录!</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <form id="pageForm" name="pageForm" action="${ctx}/crowdfunding/memberCenter/getUserInverstList.ht">
        <pageTag:pagination form="pageForm"/>
    </form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp" %>
<script src="<h:static type="js" src="/crowdfunding/resources/js/accountAllView.js" />"></script>
</body>
</html>