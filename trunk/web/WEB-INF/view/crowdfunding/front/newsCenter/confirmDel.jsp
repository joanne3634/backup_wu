<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String messageId = request.getParameter("msgRemindId");
%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>删除提示</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
<!-- 发私信end -->
<script type="text/javascript" src="./js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
	function confirmDel(){
		$.ajax({
			url : "${ctx }/loan/tuserMsgRemind/delTUserMsgRemind.ht?msgRemindId="+<%=messageId%>
			type : 'post',
			data :"",
			dataType : 'json',
			success : function(data,textStatus) {
				if(data=="1"){
					alert("删除消息成功");
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("删除消息失败");
			}
		});
		
	}
	
		function closediv(){
			var list = window.parent.art.dialog.list;
			for (var i in list) {
			    list[i].close();
			};
		}
		window.onload=function(){
			confirmDel();
			closediv();
		}
	</script>
  </head>
  
  <body>
  <!-- 删除提示start -->
<div id="faqdiv2"> 
<div>
你真的确认删除吗？
</div>
	<div class="faqbutton">
	    <div class="submit" onclick="confirmDel()">确定</div><div class="cancel" onclick="closediv()">取消</div>
	</div>
</div>

  </body>
</html>
