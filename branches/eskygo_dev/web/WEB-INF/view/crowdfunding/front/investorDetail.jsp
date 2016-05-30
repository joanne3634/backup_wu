<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <meta charset="UTF-8">
	<title>详细信息</title>
	<meta name="renderer" content="webkit"/>
	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
	 <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
  </head>
  
  <body>
    <!-- 投资人详细资料start -->
<div id="faqdiv"> 
<div class="faqData">
<div class="faqDataName">
	<div class="incestorRightimg">
			<c:choose>
						<c:when test="${empty tuser.myPhoto}">
							<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait.png">
						</c:when>
						<c:otherwise>
							<img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${tuser.myPhoto}" >
						</c:otherwise>
					</c:choose>
	</div>
	<div>
		<h3>${tuser.realName }<img src="${ctx }/crowdfunding/Skin/Default/images/lingtouren.png">
		<img src="${ctx }/crowdfunding/Skin/Default/images/shimingyanzheng.png">
		<img src="${ctx }/crowdfunding/Skin/Default/images/xunjia.jpg"></h3>
		<p>${tuser.personalAddress}</p>
		<%--<p>北京三维动画公司+创始人</p>
	--%></div>
</div>
<div class="clear faqDataDetail">
	<h3>详细资料</h3>
	<h4>个人简历</h4>
	<p>姓名：<span>${tuser.realName } </span> 
	性别：<span><c:if test="${tuser.gender==1}">男</c:if><c:if test="${tuser.gender==2}">女</c:if></span>民族：<span>汉</span></p>
	<%--<p>出生年月：1978年8月23</p>--%>
	<p>籍贯：${tuser.personalAddress}</p>
	<p>学历：${tuser.edu }</p>
	<p>说明：${tuser.remarks }</p>
	<%--
	<h5>教育经历：</h5>
	<p>1.1996.9--1999.7   磁县第二中学，高中</p>
	<p>2.1999.9--2002.7   邯郸市职业技术学院 ，大专（机械电子专业）</p>
	<p>工作经历：</p>
	<p>1.2003.3--2005.12</p>
	<p>就职于北京市完美科学技术研究所，生产部，职位：生产</p>
	<p>2.2006.2--2011.4</p>
	--%>
</div>
</div>
</div>
<!-- 投资人详细资料end -->
  </body>
</html>
