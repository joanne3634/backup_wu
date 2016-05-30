<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%
    TUser user = TUserUtil.getLogUser(request);
%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>收藏的项目</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp"%>
    <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/collectProj.css" />" type="text/css">
    <script type="text/javascript">
        var _ctx="${ctx}", isLogin,  groupId = '${user.groupId}';
    </script>
</head>
<body class="iframe">
<div id="collectProj" class="all-100">
    <c:if test="${not empty collectProjectInfos }">
    <ul class="projectList">
    <c:forEach var="collectProjectInfo" items="${collectProjectInfos}">
        <li>
            <div class="detail">
                <div class="avatar">
                    <c:if test="${empty collectProjectInfo.myPhoto}">
                        <img src="${ctx }/crowdfunding/resources/img/head_blank.png">
                    </c:if>
                    <c:if test="${not empty collectProjectInfo.myPhoto}">
                        <img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${collectProjectInfo.myPhoto}">
                    </c:if>
                    <button onclick="sendMessage('${collectProjectInfo.creator}','${collectProjectInfo.projectId}');" class="ink-button blue"><i class="fa fa-plus"></i> 发私信</button>
                </div>
                <div class="info">
                    <h4 class="title"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${collectProjectInfo.projectId}" target="_blank">${collectProjectInfo.pname}</a></h4>
                    <label class="status red"><f:description itemValue="${collectProjectInfo.pstateId}" nodeKey="xmzt" /></label>
                    <div class="filter-info">
                        <span><i class="fa fa-map-marker"></i> ${collectProjectInfo.pprovincesName }<c:if test="${collectProjectInfo.pcityIname!='市辖区' && collectProjectInfo.pcityIname!='县' }">${collectProjectInfo.pcityIname }</c:if></span>
                        <span><i class="fa fa-list-ul"></i> <f:description itemValue="${collectProjectInfo.pindustry}" nodeKey="PIND" /></span>
                        <span><i class="fa fa-sun-o"></i> <f:description itemValue="${collectProjectInfo.pstage}" nodeKey="PTYPE" /></span>
                    </div>
                    <div class="count">
                        <div class="all-33">
                            <p>融资金额：<em>${collectProjectInfo.pfinancingAmount} 万</em></p>
                            <p>领投金额：<em>${collectProjectInfo.leaderAmount} 万</em></p>
                        </div>
                        <div class="all-33">
                            <p>已融金额：<em>${collectProjectInfo.pinvestAmount} 万</em></p>
                            <p>跟投金额：<em>${collectProjectInfo.followAmount} 万</em></p>
                        </div>
                        <div class="all-33">
                            <p>认投完成率：<em>${collectProjectInfo.pcomplete}%</em></p>
                            <p>被投资人约谈数：<em>${collectProjectInfo.aboutNum} 次</em></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="buttons align-right">
                <c:if test="${collectProjectInfo.pstateId eq '3'}">
                    <a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${collectProjectInfo.projectId}" target="_blank" class="ink-button blue"><i class="fa fa-users"></i> 我要领投</a>
                    <a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${collectProjectInfo.projectId}" target="_blank" class="ink-button blue"><i class="fa fa-money"></i> 我要跟投</a>
                    <button onclick="aboutEntrepre('${collectProjectInfo.creator}','${collectProjectInfo.projectId}');" class="ink-button blue"><i class="fa fa-comments"></i> 约谈项目方</button>
                </c:if>
                <button onclick="cancelCollect('${collectProjectInfo.attentionId}');" class="ink-button blue"><i class="fa fa-heart"></i> 取消收藏</button>
            </div>
        </li>
    </c:forEach>
    </ul>
    </c:if>
    <c:if test="${empty collectProjectInfos }">
        <div class="no-content">暂无内容!</div>
    </c:if>
    <form id="pageForm" name="pageForm" action="">
    <pageTag:pagination form="pageForm"/>
    </form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/collectProj.js" />"></script>
</body>
</html>