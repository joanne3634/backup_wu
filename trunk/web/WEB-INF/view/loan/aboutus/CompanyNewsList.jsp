<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page
	import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<link rel="stylesheet"
	href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet"
	href="${ctx }/styles/p2p/Skin/Default/css/public.css">
<link rel="stylesheet"
	href="${ctx }/styles/p2p/Skin/Default/CompanyNewsList.css">
<script type="text/javascript"
	src="${ctx}/js/javascripts/jquery-1.11.1.min.js"></script>
 <div class="con"> 
<ul>
	<c:forEach items="${cms}" var="cms">
		<li ><a href="${ctx}/site/CompanyNews/CompanyNewsDetails.ht?id=${cms.siteMenuContentId}"><h2>${cms.contentTitle}</h2></a>
			 <div class="mediaReport-p" style="text-overflow: ellipsis;height: 40px;" >
             	${cms.contentSummary}  
			</div> <span>
			<c:if test="${!empty cms.contentUpdateDate}">
                <fmt:formatDate value="${cms.contentUpdateDate }" pattern="yyyy-MM-dd HH:mm"/>
                </c:if>
			</span></li>
	</c:forEach>
</ul> 
<form action="" name="pageForm" id="pageForm">
<pageTag:paging form="pageForm"/>
</form>
</div>