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
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 项目动态</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/proDynamic.css" />" type="text/css">
	<script type="text/javascript">
		<%--if (top != this) {--%>
		<%--//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面--%>
		<%--top.location = '${ctx}/index-web.jsp';--%>
		<%--}--%>
	</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="proDynamic" class="ink-grid push-center all-90">
	<div class="column-group horizontal-gutters">
		<div class="all-70" >
			<div class="proDynamicList">
				<form action="${ctx }/tcproject/ProjectDynamic/ProjectDynamicList.ht" name="pageForm" id="pageForm">
					<ul class="proDynamicUL">
						<c:forEach items="${TCPList}" var="list">
							<li class="proDynamicLI">
								<div class="item">
									<div class="all-40">
										<div class="img-container">
											<a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list.newsId}" target="_blank">
												<c:if test="${not empty list.fileId}">
													<pageTag:ProjectDynamicDetail menupath="${list.fileId}"/>
												</c:if>
												<c:if test="${empty list.fileId && not empty list.pic}">
													<pageTag:ProjectDynamicDetail menupath="${list.pic}"/>
												</c:if>
												<c:if test="${empty list.fileId && empty list.pic}">
													<img class="f_l PrDyImg"  src="${ctx }/crowdfunding/Skin/Default/images/zwtp1.jpg"/>
												</c:if>
											</a>
										</div>
									</div>
									<div class="all-60">
										<div class="newsINfo">
											<p class="title"><a title="${list.pntitle }" href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list.newsId}" target="_Blank">
													${list.pntitle }
											</a></p>
											<h3><a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${list.projectId }" target="_Blank">${list.pname }</a></h3>
											<p class="desc">
												${list.pncontent}
												<a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list.newsId }" target="_Blank" >[详细]</a>
											</p>
											<p class="publisher">
												<span class="time">发布时间：<fmt:formatDate value="${list.createTime }" pattern="yyy-MM-dd HH:mm"/></span>
												<span class="author">发布者：<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${list.creator }"/></span>
											</p>
											<p class="push-right">
												<c:if test="${empty projectId}">
													<a href="${ctx }/tcproject/ProjectDynamic/ProjectNewList.ht?projectId=${list.projectId }" target="_Blank" >>>该项目所有动态</a>
												</c:if>
											</p>
										</div>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
					<pageTag:pagination form="pageForm"/>
				</form>
			</div>
		</div>
		<div class="all-30">
			<div class="proDynamic-order">
				<h4 class="titleName">热门项目动态</h4>
				<ul>
					<c:forEach items="${TCPList2}" var="list" varStatus="i">
						<c:if test="${i.index < 10 }">
							<li>
								<a title="${list.pntitle }" href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list.newsId}" target="_Blank" >
										${list.pntitle }
								</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>

	</div>
</div>
<input type="hidden" id="a1">
<input type="hidden" id="a2">
<input type="hidden" id="a3">
<input type="hidden" id="orderBy" value="${orderBy }">
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/financingProjectByWhere.js" />"></script>
</body>
</html>

