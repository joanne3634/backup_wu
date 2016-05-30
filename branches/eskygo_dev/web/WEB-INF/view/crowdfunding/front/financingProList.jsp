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
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 创业项目</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/financingProList.css" />" type="text/css">
</head>
<body>
<form id="pageForm" name="pageForm" action="${ctx}/crowdfunding/front/tofinancingProList.ht">
<input type="hidden" value="${DescList}" name="DescList"/>
<input type="hidden" value="${pisRecommended}" name="pisRecommended"/>
<input type="hidden" value="${DescType}" name="DescType"/>
<input type="hidden" value="${pstage}" name="pstage"/>
<input type="hidden" value="${pcityId}" name="pcityId"/>
<input type="hidden" value="${orderBy}" name="orderBy"/>
<div class="all-100">
	<ul id="financingProList">
		<c:forEach items="${ListVo}" var="vo">
		<li>
			<div class="item">
				<span class="img-container">
					<a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId}" target="_blank">
						<c:choose>
						<c:when test="${empty vo.ppic}">
						<img src="${ctx }/crowdfunding/Skin/Default/images/case3.png">
						</c:when>
						<c:otherwise>
						<pageTag:projectPic menupath="${vo.projectId}"/>
						</c:otherwise>
						</c:choose>
					</a>
				</span>
				<div class="project-info">
					<p class="title"><a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId}" target="_blank">${vo.pname}</a></p>
					<p>融资金额：<em>${vo.pfinancingAmount }</em>万</p>
					<p>出让股份：<em>${vo.psharesPercent }%</em></p>
					<c:choose>
						<c:when test="${vo.pneedWarmUp==0}">
							<p>认投金额：<em>${vo.pinvestAmount }</em>万</p>
							<p>认投完成率：<em>${vo.pcomplete }%</em></p>
						</c:when>
					</c:choose>
				</div>
			</div>
			<div class="filter-info">
				<span class="all-33"><i class="fa fa-map-marker"></i> ${vo.pprovincesName }${vo.pcityIname }</span>
				<span class="all-33 align-center"><i class="fa fa-list-ul"></i> <f:description nodeKey="PIND"  itemValue="${vo.pindustry }"/></span>
				<span class="all-33 align-right"><i class="fa fa-sun-o">
					<input type="hidden" value="${vo.pstateId}" />
				</i>
					<c:if test="${vo.pneedWarmUp==0}">
					<c:choose>
						<c:when test="${vo.pstateId==3}">
							众筹中
						</c:when>
						<c:when test="${vo.pstateId==4 ||vo.pstateId==5||vo.pstateId==6}">
							融资成功
						</c:when>
						<c:when test="${vo.pstateId==1}">
							已提交
						</c:when>
					</c:choose>
					</c:if>
					<c:if test="${vo.pneedWarmUp==1}"> 预热中</c:if>
				</span>
			</div>
			<div class="desc" title="${vo.pdetail}">项目简介：${vo.pdetail}</div>
			<div class="date">
				<span class="release">开标时间：${vo.popenDateStr}</span>
				<span class="new">最新更新时间：<fmt:formatDate value="${vo.updateTime }" pattern="yyyy-MM-dd HH:mm"/></span>
			</div>
		</li>
		</c:forEach>
	</ul>
	<pageTag:pagination form="pageForm"/>
	<input type="hidden" id="_pro_type_name" value="${pro_type_name}"/>
</div>
</form>
<script>var isLogin = false;</script>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/financingProList.js" />"></script>
</body>
</html>