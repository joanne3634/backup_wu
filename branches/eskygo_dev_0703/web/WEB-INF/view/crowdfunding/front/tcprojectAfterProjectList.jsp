<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>项目列表</title>
	<meta name="renderer" content="webkit"/>
  	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
     <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/projectInvest.css">
</head>
<body>

<div class="PrDyBack f_l">
		<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">投后项目</h2>
		<form action=""   name="pageForm" id="pageForm" method="post">
		<div class="project_search">
	    项目名称：<input type="text" id="pname" name="pname" value="${pname }" /> 项目类别：<select id="ptypeId" name="ptypeId">
	    <option value="" >--请选择--</option>
	    <option value="1" <c:if test="${ptypeId==1}">selected</c:if>>科技创新</option>
	    <option value="2" <c:if test="${ptypeId==2}">selected</c:if>>连锁服务</option></select>&nbsp;
	    <option value="3" <c:if test="${ptypeId==3}">selected</c:if>>地产投资</option></select>&nbsp;
	    <a href="javascript:clearForm()">清空</a>&nbsp;<a href="javascript:submitForm()">查询</a>
	    </div>
		<div class="itemSetting">
			<ul>
			<c:forEach items="${tcprojectList}" var="pr">
				<li>
					<div class="f_l"><img src="${ctx }/crowdfunding/Skin/Default/images/case3.png"></div>
					<div class="itemSettingcontent f_l">
						<h4>${pr.pname }</h4>
						<div class="itemSettingNO">接受领投：<span>1/1</span>个&nbsp;&nbsp;&nbsp;&nbsp;接受跟投：<span>3/10</span>个&nbsp;&nbsp;&nbsp;&nbsp;申请查看：<span>10</span>个</div>
						<div id="${pr.projectId }"  class="itemSettingButton"><span>投后添加</span><span>投后列表</span></div>
					</div>
					<div class="clear"></div>
				</li>
				</c:forEach>
				
			</ul>
		</div>
		
		<pageTag:paging form="pageForm"/>
</div>
	
</body>
</html>
<script type="text/javascript">
$(function(){
	$(".itemSettingButton span").click(function(){
		var projectId=$(this).parent().attr("id");
		if($(this).index()==0){
			$.dialog.open('${ctx }/crowdfunding/tcprojectAfter/projectAfterForm.ht?projectId='+projectId, {
			title: '投后添加',width:'880px',height:'500px',lock:true});
		}else if($(this).index()==1){
			$.dialog.open('${ctx }/crowdfunding/tcprojectAfter/tcprojectAfterListPr.ht?projectId='+projectId, {
			title: '投后列表',width:'880px',lock:true});
		}
	}); 
});
function clearForm(userId){
	$("#pname").val("");
	$("#ptypeId").val("");
}
function submitForm(userId){
	$("#pageForm").submit();
}
</script>
