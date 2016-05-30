<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<% 
int count=1;
int count1=1;
int count2=1;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>发件箱</title>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<meta name="renderer" content="webkit"/>
   	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body style="min-height:650px; ">
<div class="PrDyBack f_l">

		<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">发件箱</h2>
		
			<!--发件箱列表-->
			<div class="con-box con-box-huankuaning con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main">
		 <table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
		  <tr>
			<th width="30"><input type="checkbox" id="chkAll"/></th>
			<th width="80">序号</th>
			<th width="220">消息内容</th>
			<th width="95">收件人</th>
			<th width="150">发送时间</th>
			<th width="120">操作</th>
			</tr>
		<c:forEach var="outBoxData" items="${outBoxData}">
			<tr>
			<td><input type="checkbox" name="checkbox" id="checkbox<%=count1++%>" value="${outBoxData.msgRemindId}"/></td>
			<td><%=count++%></td>
			<td>${outBoxData.content}</td>
			<td>${outBoxData.recevierName}</td>
			<td><fmt:formatDate value="${outBoxData.sendTime}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate></td>
			<td><img src="${ctx }/crowdfunding/Skin/Default/images/LookIcont.png" title="查看" onclick="detailClick(${outBoxData.msgRemindId});" style="cursor: pointer;">
			<img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png" title="删除" style="cursor: pointer;"  onclick="delRow(${outBoxData.msgRemindId});">
            </td></tr>
             </c:forEach>
		</table>
		 </div>

		 <div class="PrDyBackDelebutton">
			<div id="btn5" onclick="delSelect();">删除选中</div>
		</div>
		<form id="pageForm" name="pageForm" action="">
		  <pageTag:paging form="pageForm"/>
        </form> 
	</div>
	<script type="text/javascript">
	  function reloadUrl(){
	  	   window.location.reload(true);
	  }
	//明细点击事件
	 function detailClick(MsgRemindId){
		 $.dialog.open("${ctx }/loan/tuserMsgRemind/PriInfoRemindDetails.ht?MsgRemindId="+MsgRemindId,
					{title:'详细内容',width:620,height:520});
		  
	  }
	
	//删除选中的数据
	 function delSelect(){
		 var str="";
		 var intL = $("table tr td input:checked:not('#chkAll')").length; //获取除全选复选框外的所有选中项
		 if(intL == 0){
			 openDialog("请选择要删除的项",'','','2',function(){reloadUrl();});
			 setTimeout(reloadUrl,3000);
		 }
         if (intL != 0) {//如果有选中项
             $("table tr td input[type=checkbox]:not('#chkAll')").each(function(index) {//遍历除全选复选框外的行
                 if (this.checked) {//如果选中
                	 str+=$(this).val()+","; //获取选中的值，并删除该值所在的行
                 }
             })
             //flag =1表示发送者者删除信息
             art.dialog.confirm("你确定要删除",function(){
      			$.ajax({
      					url : "${ctx }/loan/tuserMsgRemind/delTUserMsgRemind.ht?msgRemindId="+str+"&flag="+1,
      					type : 'post',
      					success : function(data) {
      						if(data=="1"){
      							openDialog("删除数据成功",'','','2',function(){reloadUrl();});
      							setTimeout(reloadUrl,3000);
      						}
      					}
      			});
      		},function(){});
         }
	}
 //删除单行
   function delRow(MsgRemindId){
	   art.dialog.confirm("你确定要删除",function(){
 			$.ajax({
 					url : "${ctx }/loan/tuserMsgRemind/delTUserMsgRemind.ht?msgRemindId="+MsgRemindId+"&flag="+1,
 					type : 'post',
 					success : function(data) {
 						if(data=="1"){
 							openDialog("删除数据成功",'','','2',function(){reloadUrl();});
 							setTimeout(reloadUrl,3000);
 						}
 					}
 			});
 		},function(){});
	   
 }
	 $(function(){
		 /**全选复选框单击事件**/
         $("#chkAll").click(function() {
             if (this.checked) {//如果自己被选中
                 $("table tr td input[type=checkbox]").attr("checked", true);
             }
             else {//如果自己没有被选中
                 $("table tr td input[type=checkbox]").attr("checked", false);
             }
         })
         
		 
	  })
	  
	 
	</script>
</body>
</html>