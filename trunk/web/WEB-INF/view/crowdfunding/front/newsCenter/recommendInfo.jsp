<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
<% 
int count=1;
int count1=1;
int count2=1;
%>
<form id="query_id_2_" action="${ctx}/loan/tuserMsgRemind/getMyPrivateInfos.ht?typeId=4" method="get">
        <div class="con-box-wodejiekuan">
         <table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
            <tr>
			<th width="30"><input type="checkbox" id="chkAll"/></th>
			<th width="80">序号</th>
			<th width="220">消息内容</th>
			<th width="220">项目名称</th>
			<th width="200">回复</th>
			<th width="95">发件人</th>
			<th width="150">发送时间</th>
			<th width="120">操作</th>
			</tr>
		<c:if test="${not empty recommodProInfos}">
		       <c:forEach var="recommodProInfo" items="${recommodProInfos}">
			<tr>
			<td><input type="checkbox" name="checkbox" id="checkbox<%=count1++%>" value="${recommodProInfo.msgRemindId}"/></td>
			<td>
			<c:if test="${recommodProInfo.stateId==0}"> 
			<img src="${ctx }/crowdfunding/Skin/Default/images/newxiaoxi.png" > 
			</c:if> 
			<%=count++%></td>
			
			<c:if test="${fn:length(recommodProInfo.content) > 25 }">
				<td>${fn:substring(recommodProInfo.content,0,25) }...</td>
			</c:if>
			<c:if test="${fn:length(recommodProInfo.content) <= 25 }">
				<td>${recommodProInfo.content }</td>
			</c:if>
			<td><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${recommodProInfo.projectId}" target="_blank">${recommodProInfo.pName}</a></td>
			<td>${recommodProInfo.replyTimes}</td>
			<td>${recommodProInfo.senderName}</td>
			<td><fmt:formatDate value="${recommodProInfo.sendTime}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
			<td><img src="${ctx }/crowdfunding/Skin/Default/images/LookIcont.png" title="查看" onclick="detailClick(${recommodProInfo.msgRemindId});" style="cursor: pointer;">
			<img src="${ctx }/crowdfunding/Skin/Default/images/replyIcont.png" title="回复" onclick="replyClick('${recommodProInfo.msgRemindId}','${recommodProInfo.senderName}');" style="cursor: pointer;">
			<img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png" title="删除" style="cursor: pointer;"  onclick="delRow(${recommodProInfo.msgRemindId});">
            </td></tr>
             </c:forEach>
        </c:if>
		<c:if test="${empty recommodProInfos }">
	         <tr><td colspan="8"><div  class="hint">暂无内容!</div><td></tr>
       </c:if>
          </table>
        </div>
        <div class="PrDyBackDelebutton">
			<div id="btn5" onclick="delSelect();">删除选中</div>
	     </div>
        <pageTag:paging form="query_id_2_"/>
        </form>
                  <script type="text/javascript">
                  function reloadUrl(){
           	  	   //window.location.reload(true);
                	document.forms[0].submit();
           	  }
//明细点击事件
	 function detailClick(MsgRemindId){
		 $.dialog.open("${ctx }/loan/tuserMsgRemind/PriInfoRemindDetails.ht?MsgRemindId="+MsgRemindId,
					{title:'详细内容',width:620,height:520,close:reloadUrl});
		  
	  }
	//回复点击
	 function replyClick(MsgRemindId,name){
		 $.dialog.open("${ctx }/loan/tuserMsgRemind/replyMsgRemind.ht?replyId="+MsgRemindId+"&receiverName="+name,
					{title:"消息回复"+name,width:620,height:520});
		  
	  }
	//删除选中的数据
	 function delSelect(){
		 var str="";
		 var intL = $("table tr td input:checked:not('#chkAll')").length; //获取除全选复选框外的所有选中项
		 if(intL == 0){
			 art.dialog("请选择要删除的项");
			 setTimeout(reloadUrl,2000);
		 }
         if (intL != 0) {//如果有选中项
             $("table tr td input[type=checkbox]:not('#chkAll')").each(function(index) {//遍历除全选复选框外的行
                 if (this.checked) {//如果选中
                	 str+=$(this).val()+","; //获取选中的值，并删除该值所在的行
                 }
             })
             art.dialog.confirm("你确定要删除",function(){
      			$.ajax({
      					url : "${ctx }/loan/tuserMsgRemind/delTUserMsgRemind.ht?msgRemindId="+str+"&flag="+2,
      					type : 'post',
      					success : function(data) {
      						if(data=="1"){
      							art.dialog("删除数据成功");
      							setTimeout(reloadUrl,2000);
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
 					url : "${ctx }/loan/tuserMsgRemind/delTUserMsgRemind.ht?msgRemindId="+MsgRemindId+"&flag="+2,
 					type : 'post',
 					success : function(data) {
 						if(data=="1"){
 							art.dialog("删除数据成功");
 							setTimeout(reloadUrl,2000);
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
	         
	         window.parent.parent.unReadMsgSet('${UnReadMsgCount}');
	      	 window.parent.unReadMsgSet('${UnReadMsgCur}','${userMsgFlag}');
			 
		  })
		  
 	</script>