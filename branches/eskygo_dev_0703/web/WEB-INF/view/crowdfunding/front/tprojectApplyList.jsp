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
	<title>投资人管理</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/tprojectApplyList.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin,  groupId = '${user.groupId}';
	</script>
</head>
<body class="iframe">
<div id="collectProj" class="all-100">
	<c:if test="${not empty tcprojectApplyList }">
		<ul class="projectList">
			<c:forEach var="pr" items="${tcprojectApplyList}">
				<li>
					<div class="detail">
						<div class="avatar">
							<c:choose>
								<c:when test="${empty pr.ppic}">
									<img src="${ctx }/crowdfunding/Skin/Default/images/case3.png">
								</c:when>
								<c:otherwise>
									<pageTag:projectPic menupath="${pr.projectId}"/>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="info">
							<h4 class="title"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${pr.projectId}" target="_blank">${pr.pname}</a></h4>

							<div class="count">
								<div class="all-33">
									<p>融资金额：<em><fmt:formatNumber value="${pr.pfinancingAmount / 10000}" pattern="###,###"  minFractionDigits="0"  ></fmt:formatNumber>万</em></p>
									<p>接受领投：<em>${pr.agreeLead }/${pr.allLead }个</em></p>
								</div>
								<div class="all-33">
									<p>认投金额：<em><fmt:formatNumber value="${pr.pinvestAmount / 10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>万</em></p>
									<p>接受跟投：<em>${pr.agreeFollow }/${pr.allFollow }个</em></p>
								</div>
								<div class="all-33">
									<p>认投完成率：<em>${pr.pcomplete}%</em></p>
									<p>申请查看：<em>${pr.agreeView }/${pr.allView }个</em></p>
								</div>
							</div>
						</div>
					</div>
					<div class="buttons align-right">
						<button onclick="leadConfirm('${pr.projectId}');" class="ink-button blue">领投信息确认</button>
						<button onclick="voteConfirm('${pr.projectId}');" class="ink-button blue">跟投信息确认</button>
						<button onclick="projectInfoConfirm('${pr.projectId}');" class="ink-button blue">项目查看申请确认</button>
						<button onclick="investorsInfo('${pr.projectId}');" class="ink-button blue">投资人详细信息</button>
					</div>
				</li>
			</c:forEach>
		</ul>
	</c:if>
	<c:if test="${empty tcprojectApplyList }">
		<div class="no-content">暂无内容!</div>
	</c:if>
	<form id="pageForm" name="pageForm" action="">
		<pageTag:pagination form="pageForm"/>
	</form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/tprojectApplyList.js" />"></script>
</body>
</html>