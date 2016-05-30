<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="/commons/include/get.jsp" %>
<% 
String projectId = request.getParameter("projectId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>约谈项目方</title> 
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
  <%@ include file="/crowdfunding/cssorjs.jsp"%>
    <link rel="stylesheet" href="${ctx }/Skin/Default/css/DialogIframe.css">
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
  <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
    <script type="text/javascript"> 

 
 
$().ready(function() {
	$("#login_submit").click(function(){
		if($('#sendForm').valid()){
			$.ajax({
				url : "${ctx}/crowdfunding/front/tcprojectinvest/ledTou.ht?projectId="+<%=projectId%>+"&typeId="+$("#sendForm input[name=identity]:checked").val(),
				type : 'post',
				data : $('#sendForm').serialize(),
				dataType : 'json',
				success : function(data,textStatus) {
					if(data =="0"){
						$("#msgError").text("验证码输入不正确");
					}else if(data == "1"){
						 //$.dialog.open("${ctx }/loan/tuserMsgRemind/sendSuccess.ht",
								//	{title:'信息提示',width:620,height:180});
						 openDialog("消息发送成功",'','','2',function(){});
					}
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
	   validCode: {
	    required: true
	   }
	  },
	        messages: {
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
</head>

<body>
   <!-- 发私信start -->
<div id="faqdiv2" align="center" style="margin-top:100px;"> 
<form action="${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht" method="post" id="sendForm">
				<table>
				<tr>
					<td>内容：</td>
					<td>
					<input type="radio"  name="identity" value="1" checked="checked" />领投全部
					<input type="radio"  name="identity" value="2" />领投部分<br>
					</td>
					</tr>
					<tr height="40">
					<td>验证码：</td>
					<td class="login-yanzhengma-input">
						<div class="f-l" style="display: inline-block;width:120px;"><input type="text" id="validCode" name="validCode" ><br><div id="codeErrMsg" style="color:red;font-size:12px;line-height:22px;width:250px;"></div></div><img
							 src="${ctx}/servlet/ValidCode" id="validImg" alt="" onclick="reload()" style="cursor: pointer;"/>
					</td>
					</tr>
				</table>
			</form>
<br><br>
	<div class="faqbutton">
	    <div class="submit" id="login_submit">确定</div><div class="cancel" onclick="closediv()">取消</div>
	</div>
</body>
</html>