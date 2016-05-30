<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="/commons/include/get.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>我的留言详情</title> 
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
    <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/style.css"> 
</head>

<body>
<div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">我的通知</span></div>
    <div class="ldetailList text-left bd-b-color-main bd-r-color-main bd-l-color-main">
      <ul>
        <li class="borderdashed">
        <h3 class="text-center">我的通知</h3>
        <div>发送人：<span> <f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tuserMsgRemind.senderId }"/></span> <span class="ldetailListTime"><fmt:formatDate value="${tuserMsgRemind.readTime}" pattern="yyyy-MM-dd HH:MM"/></span></div>
        </li>
        <li class="borderdashed">
        <h3> 消息内容：</h3>
         ${tuserMsgRemind.content}
        </li>
 
      </ul>
    </div>
</body>
</html>