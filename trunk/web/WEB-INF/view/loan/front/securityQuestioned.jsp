<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>已设置安全问题</title>
 
<%@ include file="/crowdfunding/cssorjs.jsp"%>
      <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/Userbackground.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/bindPhone.css"> 
</head>
<body>
	<div class="addyourproject f_l">
			<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">修改/设置安全问题</h2>
				<div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main">
					<div class="tips"><span class="">>>已成功设置安全问题！</span><a class="f-r color-main" href="${ctx}/safe/safeQuestionChange.ht" >点击修改安全问题</a></div>
					<p style="text-align: center; margin-bottom: 20px; font-size: 15px; color: #999;">若您无法使用上述方法找回，请联系客服<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></p>
				</div>
		</div>

</body>
</html>