<%@page import="com.deelon.loan.model.front.TuserCredit"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TuserCredit.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tuserCredit&formSave=Y"></script>
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
			        <c:when test="${tuserCredit.creditId!=null}">
			            <span class="tbar-label">编辑<%=TuserCredit.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=TuserCredit.TABLE_ALIAS%></span>
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
		<form id="tuserCreditForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">

							<tr>
<!-- 								<th width="25%">相关主键ID:</th>	
								<td>										 
									<input type="text" id="keyId" name="keyId" value="${tuserCredit.keyId}" class="inputText" />
								</td> -->
								<th width="25%">类型:</th>	
								<td>
									<f:select nodeKey="xylx" id="Q_typeId_S" showBlankOnTop="true" defaultValue="${param['Q_typeId_S']}"></f:select>
																		 
									<!-- <input type="text" id="typeId" name="typeId" value="${tuserCredit.typeId}" class="inputText" /> -->
								</td>
								<th width="25%">增加信用:</th>	
								<td>										 
									<input type="text" id="creditAdd" name="creditAdd" value="${tuserCredit.creditAdd}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">描述:</th>	
								<td>										 
									<!-- <input type="text" id="description" name="description" value="${tuserCredit.description}" class="inputText" /> -->
									<textarea rows="5" cols="5" id="description" name="description">${tuserCredit.description}</textarea>
									
								</td>
								<th width="25%">创建时间:</th>	
								<td>										 
									<input type="text" name="createTime" value="<fmt:formatDate value='${tuserCredit.createTime}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="inputText date" style="width:300px;"/>
								</td>
							</tr>
					</table>
					<input type="hidden" name="creditId" value="${tuserCredit.creditId}" />
				</form>
		</div>
</div>
</body>
</html>