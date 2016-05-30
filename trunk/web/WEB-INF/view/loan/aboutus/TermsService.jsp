<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>${cms.contentTitle }</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/TermsService.css">
</head>
<body> 
  <%@ include file="/crowdfunding/head.jsp"%>
   <div class="main-body TermsService-body">
    <h2>${cms.contentTitle }</h2>
    ${cms.contentText }
   </div>
  <div style="border-top:1px solid #dcdcdc;min-width:1000px;"></div> 

   <%@ include file="/crowdfunding/foot.jsp"%>
</body>
</html>