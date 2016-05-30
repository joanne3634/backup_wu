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
    <title>资金明细查询</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp" %>
    <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/investList.css" />" type="text/css">
    <script type="text/javascript">
        var _ctx = "${ctx}", isLogin;
        var __ctx='<%=request.getContextPath()%>';
        var __jsessionId='<%=session.getId() %>';
    </script>
</head>
<body class="iframe">
<div id="investList" class="all-100 push-center">
    <div class="title">
        <h3><i class="fa fa-money"></i> 资金记录</h3>
    </div>
    <form id="pageForm" name="pageForm" class="ink-form" action="${ctx }/crowdfunding/memberCenter/toinvestList.ht">
    <div class="search">
        <div class="control-group all-35">
            <div class="column-group">
                <label for="zijinleixing" class="all-30 align-right">资金类型：</label>
                <div class="control all-70">
                    <select id="zijinleixing" name="typeId">
                        <option value="" >所有类型</option>
                        <c:forEach items="${zjldlist}" var="item" varStatus="status">
                            <option value="${item.itemValue}" <c:if test="${item.itemValue eq  typeId}">selected</c:if>>
                                    ${item.itemName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="control-group all-35">
            <div class="column-group">
                <label for="createTime_id" class="all-30 align-right">时间：</label>
                <div class="control all-70">
                    <select name="timeBucket" id="createTime_id">
                        <option value="" <c:if test="${selectEd eq '' }">selected</c:if>>所有</option>
                        <option value="1" <c:if test="${selectEd eq '1' }">selected</c:if>>一周以内</option>
                        <option value="2" <c:if test="${selectEd eq '2' }">selected</c:if>>半月以内</option>
                        <option value="3" <c:if test="${selectEd eq '3' }">selected</c:if>>一月以内</option>
                        <option value="4" <c:if test="${selectEd eq '4' }">selected</c:if>>二月以内</option>
                        <option value="5" <c:if test="${selectEd eq '5' }">selected</c:if>>三月以内</option>
                        <option value="6" <c:if test="${selectEd eq '6' }">selected</c:if>>半年以内</option>
                        <option value="7" <c:if test="${selectEd eq '7' }">selected</c:if>>一年以内</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="control-group all-30">
            <div class="column-group align-center">
                <div class="control all-100">
                    <button class="ink-button blue-dark" onclick="search();">查 询</button>
                </div>
            </div>
        </div>
    </div>
    <table class="ink-table bordered">
        <thead>
        <tr>
            <th class="align-left">日期</th>
            <th class="align-left">类型</th>
            <th class="align-left">存入/支出</th>
            <th class="align-left">余额</th>
            <th class="align-left">说明</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${listVo}" var="item" varStatus="status">
            <tr>
                <td>
                	<c:choose>
                		<c:when test="${item.resultId=='3' }"><fmt:formatDate value="${item.checkTime}" pattern="yyyy-MM-dd HH:mm"/></c:when>
                		<c:otherwise><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
                	</c:choose>
                </td>
                <td><f:description nodeKey="zjld" itemValue="${item.typeId}"/></td>
                <td><fmt:formatNumber value="${item.moneyInOut}" pattern="###,###.##"  minFractionDigits="2"  /></td>
                <td><fmt:formatNumber value="${item.moneyCurrent}" pattern="###,###.##"  minFractionDigits="2" /></td>
                <td>${item.remark}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty listVo}">
            <tr>
                <td colspan="5">暂无数据!</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <pageTag:pagination form="pageForm"/>
    </form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp" %>
<script src="<h:static type="js" src="/crowdfunding/resources/js/investList.js" />"></script>
</body>
</html>