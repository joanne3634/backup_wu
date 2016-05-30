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
	<title>约谈的项目</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/perCenterTabBase.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin,  groupId = '${user.groupId}';
	</script>
</head>
<body class="iframe">
<div id="aboutProj" class="all-100">
	<c:if test="${not empty aboutProjectInfos }">
		<ul class="projectList">
			<c:forEach var="aboutProjectInfo" items="${aboutProjectInfos}">
				<li>
					<div class="detail">
						<div class="avatar">
							<c:if test="${empty aboutProjectInfo.myPhoto}">
								<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
							</c:if>
							<c:if test="${not empty aboutProjectInfo.myPhoto}">
								<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${aboutProjectInfo.myPhoto}">
							</c:if>
							<button onclick="sendMessage('${aboutProjectInfo.creator}','${aboutProjectInfo.projectId}');" class="ink-button blue"><i class="fa fa-plus"></i> 发私信</button>
						</div>
						<div class="info">
							<h4 class="title"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${aboutProjectInfo.projectId}" target="_blank">${aboutProjectInfo.pname}</a></h4>
							<label class="status red"><f:description itemValue="${aboutProjectInfo.pstateId}" nodeKey="xmzt" /></label>
							<div class="filter-info">
								<span><i class="fa fa-map-marker"></i> ${aboutProjectInfo.pprovincesName }<c:if test="${aboutProjectInfo.pcityIname!='市辖区' && aboutProjectInfo.pcityIname!='县' }">${collectProjectInfo.pcityIname }</c:if></span>
								<span><i class="fa fa-list-ul"></i> <f:description itemValue="${aboutProjectInfo.pindustry}" nodeKey="PIND" /></span>
								<span><i class="fa fa-sun-o"></i> <f:description itemValue="${aboutProjectInfo.pstage}" nodeKey="PTYPE" /></span>
							</div>
							<div class="count">
								<div class="clomn">
									<p>融资金额：<em>${aboutProjectInfo.pfinancingAmount} 万</em></p>
									<p>领投金额：<em>${aboutProjectInfo.leaderAmount} 万</em></p>
								</div>
								<div class="clomn">
									<p>已融金额：<em>${aboutProjectInfo.pinvestAmount} 万</em></p>
									<p>跟投金额：<em>${aboutProjectInfo.followAmount} 万</em></p>
								</div>
								<div class="clomn">
									<p>认投完成率：<em>${aboutProjectInfo.pcomplete}%</em></p>
									<p>被投资人约谈数：<em>${aboutProjectInfo.aboutNum} 次</em></p>
								</div>
							</div>
						</div>
					</div>
					<div class="buttons align-right">
						<button onclick="aboutEntrepre('${aboutProjectInfo.creator}','${aboutProjectInfo.projectId}','${aboutProjectInfo.createTimestr}');" class="ink-button blue"><i class="fa fa-comments"></i> 再次约谈</button>
					</div>
				</li>
			</c:forEach>
		</ul>
	</c:if>
	<c:if test="${empty aboutProjectInfos }">
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