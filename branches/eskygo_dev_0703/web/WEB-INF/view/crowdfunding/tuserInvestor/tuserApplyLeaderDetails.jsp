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
	<title>详细资料</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/tuserApplyLeaderDetatils.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="tuserApplyLeaderDetails" class="all-100 push-center">
	<div class="upContent all-100">
		<div class="img-container all-30">
			<c:if test="${not empty tuserApplyLeader.myPhoto }">
				<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${tuserApplyLeader.myPhoto}" height="100" width="100">
			</c:if>
			<c:if test="${empty tuserApplyLeader.myPhoto }">
				<img src="${ctx }/crowdfunding/resources/img/head_blank.png" height="100" width="100">
			</c:if>
		</div>
		<div class="detailInfo all-70">
			<p>
				<c:if test="${tuserApplyLeader.isCompany eq 0 }">
					${tuserApplyLeader.realName }
				</c:if>
				<c:if test="${tuserApplyLeader.isCompany eq 1 }">
					${tuserApplyLeader.contactName }
				</c:if>
				<c:if test="${tuserApplyLeader.isLeader eq 1 }">
					<img title="领投人" src="${ctx }/crowdfunding/Skin/Default/images/lingtouren.png">
				</c:if>
				<c:if test="${tuserApplyLeader.isCompany eq 1 }">
					<img title="投资机构" src="${ctx }/crowdfunding/Skin/Default/images/touzijigou.png">
				</c:if>
				<c:if test="${tuserApplyLeader.isAskPrice eq 1 }">
					<img title="询价认投资格" src="${ctx }/crowdfunding/Skin/Default/images/xunjia.jpg">
				</c:if>
				<c:if test="${tuserApplyLeader.bindIdno eq 1 }">
					<img title="实名认证会员" src="${ctx }/crowdfunding/Skin/Default/images/shimingyanzheng.png"">
				</c:if>
			</p>
			<p>
				${tuserApplyLeader.personalRemark }
			</p>
			<p>
				${tuserApplyLeader.provincesName }${tuserApplyLeader.cityName }
			</p>
		</div>
	</div>
	<div class="downContent all-100">
		<h4>详细资料</h4>
		<p>${tuserApplyLeader.applyInfo }</p>
	</div>

</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
</body>
</html>
