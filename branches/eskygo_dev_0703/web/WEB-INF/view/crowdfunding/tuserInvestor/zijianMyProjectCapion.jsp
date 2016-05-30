<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>发私信</title>
	
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
</head>
<script type="text/javascript">

function closediv(){
	var list = window.parent.art.dialog.list;
	for (var i in list) {
	    list[i].close();
	};
}
</script>
<body>
<!-- 
<div id="faqdiv2" class="_bodyContent">  -->
<div class="faqbutton">
	  		${htmlContent }
	</div>
	<div class="faqbutton">
	</div>
	<div class="faqbutton">
	    <div class="submit"  onclick="closediv()">确定</div><!-- <div class="cancel" onclick="closediv()">取消</div> -->
	</div>
<!-- </div> -->


</body>
</html>
