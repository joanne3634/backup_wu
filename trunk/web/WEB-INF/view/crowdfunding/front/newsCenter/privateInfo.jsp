<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
<% 
int count=1;
int count1=1;
int count2=1;
%>
</head>
<body style="min-height:650px; ">
<form id="query_id_1_" action="${ctx}/loan/tuserMsgRemind/getMyPrivateInfos.ht" method="post">
       <%-- <div class="con-box-wodejiekuan">--%> 
       <div class="con-box con-box-huankuaning con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main">
         <table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
		  <tr>
			<th width="20"><input type="checkbox" id="chkAll"/></th>
			<th width="80">序号</th>
			<th width="220">消息内容</th>
			<th width="200">回复</th>
			<th width="95">发件人</th>
			<th width="150">发送时间</th>
			<th width="130">操作</th>
			</tr>
		<c:if test="${not empty privateInfos }">	
		<c:forEach var="privateInfo" items="${privateInfos}">
			<tr>
			<td><input type="checkbox" name="checkbox" id="checkbox<%=count1++%>" value="${privateInfo.msgRemindId}"/></td>
			<td>
			<c:if test="${privateInfo.stateId==0}"> 
			<img src="${ctx }/crowdfunding/Skin/Default/images/newxiaoxi.png" > 
			</c:if> 
			<%=count++%></td>
			
			<c:if test="${fn:length(privateInfo.content) > 25 }">
				<td>${fn:substring(privateInfo.content,0,25) }...</td>
			</c:if>
			<c:if test="${fn:length(privateInfo.content) <= 25 }">
				<td>${privateInfo.content }</td>
			</c:if>
			
			<td onclick="detailClick(${privateInfo.msgRemindId});" style="cursor: pointer;">${privateInfo.replyTimes}</td>
			<td>${privateInfo.senderName}</td>
			<td><fmt:formatDate value="${privateInfo.sendTime}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate></td>
			<td>
			<%-- <img src="${ctx }/crowdfunding/Skin/Default/images/LookIcont.png" title="查看" onclick="detailClick(${privateInfo.msgRemindId});" style="cursor: pointer;">
			<img src="${ctx }/crowdfunding/Skin/Default/images/replyIcont.png" title="回复" onclick="replyClick('${privateInfo.msgRemindId}','${privateInfo.senderName}');" style="cursor: pointer;">
			<img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png" title="删除" style="cursor: pointer;"  onclick="delRow(${privateInfo.msgRemindId});"> --%>
			
			<a style="cursor: pointer; color: #ff5500;" href="javascript:void(0);" onclick="detailClick(${privateInfo.msgRemindId});">查看</a>
			<a style="cursor: pointer; color: #ff5500;" href="javascript:void(0);" onclick="replyClick('${privateInfo.msgRemindId}','${privateInfo.senderName}');">回复</a>
			<a style="cursor: pointer; color: #ff5500;" href="javascript:void(0);" onclick="delRow(${privateInfo.msgRemindId});">删除</a>
			
            </td>
            </tr>
             </c:forEach>
             </c:if>
             <c:if test="${empty privateInfos }">
	             <tr><td colspan="7"><div  class="hint">暂无内容!</div></td></tr>
            </c:if>
		</table>
		</div>
		<div class="PrDyBackDelebutton">
			<div id="btn5" onclick="delSelect();">删除选中</div>
	     </div>
        <pageTag:paging form="query_id_1_"/>
        </form>
        <script type="text/javascript">
        function reloadUrl(){
 	  	   //window.location.reload(true);
        	//location.href="${ctx}/loan/tuserMsgRemind/getMyPrivateInfos.ht";
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
			 openDialog("请选择要删除的项",'','','2',function(){reloadUrl()});
		 }
         if (intL != 0) {//如果有选中项
             $("table tr td input[type=checkbox]:not('#chkAll')").each(function(index) {//遍历除全选复选框外的行
                 if (this.checked) {//如果选中
                	 str+=$(this).val()+","; //获取选中的值，并删除该值所在的行
                 }
             })
             art.dialog.confirm("你确定要删除",function(){
            	 //flag =2表示接收者删除信息
      			$.ajax({
      					url : "${ctx }/loan/tuserMsgRemind/delTUserMsgRemind.ht?msgRemindId="+str+"&flag="+2,
      					type : 'post',
      					success : function(data) {
      						if(data=="1"){
      							openDialog("删除数据成功",'','','2',function(){reloadUrl();});
      						}
      						setTimeout(reloadUrl,3000);
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
			 

	        	 window.parent.parent.unReadMsgSet('${UnReadMsgCount}');
	        	 window.parent.unReadMsgSet('${UnReadMsgCur}','${userMsgFlag}');
	         
			 
		  })
		  
		 
		  
 	</script>
 	
 	</body>
</html>