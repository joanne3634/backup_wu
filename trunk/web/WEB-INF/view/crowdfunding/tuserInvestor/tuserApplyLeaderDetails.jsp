<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>详细资料</title>
	<meta name="renderer" content="webkit"/>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
</head>
<body>
<!-- 投资人详细资料start -->
<div id="faqdiv"> 
<!-- <h2>孙伟的详细资料<a href="javascript:void(0);" class="close">×</a></h2> -->
<div class="faqData">
<div class="faqDataName">
	<div class="incestorRightimg">
	<c:if test="${not empty tuserApplyLeader.myPhoto }">
		<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${tuserApplyLeader.myPhoto}" height="100" width="100">
	</c:if>
	<c:if test="${empty tuserApplyLeader.myPhoto }">
		<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png" height="100" width="100">
	</c:if>	
	</div>
	<div>
		<h3>
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
		</c:if></h3>
		<p>
		<c:if test="${fn:length(tuserApplyLeader.personalRemark) > 15 }">
			${fn:substring(tuserApplyLeader.personalRemark,0,15) }...
		</c:if>
		<c:if test="${fn:length(tuserApplyLeader.personalRemark) <= 15 }">
			${tuserApplyLeader.personalRemark }
		</c:if>
		</p>
		<p>${tuserApplyLeader.provincesName }${tuserApplyLeader.cityName }</p>
	</div>
</div>
<div class="clear faqDataDetail">
<h3>详细资料</h3>
	<p>${tuserApplyLeader.applyInfo }</p>
</div>
</div>
</div>
<!-- 投资人详细资料end -->
</body>
</html>
