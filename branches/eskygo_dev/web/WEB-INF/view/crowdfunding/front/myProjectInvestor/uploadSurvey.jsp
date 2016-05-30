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
	<title>上传调查报告与评价</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/sendPrivateMessages.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="sendPrivateMessages" class="all-100 push-center">

	<form action="${ctx}/crowdfunding/front/tcprojectinvest/uploadSurveyFileUpload.ht" method="post" id="sendForm" class="ink-form" enctype="multipart/form-data">
		<fieldset>
			<div class="control-group required gutters">
				<label for="projectName" class="all-20 align-right">
					项目名称：
				</label>
				<div class="control all-80">
					<input type="text" id="projectName" name="projectName" readonly="readonly" value="${projectName}" data-rules="required">
					<input type="hidden" id="pi_duedoc"/>
					<input type="hidden" id="projectId" name="projectId" value="${projectId}"/>
					<input type="hidden" id="investId" name="investId" value="${investId}"/>
					<input type="hidden" id="attachmentId" name="attachmentId" value="${attachmentId}">
					<%--<input type="hidden" id="projectName" name="projectName" value="${projectName }"/>--%>
				</div>
			</div>
			<div class="control-group required gutters">
				<label for="pi_evaluationteam" class="all-20 align-right">
					团队评价：
				</label>
				<div class="control all-80">
					<textarea data-rules="required" rows="2" name="pi_evaluationteam"  id="pi_evaluationteam" placeholder="请输入创业团队评价">${pi_evaluationteam }</textarea>
				</div>
			</div>
			<div class="control-group required gutters">
				<label for="pi_evaluationproject" class="all-20 align-right">
					项目评价：
				</label>
				<div class="control all-80">
					<textarea data-rules="required" rows="2" name="pi_evaluationproject"  id="pi_evaluationproject" placeholder="请输入创业项目评价">${pi_evaluationproject }</textarea>
				</div>
			</div>
			<div class="control-group required gutters">
				<label for="fileName" class="all-20 align-right">
					附件上传：
				</label>
				<div class="control all-80"   style="width: 30%" ;>
					<input type="file"   name="file" accept="application/msword" id="fileName" data-rules="fileRequire"/>
					<button onclick="dosubmit()" type="button" class="ink-button blue-dark">上传</button>
				</div>
				<div><span  id="fileNameAtt" style="font-weight: 600;font-size: 15px;color: #666">${fileNameAtt }</span>
				<em id="_warninput3"></em>
				</div>
			</div>
		</fieldset>
		<div class="control-group gutters">
			<label class="all-20 align-right">&nbsp;</label>
			<div class="control all-80">
				<input id="submitBtn" class="ink-button blue-dark" type="submit" value="确 定">
			</div>
		</div>
	</form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/uploadSurvey.js" />"></script>
</body>
</html>