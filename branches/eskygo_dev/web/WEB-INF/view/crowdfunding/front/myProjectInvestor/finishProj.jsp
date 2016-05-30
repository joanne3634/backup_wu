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
	<title>完成的项目</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/perCenterTabBase.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin,  groupId = '${user.groupId}';
	</script>
</head>
<body class="iframe">
<div id="finishProj" class="all-100">
	<c:if test="${not empty finishProjectInfos }">
		<ul class="projectList">
			<c:forEach var="finishProjectInfo" items="${finishProjectInfos}">
				<li>
					<div class="detail">
						<div class="avatar">
							<c:if test="${empty finishProjectInfo.myPhoto}">
								<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
							</c:if>
							<c:if test="${not empty finishProjectInfo.myPhoto}">
								<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${finishProjectInfo.myPhoto}">
							</c:if>
							<button onclick="sendMessage('${finishProjectInfo.creator}','${finishProjectInfo.projectId}');" class="ink-button blue"><i class="fa fa-plus"></i> 发私信</button>
						</div>
						<div class="info">
							<h4 class="title"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${finishProjectInfo.projectId}" target="_blank">${finishProjectInfo.pname}</a></h4>
							<label class="status red"><f:description itemValue="${finishProjectInfo.pstateId}" nodeKey="xmzt" /></label>
							<div class="filter-info">
								<span><i class="fa fa-map-marker"></i> ${finishProjectInfo.pprovincesName }<c:if test="${finishProjectInfo.pcityIname!='市辖区' && finishProjectInfo.pcityIname!='县' }">${finishProjectInfo.pcityIname }</c:if></span>
								<span><i class="fa fa-list-ul"></i> <f:description itemValue="${finishProjectInfo.pindustry}" nodeKey="PIND" /></span>
								<span><i class="fa fa-sun-o"></i> <f:description itemValue="${finishProjectInfo.pstage}" nodeKey="PTYPE" /></span>
							</div>
							<div class="count">
								<div class="clomn">
									<p>融资金额：<em>${finishProjectInfo.pfinancingAmount} 万</em></p>
									<p>领投金额：<em>${finishProjectInfo.leaderAmount} 万</em></p>
								</div>
								<div class="clomn">
									<p>已融金额：<em>${finishProjectInfo.pinvestAmount} 万</em></p>
									<p>跟投金额：<em>${finishProjectInfo.followAmount} 万</em></p>
								</div>
								<div class="clomn">
									<p>认投完成率：<em>${finishProjectInfo.pcomplete}%</em></p>
									<p>被投资人约谈数：<em>${finishProjectInfo.aboutNum} 次</em></p>
								</div>
							</div>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
	</c:if>
	<c:if test="${empty finishProjectInfos }">
		<div class="no-content">暂无内容!</div>
	</c:if>
	<form id="pageForm" name="pageForm" action="">
		<pageTag:pagination form="pageForm"/>
	</form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/btnCommon.js" />"></script>
</body>
</html>