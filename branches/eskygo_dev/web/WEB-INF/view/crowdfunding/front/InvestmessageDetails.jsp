<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>投资资讯详情</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/investmessage.css">
</head>
<body>
	<!-- <div style="height:191px;overflow: hidden;">
	</div> -->
	<%@ include file="/crowdfunding/head.jsp"%>
	<div class="window">
		<div class="InMeDeLeft f_l">
			<h6>所在位置：首页 > 投资资讯 > 正文</h6>
			<h2>${cms.contentTitle }</h2>
			<h5>发布时间：<span><fmt:formatDate value="${cms.contentUpdateDate}" pattern="yyy-MM-dd HH:mm"/></span>
				<c:if test="${not empty cms.contentAuthor}">来源：<span>${cms.contentAuthor}</span></c:if>
		    </h5>
<!-- 		    <c:if test="${not empty cms.contentFileIds}">
				<div><pageTag:ProjectDynamic menupath="${cms.contentFileIds}"/></div>
			</c:if> -->
			<p>${cms.contentText}</p>
		</div>
		<div class="investmessageRight f_l">
			<div class="clear ">
			<h4><span>资讯排行榜</span></h4>
			<ul>
				<c:forEach items="${CmsSiteMenuContent}" var="CmsSiteMenuContent" varStatus="i">
					<c:if test="${i.index < 10 }">
						<li><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">
							<a href="${ctx}/site/Investmessage/InvestmessageDetails.ht?id=${CmsSiteMenuContent.siteMenuContentId}" target="_Blank">${CmsSiteMenuContent.contentTitle }</a>
						</li>
					</c:if>
				</c:forEach>
			</ul>
			</div>
		</div>
	</div>
	<div class="clear" style="height:130px;overflow: hidden;">
		<%@ include file="/crowdfunding/foot.jsp"%>
	</div>
</body>
</html>