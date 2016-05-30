<%@ page language="java" contentType="text/html; charset=UTF-8"
 	pageEncoding="UTF-8"%>
 	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>投资资讯</title>
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
		<div class="investmessageLeft f_l">
			<h3 class="clear"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">投资资讯</h3>
			<form action="${ctx }/site/Investmessage/InvestmessageList.ht" name="pageForm" id="pageForm">
			<ul>
				<c:forEach items="${cms2}" var="cms">
		            <li> 
		               <h4><a href="${ctx}/site/Investmessage/InvestmessageDetails.ht?id=${cms.siteMenuContentId}" target="_Blank">${cms.contentTitle }</a></h4>
		                <p>
		                	<c:if test="${fn:length(cms.contentText) > 150 }">
								${fn:substring(cms.contentText,0,150) }...
							</c:if>
							<c:if test="${fn:length(cms.contentText) <= 150 }">
								${cms.contentText }
							</c:if>
							<a href="${ctx}/site/Investmessage/InvestmessageDetails.ht?id=${cms.siteMenuContentId}" target="_Blank">[详细]</a>
		                </p>
		                <div>
		                <img src="${ctx }/crowdfunding/Skin/Default/images/time.png">
		                	发布时间：<span><fmt:formatDate value="${cms.contentUpdateDate}" pattern="yyy-MM-dd HH:mm"/></span>
		                	<c:if test="${not empty cms.contentAuthor}">来源：<span>${cms.contentAuthor}</span></c:if>
		                	
		                </div>
		            </li>
		         </c:forEach> 
			</ul>	
			<pageTag:paging form="pageForm"/>
			</form>
		</div>
		<div class="investmessageRight f_l">
			<div class="clear ">
			<h4><span>资讯排行榜</span></h4>
			<ul>
				<c:forEach items="${cms}" var="cms" varStatus="i">
					<c:if test="${i.index < 10 }">
						<li><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">
							<a title="${cms.contentTitle }" href="${ctx}/site/Investmessage/InvestmessageDetails.ht?id=${cms.siteMenuContentId}" target="_Blank">${cms.contentTitle }</a>
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