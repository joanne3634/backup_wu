<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
String replyId = request.getParameter("replyId");
String name = new String(request.getParameter("receiverName").getBytes("iso-8859-1"),"utf-8") ;
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>私信回复</title> 
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
 <%@ include file="/crowdfunding/cssorjs.jsp"%>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
    <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
  <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
    <script type="text/javascript"> 
    function reloadUrl(){
    	closediv();
    	art.dialog.open.origin.location.reload(true);	
	  	   //window.location.reload(true);
	  }
 
 
$().ready(function() {
	
	$("#login_submit").click(function(){
		if($("#sendContent").val()==""){
			//art.dialog("请输入内容");
			$("#_warninput2").html("<font color='red'>请输入内容</font>");
			return;
		}
	/* 	if($("#valiCode_").val()==""){
			//art.dialog("请输入验证码");
			//$("#msgError").text("请输入验证码");
			$("#errInfo_id").html("<font color='red'>请输入验证码</font>");
			return;
		} */
		if($('#sendForm').valid()){
			$.ajax({
				url : "${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht?replyId="
						+<%=replyId%>+"&receiverName="+'<%=name%>'+"&isReply=1",
				type : 'post',
				data : $('#sendForm').serialize(),
				dataType : 'json',
				success : function(data,textStatus) {
					
					 /* alert(data);
				     alert(textStatus); */
					
					/*  if(data =="0"){
						$("#msgError").text("验证码输入不正确");
					}else if(data == "1"){ 
						 //$.dialog.open("${ctx }/loan/tuserMsgRemind/sendSuccess.ht",
									//{title:'信息提示',width:620,height:180});
						// art.dialog("发送信息成功");
						openDialog("发送信息成功",'','','2',function(){
							
							 window.onbeforeunload = function() {
							    //这里刷新方法有很多，具体要看你的子窗口是怎样出来的
							    window.opener.location.reload();
							    //parent.location.reload();
							    //self.opener.location.reload();
							    //window.opener.location.href=window.opener.location.href;
							}; 
							
							   reloadUrl();
					    }); 
				 	}  */
				 	
				     if(data == "1"){ 
						 //$.dialog.open("${ctx }/loan/tuserMsgRemind/sendSuccess.ht",
									//{title:'信息提示',width:620,height:180});
						// art.dialog("发送信息成功");
						openDialog("发送信息成功1",'','','2',function(){
							
							/*  window.onbeforeunload = function() {
							    //这里刷新方法有很多，具体要看你的子窗口是怎样出来的
							    window.opener.location.reload();
							    parent.location.reload();
							    self.opener.location.reload();
							    window.opener.location.href=window.opener.location.href;
							}; 
							 */
							/*    reloadUrl(); */
					    }); 
				 	}  
				 	reloadUrl();
					$("#sendContent").val("");
					$("#valiCode_").val("");
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					 alert(XMLHttpRequest.statusText); 
				}
			});
		  }
	})
	
	 $("#sendForm").validate({
	     rules: {
	        	sendContent: {
	    required: true
	   }
	/*  ,
	   valiCode_: {
	    required: false
	   } */
	  },
	        messages: {
		   sendContent: {
	    required: "请输入发送内容"
	   }
	/*   ,
	   valiCode_: {
	    required: "请输入验证码"
	   } */
	  }
	    });
	});


function closediv(){
	var list = window.parent.art.dialog.list;
	for (var i in list) {
	    list[i].close();
	};
}
function validateForm(){
	if($("#sendContent").val()==""){
		$("#_warninput2").html("<font color='red'>请输入内容</font>");
	}else{
		$("#_warninput2").html("");
	}
	/* if($("#valiCode_").val()==""){
		$("#errInfo_id").html("<font color='red'>请输入验证码</font>");
	}else{
		$("#errInfo_id").html("");
	} */
}
function validateC_(){
	var valiCode_=$("#valiCode_").val();
	/* if(valiCode_!=''){ */
		$("#errInfo_id").html("");
	    $.ajax({
			url : "${ctx}/crowdfunding/front/validateCode.ht",
			type : 'post',
			data : 'valiCode_=' + valiCode_ 
			,
			dataType : 'html',
			success : function(data, status) {
				/* if(data==0){
					$("#errInfo_id").html("<font color='red'>验证码输入有误!</font>");
				} */
			},
			error : function(xhr, textStatus, errorThrown) {
			}
		});
	/* }else{
		$("#errInfo_id").html("<font color='red'>验证码不能为空!</font>");
	} */
}
function reload(){
	var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
	document.getElementById("validImg").src=url;
}
</script> 
</head>

<body>
   <!-- 发私信start -->
<div id="faqdiv2" class="_bodyContent">
<form action="${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht" method="post" id="sendForm">
	<table class="faqtable"   border="0" cellspacing="1" cellpadding="0">
		<tr>
			<td class="faqtabletd1">
			
			<c:choose>
				<c:when test="${type_id eq '2' }">约谈人：</c:when>
				<c:otherwise>收信人：</c:otherwise>
			</c:choose>
			</td>
			<td><input type="text" id="receiverName" name="receiverName" readonly="readonly" value="${receiverName }">
			</td>
		</tr>
		<tr>
			<td class="faqtabletd1">
			
			<c:choose>
				<c:when test="${type_id eq '2' }">约谈留言：</c:when>
				<c:otherwise>内容：</c:otherwise>
			</c:choose>
			</td><td>
			<c:choose>
				<c:when test="${type_id eq '2' }"><textarea rows="5"  name="sendContent" id="sendContent" onblur="validateForm()" placeholder="请输入内容,建议填写约谈理由、时间、地点、联系电话等。"></textarea></br><em id="_warninput"></em></c:when>
				<c:otherwise><textarea rows="5" name="sendContent"  id="sendContent" onblur="validateForm()" placeholder="请输入内容"></textarea><br><em id="_warninput2"></em></c:otherwise>
			</c:choose>
			</td>
		</tr>
		<tr style="display:none">
			<td class="faqtabletd1">验证码：</td>
			<td><input type="text" name="valiCode_" id="valiCode_"  onblur="validateC_();">
					<a href="javascript:void(0)" onclick="reload()">
					<img src="${ctx}/servlet/ValidCode" id="validImg" alt="" width="80px;" height="25px;">
					</a>
					<span id="errInfo_id" ></span>
			</td>
		</tr>
	</table>
	<br><br>
	<div class="faqbutton">
	    <div class="submit" id="login_submit">确定</div><div class="cancel" onclick="closediv()">取消</div>
	</div>
	</form>
</div>
</body>
</html>