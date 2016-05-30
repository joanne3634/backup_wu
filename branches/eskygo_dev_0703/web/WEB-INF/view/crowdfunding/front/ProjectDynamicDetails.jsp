<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>项目动态详情</title>
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
			<h6>所在位置：首页 > 项目动态 > 正文</h6>
			<h2>${tcprojectNews.pntitle }</h2>
			<h5>
				发布时间：<fmt:formatDate value="${tcprojectNews.createTime }" pattern="yyy-MM-dd HH:mm"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				项目:<a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${tcprojectNews.projectId }" target="_Blank" style="color:red;">【${tcprojectNews.pname }】</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="${ctx }/tcproject/ProjectDynamic/ProjectNewList.ht?projectId=${tcprojectNews.projectId }" target="_Blank" style="color:red;">&gt;&gt;本项目所有动态</a>
			</h5>
<!-- 			<c:if test="${not empty tcprojectNews.fileId}">
				<div><pageTag:ProjectDynamicDetail menupath="${tcprojectNews.fileId}"/></div>
			</c:if> -->
			<p>${tcprojectNews.pncontent }</p>		
		</div>
		<div class="investmessageRight f_l">
			<div class="clear ">
				<h4><span>热门项目动态</span></h4>
				<ul>
					<c:forEach items="${TCPList2}" var="list" varStatus="i">
						<c:if test="${i.index < 10 }">
							<li><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">
								<a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list.newsId }" target="_Blank" style="color:red;">
									${list.pntitle }
								</a>
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
	<script type="text/javascript">
	if (top != this) {//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
		top.location = window.location;
	}
	</script>
</body>
</html>
