<%@page import="com.deelon.loan.model.sysManager.TuserAudit"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TuserAudit.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tuserAudit&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse);
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tuserAudit.userId!=null}">
			            <span class="tbar-label">编辑<%=TuserAudit.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=TuserAudit.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tuserAuditForm" method="post" action="save.html">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">帐号:</th>	
								<td>										 
									<input type="text" id="loginName" name="loginName" value="${tuserAudit.loginName}" class="inputText" />
								</td>
								<th width="25%">真实姓名:</th>	
								<td>										 
									<input type="text" id="realName" name="realName" value="${tuserAudit.realName}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">身份证号码:</th>	
								<td>										 
									<input type="text" id="idNo" name="idNo" value="${tuserAudit.idNo}" class="inputText" />
								</td>
								<th width="25%">registerTime:</th>	
								<td>										 
									<input type="text" name="registerTime" value="<fmt:formatDate value='${tuserAudit.registerTime}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">个人信息:</th>	
								<td>										 
									<input type="text" id="userSafe" name="userSafe" value="${tuserAudit.userSafe}" class="inputText" />
								</td>
								<th width="25%">家庭信息:</th>	
								<td>										 
									<input type="text" id="userFamily" name="userFamily" value="${tuserAudit.userFamily}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">单位信息:</th>	
								<td>										 
									<input type="text" id="userCompany" name="userCompany" value="${tuserAudit.userCompany}" class="inputText" />
								</td>
								<th width="25%">联系信息:</th>	
								<td>										 
									<input type="text" id="userContact" name="userContact" value="${tuserAudit.userContact}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">审核人:</th>	
								<td>										 
									<input type="text" id="auditor" name="auditor" value="${tuserAudit.auditor}" class="inputText" />
								</td>
							</tr>
					</table>
					<input type="hidden" name="userId" value="${tuserAudit.userId}" />
				</form>
		</div>
</div>
</body>
</html>