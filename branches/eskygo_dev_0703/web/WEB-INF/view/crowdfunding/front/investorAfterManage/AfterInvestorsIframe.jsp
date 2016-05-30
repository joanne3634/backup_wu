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
	<title>投后管理-投资者</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>


	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/AfterInvestorsIframe.css" />" type="text/css">
	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
	<script type="text/javascript">
		var _ctx = "${ctx}", isLogin;
		var __ctx='<%=request.getContextPath()%>';
		var __jsessionId='<%=session.getId() %>';
		var editor = CKEDITOR.replace('contentText');
	</script>
</head>
<body class="iframe">
<div id="afterInvestorsDetail" class="all-100 push-center">
	<form action="" method="post" id="sendForm" class="ink-form">
		<div class="control-group gutters">
			<label class="all-20 align-right">
				标题：
			</label>
			<div class="control all-80">
				<input type="text" readonly="readonly" value="${tcprojectAfter.paTitle }">
			</div>
		</div>
		<div class="control-group gutters">
			<label class="all-20 align-right">
				附件：
			</label>
			<div class="control all-80">
				<!-- 			<c:if test="${!empty dataList }">
				<c:forEach items="${dataList }" var ="pr">
				${pr[1]}</em><span onclick="downloadFile(${pr[0]})">下载
				</c:forEach>
				</c:if> -->
				<input type="text" name="fileId" id="fileId" class="attach" attachType="2" value="${tcprojectAfter.fileId}" />

			</div>
		</div>
		<div class="control-group gutters">
			<label class="all-20 align-right">
				内容：
			</label>
			<div class="control all-80 editorsCont">
				<div class="ckeditorDiv">
					<textarea name="contentText" id="contentText">${tcprojectAfter.paContent }</textarea>
				</div>

			</div>
		</div>
	</form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/js/ckeditor/ckeditor.js" />"></script>
<script src="<h:static type="js" src="/js/ckeditor/ckeditor_msg.js" />"></script>
<script src="<h:static type="js" src="/crowdfunding/js/jquery.attach.HelpCenter.js" />"></script>
<script type="text/javascript">

	var editor = CKEDITOR.replace('contentText');
</script>
</body>
</html>