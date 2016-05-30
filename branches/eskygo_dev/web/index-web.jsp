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
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 首页</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/index-web.css" />" type="text/css">
	<script type="text/javascript">
		if (top != this) {
			//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
			top.location = '${ctx}/index-web.jsp';
		}
	</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<pageTag:AdvertisingPicture menupath="SYGGDT" />

<pageTag:warmUpProject menupath=""/><!-- 预热期项目-->
<pageTag:hotProjects menupath=""/><!--热门项目  -->
<%--
<pageTag:RecommendProject menupath="projectRecommend"/><!-- 投资推荐 -->
--%>

<div class="ink-grid push-center all-90">
	<div class="column-group horizontal-gutters">
		<pageTag:newProjectsStatus menupath=""/><!-- 最新项目动态 -->
		<pageTag:IndustryInformation menupath="HYZX"/><!--最新资讯 -->
	</div>
</div>

<%-- <pageTag:newProjects menupath=""/><!-- 最新项目 --> --%>

<%-- <pageTag:goodProjects menupath=""/><!-- 成功案例 --> --%>

<div class="ink-grid push-center all-90">
	<div class="title">
		<h3><i class="fa fa-th-large"></i> 众筹指南</h3>
		<a class="ink-button blue push-right" href="${ctx}/loan/aboutus/HelpCenterList.ht">查看更多</a>
	</div>
	<div id="site-desc" class="column-group horizontal-gutters">
		<div class="xlarge-20 large-25 medium-33 small-50 tiny-100">
			<a href="${ctx}/loan/aboutus/HelpCenterList.ht?srcurl='XSZN'">
				<div class="push-center align-center">
					<img src="<h:static type="img" src="/crowdfunding/resources/img/tzzn.png"/>">
					<h5>新手指南</h5>
				</div>			
			</a>
		</div>
		<div class="xlarge-20 large-25 medium-33 small-50 tiny-100">
			<a href="${ctx}/loan/aboutus/HelpCenterList.ht?srcurl='TZR'">
				<div class="push-center align-center">
					<img src="<h:static type="img" src="/crowdfunding/resources/img/tzrfw.png"/>">
					<h5>投资人服务</h5>
				</div>
			</a>
		</div>
		<div class="xlarge-20 large-25 medium-33 small-50 tiny-100">
			<a href="${ctx}/loan/aboutus/HelpCenterList.ht?srcurl='CYZ'">
				<div class="push-center align-center">
					<img src="<h:static type="img" src="/crowdfunding/resources/img/xmffw.png"/>">
					<h5>项目方服务</h5>
				</div>
			</a>
		</div>
		<div class="xlarge-20 large-25 medium-33 small-50 tiny-100">
			<a href="${ctx}/loan/aboutus/HelpCenterList.ht?srcurl='TZR'">
				<div class="push-center align-center">
					<img src="<h:static type="img" src="/crowdfunding/resources/img/tzlc.png"/>">
					<h5>投资流程</h5>
				</div>
			</a>
		</div>
		<div class="xlarge-20 large-25 medium-33 small-50 tiny-100">
			<a href="${ctx}/site/AboutUs/AboutUsList.ht?srcurl='site/AboutUs/AboutUs.ht'&urlname=1">
				<div class="push-center align-center">
					<img src="<h:static type="img" src="/crowdfunding/resources/img/gywyc.png"/>">
					<h5>关于无忧筹</h5>
				</div>
			</a>
		</div>
	</div>
</div>

<pageTag:CooperationUnit menupath="HZJG"/><!-- 合作机构 -->

<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/index-web.js" />"></script>
</body>
</html>