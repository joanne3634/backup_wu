<%@page import="com.deelon.loan.model.TuserLog"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TuserLog.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tuserLog&formSave=Y"></script>
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
			        <c:when test="${tuserLog.loginLogId!=null}">
			            <span class="tbar-label">编辑<%=TuserLog.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=TuserLog.TABLE_ALIAS%></span>
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
		<form id="tuserLogForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">会员ID:</th>	
								<td>										 
									<input type="text" id="userId" name="userId" value="${tuserLog.userId}" class="inputText" />
								</td>
								<th width="25%">日志类型：1登录,2退出,3操作:</th>	
								<td>										 
									<input type="text" id="typeId" name="typeId" value="${tuserLog.typeId}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">模块ID:</th>	
								<td>										 
									<input type="text" id="modelId" name="modelId" value="${tuserLog.modelId}" class="inputText" />
								</td>
								<th width="25%">模块名称:</th>	
								<td>										 
									<input type="text" id="modelName" name="modelName" value="${tuserLog.modelName}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">操作名称:</th>	
								<td>										 
									<input type="text" id="actionName" name="actionName" value="${tuserLog.actionName}" class="inputText" />
								</td>
								<th width="25%">发生时间:</th>	
								<td>										 
									<input type="text" name="actionTime" value="<fmt:formatDate value='${tuserLog.actionTime}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">平台：1电脑,2手机:</th>	
								<td>										 
									<input type="text" id="platformId" name="platformId" value="${tuserLog.platformId}" class="inputText" />
								</td>
								<th width="25%">客户IP/客户设备ID(手机):</th>	
								<td>										 
									<input type="text" id="clientIpdeviceId" name="clientIpdeviceId" value="${tuserLog.clientIpdeviceId}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">结果ID：1成功 2失败:</th>	
								<td>										 
									<input type="text" id="resultId" name="resultId" value="${tuserLog.resultId}" class="inputText" />
								</td>
								<th width="25%">操作描述:</th>	
								<td>										 
									<input type="text" id="remarks" name="remarks" value="${tuserLog.remarks}" class="inputText" />
								</td>
							</tr>
					</table>
					<input type="hidden" name="loginLogId" value="${tuserLog.loginLogId}" />
				</form>
		</div>
</div>
</body>
</html>