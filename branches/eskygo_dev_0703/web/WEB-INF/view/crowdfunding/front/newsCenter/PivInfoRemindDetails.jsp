<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="/commons/include/get.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>我的留言详情</title> 
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
  <%@ include file="/crowdfunding/cssorjs.jsp"%>
    <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/style.css"> 
  	<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/transferback.css">
  	<f:link href="form.css" ></f:link>
</head>

<body>
    <div id="faqdiv2" class="_bodyContent">
	<div class="ldetailList text-left bd-b-color-main bd-r-color-main bd-l-color-main">
      <ul>
        <li class="borderdashed">
        <h3> 登录账号：${tuserMsgRemind.senderName}</h3>
        <div>${tuserMsgRemind.senderName}发送于<span>
         <span class="ldetailListTime">
        <fmt:formatDate value="${tuserMsgRemind.readTime}" pattern="yyyy-MM-dd HH:mm"/></span></div>
        </li>
        <li class="borderdashed">
        <h3> 消息内容：</h3>
         ${tuserMsgRemind.content}
        </li>
      </ul>
    </div>
</div>
  <!--循环回复的信息-->  
     <c:forEach var="replyInfo" items="${replyInfos}">
      <div class="ldetailList text-left bd-b-color-main bd-r-color-main bd-l-color-main">
      <ul>
        <li class="borderdashed">
        <div>${replyInfo.recevierName}回复于<span>
         <span class="ldetailListTime">
        <fmt:formatDate value="${replyInfo.sendTime}" pattern="yyyy-MM-dd HH:mm"/></span></div>
        </li>
        <li class="borderdashed">
        <h3> 消息内容：</h3>
         ${replyInfo.content}
        </li>
      </ul>
    </div>
     </c:forEach>
     <br>
    <br>
	   <div class="cancel" onclick="closediv()">关闭</div>
    	<script type="text/javascript">
		function closediv(){
			var list = window.parent.art.dialog.list;
			for (var i in list) {
			    list[i].close();
			};
			//$.dialog.open.origin.location.reload(true);
			art.dialog.open.origin.document.forms[0].submit();
		}
	</script>
</body>
</html>