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
<div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">我的留言</span></div>
    <div class="ldetailList text-left bd-b-color-main bd-r-color-main bd-l-color-main">
      <ul>
        <li class="borderdashed">
        <h3 class="text-center">我的留言标题</h3>
        <div>留言类型：<span> <f:description itemValue="${tuserMessage.messageType}" nodeKey="LYLX" /></span><!--   <span class="ldetailListTime">2014-06-25   19:05:47</span></div> -->
        </li>
        <li class="borderdashed">
        <h3 >留言的内容：</h3>
          ${tuserMessage.messageContent }
        </li>
        <li >
        <h3 >管理员回复：</h3>
          ${tuserMessage.messageReplyAbout }
        </li>
      </ul>
    </div>
</body>
</html>