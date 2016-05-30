<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>领投资格申请成功</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
  	<script type="text/javascript" src="${ctx }/crowdfunding/js/ckeditor/ckeditor.js"></script>
  	<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
  	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
</head>
<style type="text/css">
.tab{
	cursor: pointer;
	display: inline-block;
	height: 22px;
	vertical-align: bottom;
	bottom:20px;
	position: absolute;
	right:25px;
}

.bgFont{
	cursor: pointer;
	display: inline-block;
	height: 22px;
	vertical-align: bottom;
	bottom:100px;
	position: absolute;
	left:200px;
}
</style>
<body>

<input type="hidden" id="isCheck" name="isCheck"  value="${tuserApplyLeader.isCheck}"/>
<div>
	<div class="PrDyBack f_l" style="background-color:＃fffcf2">
		<c:if test="${tuserApplyLeader.isCheck eq 1}">
			<img src="${ctx }/crowdfunding/Skin/Default/images/applyLeader01.png" /><font color="#cc9900" class="bgFont">您已经获得领投人资格！</font>
		</c:if>
		<c:if test="${tuserApplyLeader.isCheck eq 0}">
			<img src="${ctx }/crowdfunding/Skin/Default/images/applyLeader03.png" /><font color="#cc9900" class="bgFont">已提交申请，请耐心等待审核结果！</font>
		</c:if>
		<div class="tab">
			<form action="${ctx}/user/applyLeaderInit.ht?type=2">
				<input type="submit" value="重新编辑领投人资料" />
			</form>
		</div>
	</div>
</div>
</body>
</html>
</script>