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
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/financingProjectByWhere.css" />" type="text/css">
	<script type="text/javascript">
		<%--if (top != this) {--%>
		<%--//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面--%>
		<%--top.location = '${ctx}/index-web.jsp';--%>
		<%--}--%>
	</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div class="ink-grid push-center all-90">
	<div class="column-group horizontal-gutters">
		<div id="filtering" class="all-100">
			<dl>
				<dt>项目性质：</dt>
				<dd>
					<a class="active" href="javascript:void(0);" onclick="loadPages('&DescType=','1')">全部</a>
					<a href="javascript:void(0);" onclick="loadPages('&DescType=0','1')">科技创新</a>
					<a href="javascript:void(0);" onclick="loadPages('&DescType=1','1')">实体经营</a>
					<a href="javascript:void(0);" onclick="loadPages('&DescType=2','1')">地产投资</a>
				</dd>
				<dt>项目属地：</dt>
				<dd>
					<a class="active" href="javascript:void(0);" onclick="loadPages('&pcityId=','2')">全部</a>
					<c:forEach items="${list}" var="vo" begin="0" end="6" varStatus="i">
						<a href="javascript:void(0);" onclick="loadPages('&pcityId=${vo.areaId}','2')">${vo.areaName }</a>
					</c:forEach>
				</dd>
				<dt>项目阶段：</dt>
				<dd>
					<c:choose>
						<c:when test="${needWarm==1}">
							<a id="All" href="javascript:void(0);" onclick="loadPages('&pstage=','3')">全部</a>
							<a class ="active" href="javascript:void(0);"onclick="loadPages('&needWarm=1','3')">预热中</a>
						</c:when>
						<c:otherwise>
							<a class ="active" id="All" href="javascript:void(0);" onclick="loadPages('&pstage=','3')">全部</a>
							<a  href="javascript:void(0);"onclick="loadPages('&needWarm=1','3')">预热中</a>
						</c:otherwise>
					</c:choose>
					<a href="javascript:void(0);" onclick="loadPages('&pstage=1','3')">众筹中</a>
					<a href="javascript:void(0);" onclick="loadPages('&pstage=2','3')">融资成功</a>
				</dd>
			</dl>
		</div>
		<div id="sorting" class="all-100">
			<ul>
				<li>开标时间</li>
				<li>融资金额</li>
				<li>完成进度</li>
				<li>认投金额</li>
			</ul>
		</div>
		<div id="iframe-container" class="all-100">
			<iframe src="${ctx }/crowdfunding/front/tofinancingProList.ht?DescList=${DescList}&orderBy=${orderBy}&pisRecommended=${pisRecommended}&needWarm=${needWarm}" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
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

