<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fnd" uri="http://www.deelon.com/jsp/jstl/functions" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>投资人信息(detail)</title>
	<meta name="renderer" content="webkit"/>
  	<%@ include file="/crowdfunding/cssorjs.jsp"%>
   <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
	<div class="InInIframe">
	<h3>项目领投人</h3>
		<ul>
		<c:if test="${empty tuserLead}">
			<a style="font-size: 17px;">暂无领投人</a>
		</c:if>
		<c:if test="${!empty tuserLead}">
			<li>
				<div class="InInIframeImg f_l">		
				<c:choose>
				<c:when test="${empty tuserLead.myPhoto}"> 
					<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png" >
				</c:when>
				<c:otherwise>
					<img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${tuserLead.myPhoto}" >
				</c:otherwise>
				</c:choose>
				</div>
				<div class="InInIframeName f_l">
					<p>${tuserLead.realName}
					<img src="${ctx }/crowdfunding/Skin/Default/images/lingtouren.png">
					<img src="${ctx }/crowdfunding/Skin/Default/images/shimingyanzheng.png">
					<img src="${ctx }/crowdfunding/Skin/Default/images/xunjia.jpg"></p>
					<div>领投金额： ${fnd:substrdot(tuserLead.piInvest)}万</div>
					<div>领投时间：<fmt:formatDate value="${tuserLead.piInvestTime}" pattern="yyyy-MM-dd HH:mm"/></div>
				</div>
				<div id="${tuserLead.userId }" class="InInIframeButton f_l"><span>发私信</span><span>详细资料</span></div>
				<div class="clear"></div>
			</li>
			</c:if>
			<h3>项目跟投人</h3>
			<c:if test="${empty tuserFollowList}">
				<a style="font-size: 17px;">暂无跟投人</a>
			</c:if>
			<c:forEach items="${tuserFollowList}" var="us">
			<li>
				<div class="InInIframeImg f_l">
				<c:choose>
				<c:when test="${empty us.myPhoto}"> 
					<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png" >
				</c:when>
				<c:otherwise>
					<img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${us.myPhoto}" >
				</c:otherwise>
				</c:choose>
				</div>
				<div class="InInIframeName f_l">
					<p>${us.realName}
					<img src="${ctx }/crowdfunding/Skin/Default/images/lingtouren.png">
					<img src="${ctx }/crowdfunding/Skin/Default/images/shimingyanzheng.png">
					<img src="${ctx }/crowdfunding/Skin/Default/images/xunjia.jpg"></p>
					<div>跟投金额： ${fnd:substrdot(us.piInvest)}万</div>
					<div>跟投时间：<fmt:formatDate value="${us.piInvestTime}" pattern="yyyy-MM-dd HH:mm"/></div>
				</div>
				<div id="${us.userId }" class="InInIframeButton f_l"><span>发私信</span><span>详细资料</span></div>
				<div class="clear"></div>
			</li>
			</c:forEach>
		</ul>
		
</div>
	
	
	
	
	
</body>
</html>
	<script type="text/javascript">
	
	$(function(){
		$(".InInIframeButton span").click(function(){ 
			var userId=$(this).parent().attr("id");
			if($(this).index()==0){
				$.dialog.open('${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+userId, {
    			title: '发私信',lock:true});
			}else if($(this).index()==1){
				$.dialog.open('${ctx }/crowdfunding/tuser/investorDetail.ht?userId='+userId, {
    			title: '详细资料',width: 700, height:500,lock:true});
			}
		}); 
	});

	</script>
