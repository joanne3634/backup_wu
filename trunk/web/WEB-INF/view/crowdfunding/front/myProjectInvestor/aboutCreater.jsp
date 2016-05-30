<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commons/includeFront/javascripts.jsp"%>
<% 
String createrId = request.getParameter("createrId");
String projectId = request.getParameter("projectId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>发私信</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
   <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>

</head>
<body scroll="no">
<!-- 发私信start -->
<div id="faqdiv2" class="_bodyContent"> 
<form action="${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht" method="post" id="sendForm">
	<table class="faqtable"   border="0" cellspacing="1" cellpadding="0">
		<tr>
			<td class="faqtabletd1">约谈人：</td>
			<td><input type="text" id="receiverName" name="receiverName" readonly="readonly" value="${receiverName }"></td>
		</tr>
		<tr>
			<td class="faqtabletd1">内容：</td>
			<td>
			<c:choose>
				<c:when test="${type_id eq '2' }"><textarea rows="5"  name="sendContent" id="sendContent" placeholder="请输入内容,建议填写约谈理由、时间、地点、联系电话等。"></textarea><br><em id="_warninput"></em></c:when>
				<c:otherwise><textarea rows="5" name="sendContent"  id="sendContent" placeholder="请输入内容"></textarea><br><em id="_warninput2"></em></c:otherwise>
			</c:choose>
			</td>
		</tr>
		<tr>
			<td class="faqtabletd1">验证码：</td><td><input type="text" placeholder="请输入验证码"  id="validCode" name="validCode"/><img
							 src="${ctx}/servlet/ValidCode" id="validImg" alt="" onclick="reload()" style="cursor: pointer;"/><span id="msgError" style="color:red;font-size:12px"></span></td>
		</tr>
	</table>
	<div class="faqbutton">
	    <div class="submit" id="login_submit">确定</div><div class="cancel" onclick="closediv()">取消</div>
	</div>
	</form>
</div>
 <script type="text/javascript"> 
$().ready(function() {
	$("#login_submit").click(function(){
		if($('#sendForm').valid()){
			$.ajax({
				url : "${ctx}/loan/tuserMsgRemind/saveAboutInfo.ht?createrId="
						+<%=createrId%>+"&projectId="+<%=projectId%>,
				type : 'post',
				data : $('#sendForm').serialize(),
				dataType : 'json',
				success : function(data,textStatus) {
					if(data =="0"){
						$("#msgError").text("验证码输入不正确");
					}else if(data == "1"){
						// $.dialog.open("${ctx }/loan/tuserMsgRemind/sendSuccess.ht",
									//{title:'信息提示',width:620,height:180});
						openDialog("信息发送成功",'','','2',function(){
							closediv();
						});
					}
					$("#sendContent").val("");
					$("#validCode").val("");
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.statusText);
				}
			});
		  }
	})
	
	 $("#sendForm").validate({
	        rules: {
	   loginPwd: {
	    required: true
	   },
	   sendContent:{
		   required: true
	   },
	   validCode: {
	    required: true
	   }
	  },
	        messages: {
		   sendContent: {
	    required: "请输入发送内容"
	   },
	   validCode: {
	    required: "请输入验证码"
	   }
	  }
	    });
	});


function closediv(){
	var list = window.parent.art.dialog.list;
	for (var i in list) {
	    list[i].close();
	};
}

</script> 

</body>
</html>