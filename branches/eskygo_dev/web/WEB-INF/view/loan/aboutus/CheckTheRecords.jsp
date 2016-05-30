<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commons/includeFront/taglibs.jsp"%>
	<%@include file="/commons/include/html_doctype.html" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>我的留言</title>
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
	<%@include file="/commons/include/get.jsp" %>
    <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/style.css"> 
</head>

<body>
<div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">我的留言</span></div>
    <div class="leaveList text-center bd-b-color-main bd-r-color-main bd-l-color-main">
      <ul>
        <li>
          <div class="leaceType">留言类型</div>
          <div class="leaceCont">留言内容</div>
          <div class="leaceTime">回复方式</div>
          <div class="leaceOper">操作</div>
        </li>
        <c:forEach items="${ list}" var="tuserMessage">
      <li>
           <div class="leaceType">	<f:description itemValue="${tuserMessage.messageType}" nodeKey="LYLX" /></div>
          <div class="leaceCont">${tuserMessage.messageContent}</div>
          <div class="leaceTime"> <f:description itemValue="${tuserMessage.messageReplyWay}" nodeKey="HFFS" /> </div>
          <a href="${ctx }/loan/aboutus/CheckTheRecordsDetails.ht?messageid=${tuserMessage.messageId}"><div class="leaceOper recharge">查看回复</div></a>
         	
        </li>
        </c:forEach> 
      </ul>
    </div>
     <form action="" name="pageForm" id="pageForm">
<pageTag:paging form="pageForm"/>
</form>
</body>
</html>