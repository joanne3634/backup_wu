<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>项目申请查看列表</title>
	<meta name="renderer" content="webkit"/>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
  	<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.2.min.js"></script>
  	<script type="text/javascript" src="${ctx }/crowdfunding/artDialog/jquery.artDialog.js?skin=default"></script>
	<script type="text/javascript" src="${ctx }/crowdfunding/artDialog/iframeTools.js"></script>
  	
   <script type="text/javascript">
   function reloadUrl(){
	   window.location.reload(true);
   }
   function approveProjectApply(projectId,applyId,processType){
		$.ajax({
			url : "${ctx}/crowdfunding/projectApply/approveCheckTheView.ht?time="+new Date(),
			type : 'post',
			data: "projectId="+projectId+"&applyId="+applyId+"&processType="+processType,
			success : function(data) {
				//$("#processResult").html(data);
				art.dialog(data);
				setTimeout(reloadUrl,2000);
			}
		});	
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
	 		if(ids!=null && ids!=""){
	 			
	 			art.dialog.confirm("您确定删除吗",function(){
	 				$.ajax({
						url : "${ctx}/crowdfunding/projectApply/theViewDel.ht?time="+new Date(),
						type : 'post',
						data: "ids="+ids,
						success : function(data) {
							art.dialog(data);
							setTimeout(reloadUrl,2000);
						}
					});			
 				},function(){});
	 		}
	 	});
	 });

   </script>
</head>
<body>
<div class="itemSettingIframe">
		<table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
			<tr>
			<th width="30"><input type="checkbox" name="InvertSelection"/></th>
			<th width="220">申请人</th><th width="200">项目名称</th>
			<th width="150">申请时间</th>
			<th width="200">状态</th>
			<th width="70">操作</th></tr>
		<c:if test="${!empty tProjectApplyViewList}">
		<c:forEach items="${tProjectApplyViewList}" var="lv">
			<tr>
			<td><input id="${lv.applyViewId }" type="checkbox" name="checkbox"/></td>
			<td>${lv.realName}</td>
			<td>${tcproject.pname}</td>
			<td>
			<c:if test="${!empty lv.applyTime }">
			<fmt:formatDate value="${lv.applyTime}" pattern="yyy-MM-dd HH:mm" />
			</c:if>
			&nbsp;
			</td>
			<td>
			<c:if test="${lv.pavIsAgree==0}">未处理</c:if>
			<c:if test="${lv.pavIsAgree==1}">同意</c:if>
			<c:if test="${lv.pavIsAgree==2}">拒绝</c:if>
			</td>
			<td>
			<a onclick="javascript:approveProjectApply(${tcproject.projectId},${lv.applyViewId },2)"><img src="${ctx}/crowdfunding/Skin/Default/images/refuse.png" title="拒绝"></a>
			<a onclick="javascript:approveProjectApply(${tcproject.projectId},${lv.applyViewId },1)"><img src="${ctx}/crowdfunding/Skin/Default/images/consent.png" title="同意"></a></td>
			</tr>
			</c:forEach></c:if>
		</table>
		<div class="PrDyBackDelebutton">
			<div>删除选中</div><span id="processResult"></span>
		</div>
		
		</div>
	
</body>
</html>
