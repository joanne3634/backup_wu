<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags/helpers"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 跟投人列表</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/investPersonList.css" />" type="text/css">
	<script type="text/javascript">
		if (top != this) {
			//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
			top.location = '${ctx}/index-web.jsp';
		}
	</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="investPersonList" class="ink-grid push-center all-90">
	<div class="column-group horizontal-gutters">
		<div class="xlarge-70 large-65 medium-65 small-65 tiny-100">
			<div class="title">
				<h3>${tcproject.pname }</h3>
                <span>
                <c:choose>
					<c:when test="${tcproject.pcomplete >= RECRUITMENT_LIMIT_FINANCING}">
						已停止融资
					</c:when>
					<c:when test="${tcproject.pneedWarmUp == 1}">
						预热中
					</c:when>
					<c:otherwise>
						<f:description nodeKey="xmzt" itemValue="${tcproject.pstateId }"/>
					</c:otherwise>
				</c:choose>
                </span>
			</div>
			<div class="title-count">
				<span>开标时间：<fmt:formatDate value="${tcproject.popenDate }" pattern="yyyy-MM-dd HH:mm"/></span>
			</div>
			<div class="investList">
				<form id="pageForm" name="pageForm" action="">
					<div class="all-100">
						<ul id="investorList">
							<c:forEach items="${listInV }" var="vo" varStatus="status">
								<c:if test="${vo.piisCheck==1  }">
								<li class="investorInfo">
									<div class="item">
										<div class="img-container all-20">
											<c:choose>
												<c:when test="${empty vo.fileId}">
													<%--<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait.png">--%>
													<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
												</c:when>
												<c:otherwise>
													<img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${vo.myPhoto}">
												</c:otherwise>
											</c:choose>
												<input type="hidden" id="creator_${status.count }_${status.count }" name="creator" value="${vo.userId}">
												<input type="hidden" id="creatorName_${status.count }_${status.count }" name="creatorName" value="${vo.loginName }">
												<a onclick="loadPagesSendMsgremind('${vo.userId}')" class="ink-button blue btn-median"><i class="fa fa-plus"></i>发私信</a>
										</div>
										<div class="detailInfo all-60">
											<h3>${vo.loginName }</h3>
											<p>认投时间：${vo.piinvestTimeS }</p>
											<p>投资理由：${vo.pireasons }</p>
										</div>
										<div class="investMoney all-20">
											<div class="contents all-60 align-center">
												<p>跟投金额</p>
												<p>${vo.piinvest }万</p>
											</div>
										</div>
									</div>
								</li>
								</c:if>
							</c:forEach>
						</ul>
						<input type="hidden" id="projectId" name="projectId" value="${tcproject.projectId }"/>
						<pageTag:pagination form="pageForm"/>
					</div>
				</form>
			</div>
		</div>
		<div class="xlarge-30 large-35 medium-35 small-35 tiny-0">
			<div class="entrepreneur">
				<div class="title">
					<h3>项目方</h3>
				</div>
				<div class="detail">
					<section class="avatar">
						<a href="#">
							<c:choose>
								<c:when test="${empty tcproject.myPhoto}">
									<img src="/crowdfunding/resources/img/head_blank.png">
								</c:when>
								<c:otherwise>
									<img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${tcproject.myPhoto}">
								</c:otherwise>
							</c:choose>
						</a>
						<h4>${tcproject.realName } <i class="fa fa-envelope-o" data-id="creator_1" data-value="${tcproject.creator}"></i></h4>
					</section>
					<div class="project-info">
						<section class="all-50">融资金额：${tcproject.pfinancingAmount }万</section>
						<section class="all-50 align-right">出让股份：<fmt:formatNumber value="${tcproject.psharesPercent}" pattern="###,###.##"   minFractionDigits="2" />%</section>
						<section class="all-100">单笔最少投资额：<fmt:formatNumber value="${tcproject.pinvestMinFollow/10000}" pattern="###,###"   minFractionDigits="0" />万</section>
						<section class="all-100">款项拨付方式：<f:description nodeKey="TZKPT" itemValue="${tcproject.ppayWay }"/></section>
						<section class="all-50">认投金额：<fmt:formatNumber value="${tcproject.pinvestAmount }" pattern="###,###.##"   minFractionDigits="0" />万</section>
						<section class="all-50 align-right">跟投人数：<a href="${ctx}/crowdfunding/front/toInvestPersonList.ht?projectId=${tcproject.projectId }">${tcproject.pinvestCount }人</a></section>
						<section class="all-100">
							<div class="progress-bar"><span class="progress" style="width: ${tcproject.pcomplete > 100?100:tcproject.pcomplete }%;">${tcproject.pcomplete }%</span></div>
						</section>
						<section class="all-50">认投完成率：${tcproject.pcomplete }%</section>
						<section class="all-50 align-right">剩余天数：${tcproject.lastDays }天</section>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>

<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/investPersonList.js" />"></script>
<script>

</script>
</body>
</html>