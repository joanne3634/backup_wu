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
<div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">我的通知</span></div>
    <div class="leaveList text-center bd-b-color-main bd-r-color-main bd-l-color-main">
      <ul>
        <li>
          <div class="leaceType">发送人</div>
          <div class="leaceCont">消息内容</div>
          <div class="leaceTime">发送时间</div>
          <div class="leaceOper">操作</div>
        </li>
        <c:forEach items="${ list}" var="list">
      <li>
          <div class="leaceType"> <%-- <f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${list.senderId }"/> --%>
          <f:description modelCode="sys_user"  modelPropertyName="fullname" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${list.senderId }"/></div>
          <div class="leaceCont">${list.content}</div>
          <div class="leaceTime"><fmt:formatDate value="${list.sendTime}" pattern="yyyy-MM-dd HH:MM"/></div>
          <a href="${ctx }/loan/tuserMsgRemind/MsgRemindDetails.ht?MsgRemindId=${list.msgRemindId}"><div class="leaceOper recharge">查看详情</div></a>
         	
        </li>
        </c:forEach> 
      </ul>
    </div>
        <form action="" name="pageForm" id="pageForm">
<pageTag:paging form="pageForm"/>
</form>
</body>
</html>