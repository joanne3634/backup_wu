<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>项目关联的投后列表</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>

<div class="itemSettingIframe">

		<table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
			<tr>
			<th width="30"><input type="checkbox" name="InvertSelection"/></th>
			<th width="200">项目名称</th>
			<th width="100">类型</th>
			<th width="120">标题</th>
			<th width="80">创建人</th>
			<th width="80">创建时间</th>
			<th width="100">文件</th>
			<tr>
			<c:if test="${!empty tcprojectAfterList}">
			<c:forEach items="${tcprojectAfterList }" var="pa">
				<tr>
					<td><input id="${pa.afterId }" type="checkbox" name="checkbox"/></td>
					<td>${pa.projectName }</td>
					<td>
					<c:if test="${pa.paTypeId ==1}">年度报表</c:if>
					<c:if test="${pa.paTypeId ==2}">季度报表</c:if>
					<c:if test="${pa.paTypeId ==3}">重大事件披露</c:if>
					</td>
					<td>${pa.paTitle }</td>
					<td>${pa.creatorName }</td>
					<td>
					<fmt:formatDate value="${pa.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
					<td>${pa.fileName }</td>
				</tr>
			</c:forEach>
			</c:if>
		</table>
		<div class="PrDyBackDelebutton">
			<div>删除选中</div><span id="processResult"></span>
		</div>
		<form action=""   name="pageForm" id="pageForm">
		<input type="hidden" name="projectId" value="${projectId }">
		<pageTag:paging form="pageForm"/>
		
</div>
</body>
</html>
<script type="text/javascript">
function reloadUrl(){
	   window.location.reload(true);
}
   $(function(){
	 	$('.PrDyBackTable input[name="InvertSelection"]').click(function(){
	 		$('.PrDyBackTable input[name="checkbox"]').each(function(e,index){
	 			$(this).attr("checked",!$(this).attr("checked"));
	 		});
	 	});
	 	$('.PrDyBackDelebutton div').click(function(){
	 		var ids="";
	 		$('.PrDyBackTable input[name="checkbox"]').each(function(e,index){
	 			if($(this).attr("checked")){
	 				ids+=$(this).attr("id")+";";
	 				//$(this).parent().parent().remove();
	 			}
	 		});
	 		
	 		if(ids!=""){
	 			//if(confirm("您确定删除吗")){
	 				art.dialog.confirm("您确定删除吗",function(){
	 				$.ajax({
						url : "${ctx}/crowdfunding/tcprojectAfter/projectAfterByidsDel.ht?time="+new Date(),
						type : 'post',
						data: "ids="+ids,
						success : function(data) {
							setTimeout(reloadUrl,2000);
							
						}
					});},function(){}
	 				);		
	 		//	}

	 		}
	 		
	 	});
	 });
   </script>
