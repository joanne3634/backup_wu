<%@page import="com.deelon.loan.model.front.TUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>创业者管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">创业者管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tuser" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
<!-- 							<div class="l-bar-separator"></div> -->
<%-- 							<div class="group"><f:a alias="add_tuser" css="link add" href="edit.ht"><span></span>添加</f:a></div> --%>
<!-- 							<div class="l-bar-separator"></div> -->
<%-- 							<div class="group"><f:a alias="upd_tuser" css="link update" action="edit.ht"><span></span>修改</f:a></div> --%>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tuser" css="link del" action="del.ht"><span></span>删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">会员名:</span>
									<input type="text" name="Q_loginName_S" value="${param['Q_loginName_S']}" maxlength="20" class="inputText" />
									<span class="label">真实姓名:</span><input type="text" name="Q_realName_S" value="${param['Q_realName_S']}" maxlength="20" class="inputText" />

							</div>
<!-- 							<div class="row">
									<span class="label">注册时间从:</span><input type="text" id="registerTimeBegin" name="registerTimeBegin"  class="inputText date" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'registerTimeEnd\');}'})" value="${param['registerTimeBegin']}"/>
									<span class="label" style="text-align:center;width:40px;">至</span><input type="text" id="registerTimeEnd" name="registerTimeEnd"  class="inputText date" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'registerTimeBegin\');}'})"  value="${param['registerTimeEnd']}"/>
							</div> -->
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tuserAuditList" id="tuserAuditItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="userId" id="userId" value="${tuserAuditItem.userId}"/>
							</display:column>
							<display:column property="loginName" title="会员名" sortable="false" sortName="loginName" style="text-align:center"/> 
							<display:column property="realName" title="真实姓名" sortable="false" sortName="realName" style="text-align:center"/>
							<display:column property="contactName" title="联系人姓名" sortable="false" sortName="contactName" style="text-align:center"/>
							
							<display:column title="注册时间" sortable="false" sortName="RegisterTime" style="text-align:center">
								<fmt:formatDate value="${tuserAuditItem.registerTime}" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>
							<display:column title="审核人" sortable="false" sortName="checker" style="text-align:center">
								<c:if test="${tuserAuditItem.checker eq 0}">
									未审核
								</c:if>
								<c:if test="${tuserAuditItem.checker != 0}">
									<f:description modelCode="sys_user"  modelPropertyName="fullname" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tuserAuditItem.checker }"/>
								</c:if>
							</display:column>  
							<display:column title="审核状态" sortable="false" sortName="isCheck" style="text-align:center">
								<f:description nodeKey="jbxxsh"  itemValue="${tuserAuditItem.isCheck }"/>
							</display:column>  
							<display:column title="审核时间" sortable="false" sortName="checkTime" style="text-align:center">
								<c:if test="${empty tuserAuditItem.checkTime }">
									未审核
								</c:if>
								<fmt:formatDate value="${tuserAuditItem.checkTime}" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>
							<display:column title="操作" media="html" style="width:60px;">
								<a href='edit.ht?userId=${tuserAuditItem.userId}' class="link edit">编辑</a>	
								<!-- <a href='del.ht?userId=${tuserItem.userId}'  class='link del'>删除</a> -->														
							</display:column>
						</display:table>
						<deelon:paging tableId="tuserAuditItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
