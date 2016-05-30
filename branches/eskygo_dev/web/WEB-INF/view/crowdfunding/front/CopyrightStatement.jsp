<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>服务协议</title>
  <meta name="renderer" content="webkit"/>
  <%@ include file="/crowdfunding/cssorjs.jsp"%>
  <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/public1.css">  
</head>
<body>
  <!-- <div style="height:191px;overflow: hidden;">
</div> -->
	<%@ include file="/crowdfunding/head.jsp"%>
  <style>
    .TermsService-body {
      width: 1060px;
      padding-top: 20px;
      margin-bottom: 30px;
      padding-bottom: 20px;
      color: #333;
      margin-left: auto;
      margin-right: auto;
    }
    .TermsService-body h2 {
      margin-bottom: 10px;
      text-align: center;
      line-height: 40px;
      font-size: 26px;
    }
    .TermsService-body p {
      text-indent: 2em;
      margin-bottom: 20px;
      font-size: 14px;
      line-height: 24px;
    }
    .TermsService-body .tit {
      text-align: left;
      margin-bottom: 10px;
      font-size: 20px;
    }
  </style>
  <div class="TermsService-body">
    <h2>法律服务</h2>
    ${cms.contentText }
</div>
  <div class="clear" style="height:130px;overflow: hidden;">
	<%@ include file="/crowdfunding/foot.jsp"%>
</div>
</body>
</html>