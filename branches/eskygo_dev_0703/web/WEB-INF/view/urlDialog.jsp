<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String basePath=request.getContextPath();
%>
<html>
	<head>
		<title>提醒</title>
		<%@ include file="/crowdfunding/cssorjs.jsp"%>
			<script type="text/javascript">
				//alert("${message}");		
				//artDialog.alert("${message}");
				//window.location.href="${url}";
			</script>
	</head>
	<body>
	</body>
</html>
<script type="text/javascript">
$(document).ready(function(){  
	//art.dialog("${message}");
	art.dialog({content:'${message}',ok:function(){
		window.location.href="${url}";}});
	
}); 

</script>