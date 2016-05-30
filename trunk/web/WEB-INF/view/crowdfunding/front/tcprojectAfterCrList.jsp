<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>会员前台-投后管理</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
	
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
 <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/projectInvest.css">

	<style type="text/css">

.addPrSubButton{
	background: #8ec017;
	color: #fff;
	font-size: 14px;
	margin-left: 10px;
	cursor: pointer;
	padding: 5px 10px 5px 10px;
	}
	
	
	</style>
</head>
<body>

	<div class="PrDyBack f_l afterInves">
		<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">投后管理</h2>
		<form action=""   name="pageForm" id="pageForm" method="post">
		<div class="project_search"><span>
		 项目：<input type="text" id="projectName" name="projectName" value="${projectName }" /> 
	    标题：<input type="text" id="paTitle" name="paTitle" value="${paTitle }" />
		</span>
	    <span class="addPrSubButton" onclick="submitForm()">查&nbsp;询</span>
	    <span class="addPrSubButton" onclick="clearForm()()">清&nbsp;空</span>
	    </div>
		<div class="AfIndiv"><span class="greenButton f_r" id="shijian">+添加事件或附件</span><div class="clear"></div></div>
		<table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
			<tr>
			<th width="30"><input type="checkbox" name="InvertSelection"/></th>
			<th width="40">序号</th>
			<th width="220">项目</th>
			<th width="200">标题</th>
			<th width="150">创建时间</th>
			<th width="70">操作</th>
			</tr>
			<c:if test="${empty tcprojectAfterList }">
				<tr><td colspan="6"><div style="text-align:center;">暂无数据！</div></td></tr>
			</c:if>
			<c:forEach items="${tcprojectAfterList }" var="pa" varStatus="s">
			<tr id="${pa.afterId }">
			<td><input type="checkbox" name="checkbox"/></td>
			<td>${s.index+1 }</td>
			<td>${pa.projectName }</td>
			<td>${pa.paTitle }</td>
			<td><fmt:formatDate value="${pa.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
			<td><img src="${ctx }/crowdfunding/Skin/Default/images/LookIcont.png" title="查看" id="Look">
			<img src="${ctx }/crowdfunding/Skin/Default/images/editIcont3.png" title="编辑" id="edit">
			<img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png" title="删除" id="delete"></td>
			</tr>
		</c:forEach>
		
		</table>
		<div class="PrDyBackDelebutton">
			<div>删除选中</div>
			
		</div>
		<pageTag:paging form="pageForm"/>
	</div>
</body>
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
	 		var ids= "";
	 		$('.PrDyBackTable input[name="checkbox"]').each(function(e,index){
	 			if($(this).attr("checked")){
	 				//$(this).parent().parent().remove();
	 				ids+=$(this).parent().parent().attr("id")+";";
	 			}
	 		});
	 		if(ids!=""){
	 			art.dialog.confirm("您确定删除吗",function(){
	 				$.ajax({
						url : "${ctx}/crowdfunding/tcprojectAfter/projectAfterDelByIds.ht?time="+new Date(),
						type : 'post',
						data: "ids="+ids,
						success : function(data) {
							//art.dialog(data);
							window.parent.openDialog(data);
							setTimeout(reloadUrl,2000);
						}
					});			
	 			},function(){});

	 		}else{
	 			window.parent.openDialog("请选择数据");
	 		}
	 	});
	 	$('.PrDyBackTable').on('click','#delete',function(){
	 		var ids = $(this).parent().parent().attr("id");
	 		art.dialog.confirm("您确定删除吗",function(){
	 		$.ajax({
				url : "${ctx}/crowdfunding/tcprojectAfter/projectAfterDelByIds.ht?time="+new Date(),
				type : 'post',
				data: "ids="+ids,
				success : function(data) {
					//art.dialog(data);
					window.parent.openDialog(data);
					setTimeout(reloadUrl,2000);
				}
			});			
	 		},function(){});
	 	});
	 $('#shijian').click(function(){
		 var afterId = $(this).parent().attr("id");
	 	$.dialog.open('${ctx}/crowdfunding/tcprojectAfter/projectAfterForm.ht', {
			title: '添加事件',width:'1000px',height:'550px',lock:true});
	 });
	 $('.PrDyBackTable #edit').click(function(){
		 var afterId = $(this).parent().parent().attr("id");
	 	$.dialog.open('${ctx}/crowdfunding/tcprojectAfter/projectAfterEdit.ht?afterId='+afterId, {
			title: '编辑事件',width:'750px',height:'550px',lock:true});
	 });
	 $('.PrDyBackTable #Look').click(function(){
		 var afterId = $(this).parent().parent().attr("id");
	 	$.dialog.open('${ctx}/crowdfunding/tcprojectAfter/projectAfterDetail.ht?afterId='+afterId, {
			title: '查看内容',width:'840px',height:'850px',lock:true});
	 });
});
function clearForm(userId){
	$("#projectName").val("");
	$("#paTitle").val("");
}
function submitForm(userId){
	$("#pageForm").submit();
}

function rt(){
	alert(69);
}


 
</script>
</html>