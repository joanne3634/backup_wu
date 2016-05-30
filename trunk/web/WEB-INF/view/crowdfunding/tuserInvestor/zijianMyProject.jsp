<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>发私信</title>
	<meta name="renderer" content="webkit"/>
		<%@ include file="/crowdfunding/cssorjs.jsp"%>
			<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
</head>
<script type="text/javascript">
$(function(){
	$("._bodyContent").css("display","block"); 
	$("._successInfo").css("display","none"); 
	 $("#form_id").validate({
	        rules: {
	   projectId: {
		    required: true
		   },
	   content_id: {
	    required: true
	   },
	   code: {
	    required: true,
	    remote : "${ctx}/user/validateCode.ht"
	   }
	  },
	   messages: {
	   projectId: {
		    required: "必选"
		   },
	   content_id: {
	    required: "必填"
	   },
	   code: {
	    required: "必填",
	    remote : "输入正确的验证码"
	   }
	  }
	    });	
	 
	 $("#form_submit").click(function(){
		 valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		 if($('#form_id').valid()){
				$.ajax({
					url : "${ctx}/crowdfunding/front/sendPrivateMsg.ht",
					type : 'post',
					data : $('#form_id').serialize(),
					dataType : 'json',
					success : function(data) {
						if(data == 0){
							window.parent.openDialog("验证码错误","30%","30%");
						}else{
							window.parent.openDialog(data,"30%","30%");
							setTimeout('window.parent.location = "${ctx}/crowdfunding/tcuserInvestor/tcuserInvestorPage.ht";',2000);
						}
						//setTimeout('window.parent.location = "${ctx}/loan/myAccount/myaccountPage.ht";',2000);
						
					},
					error : function(xhr, textStatus, errorThrown) {
						//alert('异步获取数据出现异常');
					},
					beforeSend:function(xhr, textStatus, errorThrown) {
						//alert('异步获取数据出现异常');
					}
				});
		 }	 
	 })	 
})
		function closediv(){
			var list = window.parent.art.dialog.list;
			for (var i in list) {
			    list[i].close();
			};
		}
		function reload(){
				var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
				document.getElementById("validImg").src=url;
		}




</script>
<body>
<!-- 发私信start -->
<form id="form_id">
<div id="faqdiv2" class="_bodyContent"> 
	<table class="faqtable"   border="0" cellspacing="1" cellpadding="0">
		<tr>
			<td class="faqtabletd1">收信人：</td>
			<td><input type="text" id="receiverName" name="receiverName" readonly="readonly" value="${receiverName }">
				<input type="hidden" id="receiverId" name="receiverId" value="${receiverId }">
				<input type="hidden" id="type_id" name="type_id" value="4"/>
			</td>
			
		</tr>
		<tr>
			<td class="faqtabletd1">我的项目：</td>
			<td>
				<select id="projectId" name="projectId">
					<option></option>
					<c:forEach items="${projectList }" var="list">
						<option value="${list.projectId }">${list.pname }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td class="faqtabletd1">内容：</td><td><textarea rows="5" name="content_id" id="content_id" placeholder="请输入内容"></textarea></td>
		</tr>
		<tr>
			<td class="faqtabletd1">验证码：</td>
			<td><input type="text" name="code" id="code"  placeholder="请输入验证码">
					<a href="javascript:void(0)" onclick="reload()">
					<img src="${ctx}/servlet/ValidCode" id="validImg" alt="" width="80px;" height="25px;">
					</a>
					<span id="errInfo_id" ></span>
			</td>
		</tr>
	</table>
	<div class="faqbutton">
	    <div class="submit" id="form_submit">确定</div><div class="cancel" onclick="closediv()">取消</div>
	</div>
</div>
</form>
</body>
</html>
