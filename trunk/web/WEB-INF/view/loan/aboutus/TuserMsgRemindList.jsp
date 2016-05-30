<%@page import="com.deelon.loan.model.aboutus.TUserMessage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>管理</title>
	<%@include file="/commons/include/get.jsp" %>
	<script type="text/javascript">
		function select(){
			$("#searchForm").submit();
		}
	</script>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_TUserMsgRemind" css="link search" id="btnSearch" href="javascript:void(0);" onclick="select();"><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>    
							<%-- <div class="group"><f:a alias="del_tuserMsgRemindItem" css="link del" action="del.ht"><span></span>删除</f:a></div> --%>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
								<%-- 	<input type="hidden" name="MessageId" value="${tuserMsgRemindItem.msgRemindId }"  /> --%>
									<span class="label">消息内容:</span><input type="text" name="Q_content_S" value="${param['Q_content_S']}" maxlength="500" class="inputText" />
									<span class="label">发送人:</span><input type="text" name="Q_senderName_S" value="${param['Q_senderName_S']}" maxlength="500" class="inputText" />
									<span class="label">接收人:</span><input type="text" name="Q_recevierName_S" value="${param['Q_recevierName_S']}" maxlength="500" class="inputText" />								
								 </div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall" />
						</c:set>
					    <display:table name="tuserMsgRemindItem" id="tuserMsgRemindItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="msgRemindId" id="msgRemindId" value="${tuserMsgRemindItem.msgRemindId}"}>
							</display:column>
						 <display:column  title="消息内容" property="content"  style="width:320px;text-align:left;">
								<%-- <f:description itemValue="${tuserMsgRemindItem.content}" /> --%>
							</display:column>
							<display:column title="发送人" sortable="false" sortName="senderID" style="width:100px;text-align:center;"> 
	<%-- 							<f:description modelCode="sys_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tuserMsgRemindItem.senderId }"/> --%>
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tuserMsgRemindItem.senderId }"/>
							</display:column>
							<display:column title="发送时间" sortable="false" sortName="SendTime" style="width:100px;text-align:center;">
								<fmt:formatDate value="${tuserMsgRemindItem.sendTime}" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>     
							<%-- <display:column property="content" title="提醒内容"  style="text-align:center;width:32%;"/> --%>
							<display:column   title="接收人" sortable="false" sortName="receiverId" style="width:100px;text-align:center;"> 
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tuserMsgRemindItem.receiverId }"/>
							</display:column> 
							<display:column  title="状态"  sortName="stateID" style="width:50px;text-align:center;">
								<f:description itemValue="${tuserMsgRemindItem.stateId}" nodeKey="LYZT" />
							</display:column> 
							   
							<display:column title="读取时间" sortable="false" sortName="ReadTime" style="width:100px;text-align:center;">
								<fmt:formatDate value="${tuserMsgRemindItem.readTime}" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>    
							<display:column title="操作" media="html" style="width:50px;text-align:center;"> 	 
								<%-- <a href='del.ht?msgRemindId=${tuserMsgRemindItem.msgRemindId }'  class='link del'>删除</a>  --%>
								<a href='get.ht?msgRemindId=${tuserMsgRemindItem.msgRemindId }'  class="link detail">明细</a>														
							</display:column> 
						</display:table>
						<deelon:paging tableId="tuserMsgRemindpage"/>
					</div>
				</div>			
	</div>
</body>
</html>
