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
	<title>跟投人列表</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
  	
   <script type="text/javascript">
   function reloadUrl(){
	   window.location.reload(true);
   }
   function lookInvestor(id){
	   $.dialog.open('${ctx}/crowdfunding/backstage/tcprojectinvest/getInvestDetailFollowById.ht?investId='+id, {
			title: '查看跟投人详细',lock:true,width:'755px',top:'100px'});
}
   function approveProjectApply(projectId,investId,piisPay,ischeck,processType){
	   if(2 == ischeck){
		   art.dialog("您已经拒绝该投资，不能进行操作。");
		   return;
	   }
	   if(piisPay==1&&processType==2){
		   art.dialog("您已经同意该投资，且投资人已经付款。不可以直接拒绝了，请联系投资人或管理人员协商。");
	   }else{
		   var messgae = "";
		   if(processType==1)
			   messgae="您确定同意投资者跟投你的项目吗？";
		   if(processType==2)
			   messgae="您确定要拒绝投资者跟投你的项目吗？";
			   art.dialog.confirm(messgae,function(){
				   jQuery.ajax({
						url : "${ctx}/crowdfunding/projectApply/approveCheckTheFollow.ht?time="+new Date(),
						type : "post",
						data: "projectId="+projectId+"&investId="+investId+"&processType="+processType,
						success : function(data) {
							//$("#processResult").html(data);
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
	 		var checkFlag = "0";
	 		$('.PrDyBackTable input[name="checkbox"]').each(function(e,index){
	 			if($(this).attr("checked")){
	 				//$(this).parent().parent().find('#audit').html('同意');
	 				var check = $(this).data('piis-check');
	 				if(2 == check || "2" == check){
	 					checkFlag = "1";
	 				}
	 				ids+=$(this).attr("id")+";";
	 			}
	 		});
	 		if("1" == checkFlag || 1 == checkFlag){
	 			 art.dialog("您选择了已拒绝的记录，请取消勾选后再次操作！");
	 			 return;
	 		}
	 		if(ids!=""){
 				$.ajax({
					url : "${ctx}/crowdfunding/projectApply/approveCheckTheFollowByIds.ht?time="+new Date(),
					type : 'post',
					data: "ids="+ids+"&processType=1",
					success : function(data) {
						openDialog(data,'','','2',function(){
							reloadUrl();
						});
						setTimeout(reloadUrl,3000);
					}
				});			
 		}else{
 			openDialog("请选择跟投人",'','','2',function(){
 				reloadUrl();
			});
 			//setTimeout(reloadUrl,3000);
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
	 		
	 		//判断选中的项中 是否有已经付过款了的
	 		var investname="";
		
	 		if(ids!=""){
	 			var arry=ids.split(";");
	 			for(var i in arry){
	 				if(arry[i]!=''){
		 				var	piisPay=document.getElementById(arry[i]+"piisPay").value;
		 				if(piisPay=='1'||piisPay==1){
		 					var name=document.getElementById(arry[i]+"name").value;
		 					investname+=name+"  ";
		 				}
	 				}
	 			}
		 		if(investname!=''){
		 			  art.dialog("您已经同意了跟投人  【"+investname+"】的投资，且跟投人已经付款。不可以直接拒绝了，请联系投资人或管理人员协商。");
		 			  return ;
		 		}
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
 			openDialog("请选择跟投人",'','','2',function(){
 				reloadUrl();
			});
 			//setTimeout(reloadUrl,3000);
 		}	
	 	});
	 });
   

   </script>
</head>
<body>
	<div class="itemSettingMoeny" style="margin: 30px 0px 0px 3px;" ><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">&nbsp;&nbsp;
						融资金额：<fmt:formatNumber value="${tcproject.pfinancingAmount / 10000}" pattern="###,###"  minFractionDigits="0"  ></fmt:formatNumber>万&nbsp;&nbsp;&nbsp;&nbsp;
						认投金额：<fmt:formatNumber value="${tcproject.pinvestAmount / 10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>万&nbsp;&nbsp;&nbsp;&nbsp;认投完成率： ${tcproject.pcomplete }% </div>
	<div class="itemSettingIframe">
		<table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
			<tr><th width="30"><input type="checkbox" name="InvertSelection"/></th><th width="100">跟投人</th><th width="100">跟投金额</th>
			<!-- <th width="100">估值金额</th> --><th width="120">跟投时间</th><th width="100">是否付款</th>
			<th width="100">是否反悔</th><th width="100">状态</th><th width="100">操作</th></tr>
		<c:if test="${!empty followInvestList}">
		<c:forEach items="${followInvestList}" var="lv">
			<tr>
			<td><input id="${lv.investId }" type="checkbox" name="checkbox" data-piis-check="${lv.piisCheck }"/></td>
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
			<input type="hidden" id="${lv.investId }piisPay" value="${lv.piisPay }"/>
			<input type="hidden" id="${lv.investId }name" value="${lv.realName}">
			<a onclick="javascript:lookInvestor(${lv.investId })"><img src="${ctx}/crowdfunding/Skin/Default/images/LookIcont.png" title="查看"></a>
			<a onclick="javascript:approveProjectApply(${tcproject.projectId},${lv.investId },${lv.piisPay },${lv.piisCheck},2)"<c:if test="${lv.piisCheck==2 }"> style="display:none"</c:if>><img src="${ctx}/crowdfunding/Skin/Default/images/refuse.png" title="拒绝"></a>
			<a onclick="javascript:approveProjectApply(${tcproject.projectId},${lv.investId },${lv.piisPay },${lv.piisCheck},1)"<c:if test="${lv.piisCheck==2 }"> style="display:none"</c:if>><img src="${ctx}/crowdfunding/Skin/Default/images/consent.png" title="同意"></a></td>
			
			
			</tr>
			
			</c:forEach></c:if>
		</table>
		<div class="PrDyBackDelebutton">
			<div id="agreeAll">批量同意</div>
			<div id="refuseAll">批量拒绝</div>
		</div>
		
		</div>
	
</body>
</html>
