<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>投后管理-投资者</title>
	<meta name="renderer" content="webkit"/>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
    <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   	<script type="text/javascript" src="${ctx }/crowdfunding/artDialog/jquery.artDialog.js?skin=default"></script>
   	<script type="text/javascript" src="${ctx }/crowdfunding/artDialog/iframeTools.js"></script>
   	
   	

</head>
<div class="PrDyBack f_l afterInves">
		<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">投后管理</h2>
		<form action=""   name="pageForm" id="pageForm" method="post">
		<table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
			<tr><th width="40">序号
			</th><th width="220">项目
			</th><th width="200">标题
			</th><th width="150">发送时间
			</th><th width="70">操作</th>
			</tr>
		    <c:if test="${not empty tcprojectAfterInvestorList}">
		        <c:forEach items="${tcprojectAfterInvestorList }" var="pa" varStatus="i">
			<tr>
			<td>${i.index + 1 }</td>
			<td>${pa.projectName }</td>
			<td>${pa.paTitle}</td><td>
			<fmt:formatDate value="${pa.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
			<td><img src="${ctx}/crowdfunding/Skin/Default/images/LookIcont.png" title="查看" onclick="detail('${pa.afterId}');" style="cursor: pointer;"></td>
			</tr>
			</c:forEach>
			</c:if>
			<c:if test="${empty tcprojectAfterInvestorList}">
			   <tr><td colspan="5"><div style="text-align:center;">暂无数据！</div></td></tr>
			</c:if>
		</table>
		<pageTag:paging form="pageForm"/>
		</form>
		<div >
	
		
			
			
	
		</div>
	</div>
	<script type="text/javascript">
	
	/*$('.PrDyBackTable #Look').click(function(){
		$.dialog.open('${ctx}/crowdfunding/tcprojectAfter/investorAfterDeail.ht?projectId='+, {
    			title: '投后管理详情',lock:true,width:'880px'});
	});*/
	
//查看详情
function detail(afterId){
	$.dialog.open('${ctx}/crowdfunding/tcprojectAfter/investorAfterDeail.ht?afterId='+afterId, {
		title: '投后管理详情',lock:true,width:'840px',height:'850px'});
}
	</script>
</html>