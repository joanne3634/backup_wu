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
							<div class="group"><f:a alias="search_TUserMessage" css="link search" id="btnSearch" href="javascript:void(0);" onclick="select();"><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>    
							<div class="group"><f:a alias="del_TUserMessage" css="link del" action="del.ht"><span></span>删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<input type="hidden" name="MessageId" value="${MessageId }"  />
									<span class="label">留言标题:</span><input type="text" name="Q_messageTitle_S" value="${param['Q_messageTitle_S']}" maxlength="500" class="inputText" />
								 </div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall" />
						</c:set>
					    <display:table name="TUserMessageItem" id="TUserMessageItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="messageId" id="messageId" value="${TUserMessageItem.messageId}"}>
							</display:column>
							<display:column property="messageTitle" title="留言标题" sortable="false" sortName="message_title" style="text-align:center;width:15%;"/>		 
							<display:column   title="留言用户" sortable="false" sortName="user_id" style="text-align:center;width:15%;"> 
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${TUserMessageItem.userId }"/>
							</display:column>
							<display:column  title="留言类型"  sortName="message_type" style="text-align:center;width:15%;">
								<f:description itemValue="${TUserMessageItem.messageType}" nodeKey="LYLX" />
							</display:column>  
                            <display:column  title="留言状态"  sortName="message_State" style="text-align:center;width:15%;">
								<f:description itemValue="${TUserMessageItem.messageState}" nodeKey="LYZT" />
							</display:column>  
							<%-- <display:column  title="回复状态"  sortName="message_IsReply" style="text-align:center;width:15%;">
								<f:description itemValue="${TUserMessageItem.messageIsReply}" nodeKey="HFZT" />
							</display:column>   --%>
                             <display:column  title="回复方式"  sortName="message_ReplyWay" style="text-align:center;width:15%;">
								<f:description itemValue="${TUserMessageItem.messageReplyWay}" nodeKey="HFFS2" />
							</display:column>  
							<display:column title="操作" media="html" style="text-align:center;"> 	
								<a href='edit.ht?messageId=${TUserMessageItem.messageId }' class="link edit">回复</a>	
								<a href='del.ht?messageId=${TUserMessageItem.messageId }'  class='link del'>删除</a> 
								<a href='get.ht?messageId=${TUserMessageItem.messageId }'  class="link detail">明细</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="TUserMessageItempage"/>
					</div>
				</div>			
	</div>
</body>
</html>
