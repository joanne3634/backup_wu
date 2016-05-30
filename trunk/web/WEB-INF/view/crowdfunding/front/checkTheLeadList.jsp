<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fnd" uri="http://www.deelon.com/jsp/jstl/functions" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>领投人列表</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">

   <script type="text/javascript">
   function reloadUrl(){
	   window.location.reload(true);
   }
   
   function lookInvestor(id){
	   $.dialog.open('${ctx}/crowdfunding/backstage/tcprojectinvest/getInvestDetailLeadById.ht?investId='+id, {
			title: '查看领投人详细',lock:true,width:'755px',top:'100px'});
}
   function approveProjectApply(projectId,investId,piisPay,processType){
	   if(piisPay==1&&processType==2){
		   art.dialog("您已经同意该投资，且投资人已经付款。不可以直接拒绝了，请联系投资人或管理人员协商。");
	   }else{
		   var messgae = "";
		   if(processType==1)
			   messgae="您确定同意投资者领投你的项目吗？";
		   if(processType==2)
			   messgae="您确定要拒绝投资者领投你的项目吗？";
		   art.dialog.confirm(messgae,function(){
			   jQuery.ajax({
					url : "${ctx}/crowdfunding/projectApply/approveCheckTheLead.ht?time="+new Date(),
					type : "post",
					data: "projectId="+projectId+"&investId="+investId+"&processType="+processType,
					success : function(data) {
						openDialog(data,'','','2',function(){
							reloadUrl();
						});
						setTimeout(reloadUrl,3000);
					}
				});
			},function(){});
	   }
		
}

   $(function(){
	 	$('.PrDyBackTable input[name="InvertSelection"]').click(function(){
	 		$('.PrDyBackTable input[name="checkbox"]').each(function(e,index){
	 			$(this).attr("checked",!$(this).attr("checked"));
	 		});
	 	});
	 	<%--	 	$('.PrDyBackDelebutton div').click(function(){
	 		var ids="";
	 		$('.PrDyBackTable input[name="checkbox"]').each(function(e,index){
	 			if($(this).attr("checked")){
	 				ids+=$(this).attr("id")+";";
	 				//$(this).parent().parent().remove();
	 			}
	 		});
	 		
	 		if(ids!=""){
	 			art.dialog.confirm("您确定删除吗",function(){
	 				$.ajax({
						url : "${ctx}/crowdfunding/projectApply/theLeadDel.ht?time="+new Date(),
						type : 'post',
						data: "ids="+ids,
						success : function(data) {
							art.dialog(data);
							setTimeout(reloadUrl,2000);
						}
					});			
	 			},function(){});

	 		}	
	 	});--%>
	 	$('.PrDyBackDelebutton #agreeAll').click(function(){
	 		var ids="";
	 		var check_count=0;
	 		$('.PrDyBackTable input[name="checkbox"]').each(function(e,index){
	 			if($(this).attr("checked")){
	 				//$(this).parent().parent().find('#audit').html('同意');
	 				ids=$(this).attr("id");check_count++;
	 			}
	 		});
	 		
	 		if(ids!=""){
	 			if(check_count>1){
	 				openDialog("对不起，只能设置一个领投人",'','','2',function(){});
	 			}else{
	 			 approveProjectApply('${tcproject.projectId}',ids,1);
	 			}
	 		}
	 	});
	 	$('.PrDyBackDelebutton #refuseAll').click(function(){
	 		var ids="";
	 		$('.PrDyBackTable input[name="checkbox"]').each(function(e,index){
	 			if($(this).attr("checked")){
	 				//$(this).parent().parent().find('#audit').html('拒绝');
	 				ids+=$(this).attr("id")+";";
	 			}
	 		});
	 		if(ids!=""){
	 				$.ajax({
						url : "${ctx}/crowdfunding/projectApply/approveCheckTheFollowByIds.ht?time="+new Date(),
						type : 'post',
						data: "ids="+ids+"&processType=2",
						success : function(data) {
							openDialog(data,'','','2',function(){
								reloadUrl();
							});
							setTimeout(reloadUrl,3000);
						}
					});			
	 		}else{
	 			openDialog("请选择领投人",'','','2',function(){
					reloadUrl();
				});
	 			//setTimeout(reloadUrl,2000);
	 		}		
	 	});
	 });

   
   
   </script>
</head>
<body>
	<div class="itemSettingIframe">
		<table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
			<tr><th width="30"><input type="checkbox" name="InvertSelection"/></th><th width="150">领投人</th><th width="150">领投金额</th>
			<!-- <th width="100">估值金额</th> --><th width="150">领投时间</th><th width="100">是否付款</th>
			<th width="150">是否反悔</th><th width="100">状态</th><th width="100">操作</th></tr>
		<c:if test="${!empty leadInvestList}">
		<c:forEach items="${leadInvestList}" var="lv">
			<tr>
			<td><input id="${lv.investId }" type="checkbox" name="checkbox"/></td>
			<td>${lv.realName}</td>
			<td><fmt:formatNumber value="${lv.piinvest / 10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>万</td>
			<%-- <td><fmt:formatNumber value="${lv.pivaluation / 10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>万</td> --%>
			<td><fmt:formatDate value="${lv.piinvestTime}" pattern="yyy-MM-dd HH:mm" /></td>
			<td>
			<c:if test="${lv.piisPay==0}">否</c:if>
			<c:if test="${lv.piisPay==1}">是</c:if>
			</td>
			<td>
			<c:if test="${lv.piisCancel==0}">否</c:if>
			<c:if test="${lv.piisCancel==1}">是</c:if>
			</td>
			<td>
			<c:if test="${lv.piisCheck==0}">未处理</c:if>
			<c:if test="${lv.piisCheck==1}">同意</c:if>
			<c:if test="${lv.piisCheck==2}">拒绝</c:if>
			</td>
			<td  class="operation">
			<a onclick="javascript:lookInvestor(${lv.investId })"><img src="${ctx}/crowdfunding/Skin/Default/images/LookIcont.png" title="查看"></a>
			<a onclick="javascript:approveProjectApply(${tcproject.projectId},${lv.investId },${lv.piisPay },2)"><img src="${ctx}/crowdfunding/Skin/Default/images/refuse.png" title="拒绝"></a>
			<a onclick="javascript:approveProjectApply(${tcproject.projectId},${lv.investId },${lv.piisPay },1)"><img src="${ctx}/crowdfunding/Skin/Default/images/consent.png" title="同意"></a></td>
			</tr>
			</c:forEach></c:if>
		</table>
		<div class="PrDyBackDelebutton">
			<div id="refuseAll">批量拒绝</div>
		</div>
			
		</div>
		
		</div>
	
</body>
</html>
