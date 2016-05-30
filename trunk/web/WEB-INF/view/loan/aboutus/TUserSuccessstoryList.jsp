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
						    <div class="group"><f:a alias="add_cmsSiteMenuContent" css="link add" href="edit.ht?siteMenuId=${siteMenuId }"><span></span>添加</f:a></div>
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
									<span class="label">标题:</span><input type="text" name="Q_subject_S" value="${param['Q_subject_S']}" maxlength="500" class="inputText" />
								 </div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall" />
						</c:set>
					    <display:table name="TUserSuccessstoryList" id="TUserSuccessstoryList" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="messageId" id="messageId" value="${TUserSuccessstoryList.successstoryId}"}>
							</display:column>
							<display:column property="subject" title="标题" sortable="false" sortName="Subject" style="text-align:center;width:27%;"/>		 
							<display:column title="类型(借入、借出)" sortable="false" sortName="GroupID" style="text-align:center;width:18%;"> 
								<f:description itemValue="${TUserSuccessstoryList.groupId}" nodeKey="USERS_GROUP" />
							</display:column>
							
                            <display:column  title="创建时间"  sortName="CreateTime" style="text-align:center;width:18%;">
								<fmt:formatDate value="${TUserSuccessstoryList.createTime}" pattern="yyyy-MM-dd HH:MM"/>
							</display:column>  
                             <display:column  title="分享人"  sortName="user_id" style="text-align:center;width:10%;">
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${TUserSuccessstoryList.userId }"/>
							</display:column>  
							<display:column title="操作" media="html" style="text-align:center"> 	
								<a href='edit.ht?messageId=${TUserSuccessstoryList.successstoryId }' class="link edit">编辑</a>	
								<a href='del.ht?messageId=${TUserSuccessstoryList.successstoryId }'  class='link del'>删除</a> 
								<a href='get.ht?messageId=${TUserSuccessstoryList.successstoryId }'  class="link detail">明细</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="TUserSuccessstoryItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
