<%@page import="com.deelon.loan.model.sysManager.TuserAudit"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=TuserAudit.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=TuserAudit.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tuserAudit" css="link search" id="btnSearch" >查询</f:a></div>
							<div class="l-bar-separator"></div>
							<%-- <div class="group"><f:a alias="add_tuserAudit" css="link add" href="edit.ht">添加</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tuserAudit" css="link update" action="edit.ht">修改</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tuserAudit" css="link del" action="del.ht">删除</f:a></div> --%>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">会员:</span><input type="text" name="Q_loginName_S" value="${tuserAudit.loginName}" maxlength="20" class="inputText" />
									<span class="label">真实姓名:</span><input type="text" name="Q_realName_S" value="${tuserAudit.realName}" maxlength="20" class="inputText" />
									<span class="label">审核人:</span><input type="text" name="Q_auditor_S" value="${tuserAudit.auditor}" maxlength="20" class="inputText" />
									<span class="label">状态:</span>
<%-- 									<f:select  nodeKey="jbxxzt" id="Q_userMsg_S" defaultValue="" showBlankOnTop="true" styleValue="width:50px"  /> --%>
<%-- 									<f:select  nodeKey="jbxxsh" id="Q_statusID_S" defaultValue="" showBlankOnTop="true" styleValue="width:50px"  /> --%>
									<f:select nodeKey="hyxxlx" id="Q_userMsg_S" showBlankOnTop="true" defaultValue="${param['Q_userMsg_S']}"></f:select>
									
									<%-- <select name="Q_userMsg_S" class="select"  value="${param['Q_userMsg_S']}">
										<option value="" selected>--选择--</option>
										<option value="0" <c:if test="${param['Q_userMsg_S'] == '0' }">selected</c:if>>个人信息</option>
										<option value="1" <c:if test="${param['Q_userMsg_S'] == '1' }">selected</c:if>>家庭信息</option>
										<option value="2" <c:if test="${param['Q_userMsg_S'] == '2' }">selected</c:if>>单位信息</option>
										<option value="3" <c:if test="${param['Q_userMsg_S'] == '3' }">selected</c:if>>联系信息</option>
									</select> --%>
									<f:select nodeKey="jbxxsh" id="Q_statusID_S" showBlankOnTop="true" defaultValue="${param['Q_statusID_S']}"></f:select>
									<%-- <select name="Q_statusID_S" class="select"  value="${param['Q_statusID_S']}">
										<option value="" selected>--选择--</option>
										<option value="0" <c:if test="${param['Q_statusID_S'] == '0' }">selected</c:if>>未填写</option>
										<option value="1" <c:if test="${param['Q_statusID_S'] == '1' }">selected</c:if>>未审核</option>
										<option value="2" <c:if test="${param['Q_statusID_S'] == '2' }">selected</c:if>>审核通过</option>
										<option value="3" <c:if test="${param['Q_statusID_S'] == '3' }">selected</c:if>>审核不通过</option>
									</select> --%>
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tuserAuditList" id="tuserAuditItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="userId" id="userId" value="${tuserAuditItem.userId}"}>
							</display:column>
							<display:column property="loginName" title="会员" sortable="false" sortName="loginName" style="text-align:center;width:10%;"/> 
							<display:column property="realName" title="真实姓名" sortable="false" sortName="realName" style="text-align:center;width:10%;"/> 
							<display:column property="idNo" title="身份证号码" sortable="false" sortName="idNo" style="text-align:center;width:15%;"/> 
							<display:column property="registerTime" title="注册时间" sortable="false" format="{0,date,yyyy-MM-dd hh:mm}" sortName="registerTime" style="text-align:center;width:12%;"/> 
							<display:column title="个人信息" sortable="false" sortName="userSafe" style="text-align:center;width:8%;">
								<f:description itemValue="${tuserAuditItem.userSafe}" nodeKey="jbxxsh" />
							</display:column>
							<display:column title="家庭信息" sortable="false" sortName="userFamily" style="text-align:center;width:8%;"> 
								<f:description itemValue="${tuserAuditItem.userFamily}" nodeKey="jbxxsh" />
							</display:column>
							<display:column title="单位信息" sortable="false" sortName="userCompany" style="text-align:center;width:8%;"> 
								<f:description itemValue="${tuserAuditItem.userCompany}" nodeKey="jbxxsh" />
							</display:column>
							<display:column title="联系信息" sortable="false" sortName="userContact" style="text-align:center;width:8%;"> 
								<f:description itemValue="${tuserAuditItem.userContact}" nodeKey="jbxxsh" />
							</display:column>
							<display:column property="auditorName" title="审核人" sortable="false" sortName="auditorName" style="text-align:center;width:7%;"/> 
							<display:column title="操作" media="html" style="text-align:center;">
								<a href='get.ht?userId=${tuserAuditItem.userId}' class="link edit">查看</a>	
							</display:column>
						</display:table>
						<deelon:paging tableId="tuserAuditItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
