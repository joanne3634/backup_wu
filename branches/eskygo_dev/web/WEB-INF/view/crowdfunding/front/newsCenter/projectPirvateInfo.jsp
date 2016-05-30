<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.deelon.core.util.AppUtil" %>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>发送新消息</title> 
 	<%@ include file="/crowdfunding/cssorjs.jsp"%>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
    <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   	<link title="index" name="styleTag" rel="stylesheet" type="text/css" href="${ctx}/styles/default/css/web.css"></link>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<script type="text/javascript"> 
function reloadUrl(){
	   window.location.reload(true);
}
$().ready(function() {
	$("#receiverName").focus(function(){
		$("#msgName").text("");
	})
	
	
	
	 $("#sendForm").validate({
	        rules: {
	        	receiverName: {
		    required: true
		   },

	   loginPwd: {
	    required: true
	   },
	   validCode: {
	    required: true
	   },
	   sendContent: {
		    required: true
		}
	  },
	  messages: {
	        receiverName: {
		    required: "请输入收信人登陆名"
		   },
		   sendContent: {
			   required: "请输入发送内容"
	   },
	   validCode: {
	    required: "请输入验证码"
	   }
	  }
	    });
	});



function send_form_submit(){
	if($('#sendForm').valid()){
	$.ajax({
		url : "${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht?createrId="+${createrId}+"&projectId="+${projectId},
		type : 'post',
		data : $('#sendForm').serialize(),
		dataType : 'json',
		success : function(data,textStatus) {
			if(data=="0"){
				$("#msgError").text("验证码输入不正确");
			}else if(data=="1"){
				openDialog("消息发送成功",'','','2',function(){
					reloadUrl();
				});
			}else if(data=="2"){
				$("#msgName").text("收信人不存在,请填写收信人登陆名");
			}
			$("#receiverName").val("");
			$("#sendContent").val("");
			$("#validCode").val("");
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			openDialog("消息发送成功",'','','2',function(){
				reloadUrl();
			});
		}
	});
  }
}
function send_form_submit_Enterevent(e){
	 var keyCode = e.keyCode?e.keyCode:e.which?e.which:e.charCode;
	 if(keyCode == 13)
		 send_form_submit();
}

function reload(){
	var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
	document.getElementById("validImg").src=url;
}
</script> 
</head>
<body>
<body>
<div class="PrDyBack f_l">
		<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">发送新信息</h2>
<!-- 发私信start -->
<div id="faqdiv2"> 
<form action="${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht" method="post" id="sendForm">
	<table class="faqtable"   border="0" cellspacing="1" cellpadding="0">
		<tr>
			<td class="faqtabletd1">收信人：</td><td><input type="text" placeholder="请填写收件人" name="receiverName" id="receiverName" /><span id="msgName" style="color:red;font-size:12px"></span></td>
		</tr>
		<tr>
			<td class="faqtabletd1">内容：</td><td><textarea rows="5" placeholder="请输入内容"  name="sendContent" id="sendContent" type="text"></textarea></td>
		</tr>
		<tr>
			<td class="faqtabletd1">验证码：</td><td><input type="text" placeholder="请输入验证码"  id="validCode" name="validCode"/><img
							 src="${ctx}/servlet/ValidCode" id="validImg" alt="" onclick="reload()" style="cursor: pointer;"/><span id="msgError" style="color:red;font-size:12px"></span></td>
		</tr>
	</table>
</form>
	<div class="faqbutton">
	    <div class="submit" id="login_submit" onclick="send_form_submit();">确定</div>
	</div>
</div>
<!-- 发私信end -->
</div>
<script type="text/javascript" src="./js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
		function closediv(){
			var list = window.parent.art.dialog.list;
			for (var i in list) {
			    list[i].close();
			};
		}
	</script>
</body>
</html>