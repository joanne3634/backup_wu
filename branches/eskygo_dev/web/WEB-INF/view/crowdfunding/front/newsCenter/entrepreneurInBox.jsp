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
	<title>创业者--收件箱</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/inBoxPage.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="inbox" class="all-100 push-center">
	<div class="ink-tabs top">
		<ul class="tabs-nav">
			<li class="active"><a class="tabs-tab" href="${ctx}/loan/tuserMsgRemind/getMyPrivateInfos.ht" target="projectIframe">私信</a></li>
			<li><a class="tabs-tab" href="${ctx}/loan/tuserMsgRemind/myAboutInfo.ht" target="projectIframe">约谈信</a></li>
			<li><a class="tabs-tab" href="${ctx}/loan/tuserMsgRemind/myCollectPro.ht" target="projectIframe">收藏项目的投资人</a></li>
			<li><a class="tabs-tab" href="${ctx}/loan/tuserMsgRemind/mySystemInfo.ht" target="projectIframe">系统通知</a></li>

		</ul>
		<div class="tabs-content">
			<iframe src="${ctx}/loan/tuserMsgRemind/getMyPrivateInfos.ht" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="projectIframe" name="projectIframe" onLoad="iFrameHeight()" ></iframe>
		</div>
	</div>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/inBoxPage.js" />"></script>
</body>
</html>
