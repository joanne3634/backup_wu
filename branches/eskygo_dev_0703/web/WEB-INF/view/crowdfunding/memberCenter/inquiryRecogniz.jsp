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
	<title>项目管理</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/inquiryRecogniz.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="inquiryRecogniz" class="all-100 push-center">
	<div class="title">
		<h3><i class="fa fa-star"></i> 认投资格</h3>
	</div>
	<div class="wordsContent">
	<c:if test="${isAskPrice==0}">
			 <p>您暂时还没有认投资格！</p>
			 <p>缴纳<%=application.getAttribute("ASK_PRICE_SINCERITY") %>元认筹诚意金，即可获得对任意项目的认筹机会
			 <a href="javascript:void(0);" onclick="toApplyEnqPage()">>>立即获取资格</a></p>
	</c:if>
	<c:if test="${isAskPrice==1}">
			 <p>温馨提示：</p>
			 <p>① 您已获得认投资格 <a href="${ctx}/index-web.jsp" target="_top">>>现在去认投</a></p>
			 <p>② 温馨提示：每反悔一次，您需要重新缴纳诚意金才能获得认投机会！ </p>
	</c:if>
	</div>
	<div class="ink-tabs top">
		<ul class="tabs-nav">
			<li class="active"><a class="tabs-tab" href="${ctx}/crowdfunding/memberCenter/toEnquiryRecords.ht" target="projectIframe">诚意金缴纳记录</a></li>
			<li><a class="tabs-tab" href="${ctx}/crowdfunding/memberCenter/toPullBackRecords.ht" target="projectIframe">我的反悔记录</a></li>
		</ul>
		<div class="tabs-content">
			<iframe src="${ctx}/crowdfunding/memberCenter/toEnquiryRecords.ht" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="projectIframe" name="projectIframe" onLoad="iFrameHeight()" ></iframe>
		</div>
	</div>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/inquiryRecogniz.js" />"></script>
</body>
</html>
