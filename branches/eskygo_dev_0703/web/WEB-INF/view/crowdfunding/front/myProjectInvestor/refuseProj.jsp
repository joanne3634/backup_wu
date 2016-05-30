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
	<title>拒绝的认投</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/perCenterTabBase.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin,  groupId = '${user.groupId}';
	</script>
</head>
<body class="iframe">
<div id="leadProj" class="all-100">
	<c:if test="${not empty leadProjectInfos }">
		<ul class="projectList">
			<c:forEach var="leadProjectInfo" items="${leadProjectInfos}">
				<li>
					<div class="detail">
						<div class="avatar">
							<c:if test="${empty leadProjectInfo.myPhoto}">
								<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
							</c:if>
							<c:if test="${not empty leadProjectInfo.myPhoto}">
								<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${leadProjectInfo.myPhoto}">
							</c:if>
							<button onclick="sendMessage('${leadProjectInfo.creator}','${leadProjectInfo.projectId}');" class="ink-button blue"><i class="fa fa-plus"></i> 发私信</button>
						</div>
						<div class="info">
							<h4 class="title"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${leadProjectInfo.projectId}" target="_blank">${leadProjectInfo.pname}</a></h4>
							<label class="status red"><f:description itemValue="${leadProjectInfo.pstateId}" nodeKey="xmzt" /></label>
							<c:if test="${leadProjectInfo.piisPay == 0 || leadProjectInfo.piisPay == '0'}">
								<label class="status red">未付款</label>
							</c:if>
							<c:if test="${leadProjectInfo.piisPay != 0 && leadProjectInfo.piisPay != '0'}">
								<label class="status red">已付款</label>
							</c:if>
							<div class="filter-info">
								<span><i class="fa fa-map-marker"></i> ${leadProjectInfo.pprovincesName }<c:if test="${leadProjectInfo.pcityIname!='市辖区' && leadProjectInfo.pcityIname!='县' }">${leadProjectInfo.pcityIname }</c:if></span>
								<span><i class="fa fa-list-ul"></i> <f:description itemValue="${leadProjectInfo.pindustry}" nodeKey="PIND" /></span>
								<span><i class="fa fa-sun-o"></i> <f:description itemValue="${leadProjectInfo.pstage}" nodeKey="PTYPE" /></span>
								<c:if test="${leadProjectInfo.piisCheck==0}">
									<span><i class="fa fa-circle-o"></i> 审核状态：未审核</span>
								</c:if>
								<c:if test="${leadProjectInfo.piisCheck==1}">
									<span><i class="fa fa-circle-o"></i>审核状态：通过</span>
								</c:if>
								<c:if test="${leadProjectInfo.piisCheck==2}">
									<span><i class="fa fa-circle-o"></i>审核状态：拒绝</span>
								</c:if>
								<c:if test="${leadProjectInfo.piTypeId!=3}">
									<span><i class="fa fa-flag"></i>认投类型：领投</span>
								</c:if>
								<c:if test="${leadProjectInfo.piTypeId==3}">
									<span><i class="fa fa-flag"></i>认投类型：跟投</span>
								</c:if>

							</div>
							<div class="count">
								<div class="clomn">
									<p>融资金额：<em>${leadProjectInfo.pfinancingAmount} 万</em></p>
									<c:if test="${leadProjectInfo.piTypeId!=3}">
										<p>领投金额：<em>${leadProjectInfo.leaderAmount} 万</em></p>
									</c:if>
									<c:if test="${leadProjectInfo.piTypeId==3}">
										<p>跟投金额：<em>${leadProjectInfo.followAmount} 万</em></p>
									</c:if>
								</div>
								<div class="clomn">
									<p>已融金额：<em>${leadProjectInfo.pinvestAmount} 万</em></p>
									<p>项目估值：<em><fmt:formatNumber value="${leadProjectInfo.pvaluationFinal }" pattern="###,###"  minFractionDigits="0"  />万</em></p>
								</div>
								<div class="clomn">
									<p>认投完成率：<em>${leadProjectInfo.pcomplete}%</em></p>
									<p>被投资人约谈数：<em>${leadProjectInfo.aboutNum} 次</em></p>
								</div>
								<div class="clomn">
									<c:if test="${leadProjectInfo.piTypeId!=3}">
										<p>我的领投金额：<em>${leadProjectInfo.myleaderAmount} 万</em></p>
									</c:if>
									<c:if test="${leadProjectInfo.piTypeId==3}">
										<p>我的跟投金额：<em>${leadProjectInfo.myfollowAmount} 万</em></p>
									</c:if>
									<!-- <p>我的估值：<em>${leadProjectInfo.pivaluation} 万</em></p> -->
								</div>
							</div>
						</div>
					</div>
					<div class="refuse">
						<h5>拒绝理由:</h5>
						<div>
							<c:choose>
								<c:when test="${leadProjectInfo.pstateId eq '7'}">${leadProjectInfo.pbreakRemark}</c:when>
								<c:otherwise>${leadProjectInfo.pidenyReason}</c:otherwise>
							</c:choose>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
	</c:if>
	<c:if test="${empty leadProjectInfos }">
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