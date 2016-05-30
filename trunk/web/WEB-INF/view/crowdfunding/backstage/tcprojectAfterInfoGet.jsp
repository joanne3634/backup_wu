<%@page import="com.deelon.crowdfunding.model.backstage.TcprojectAfter"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TcprojectAfter.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=TcprojectAfter.TABLE_ALIAS%>明细</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th>项目名称:</th>	
							<td>
							<f:description modelCode="t_c_project"  modelPropertyName="pname" modelPropertyValue="projectId" nodeKey="MODEL_DATA"  itemValue="${tcprojectAfter.projectId }"/>
							</td>
							<th>类型</th>	
							<td>
								<c:choose>
										<c:when test="${tcprojectAfter.paTypeId==1}">
											<span >年度报表</span>
						   				</c:when>
						   				<c:when test="${tcprojectAfter.paTypeId==2}">
						   					<span >季度报表</span>
						   				</c:when>
						   				<c:otherwise>
						   				<span >重大事件披露</span>
						   				</c:otherwise>
								</c:choose>			
							</td>
						</tr>
						<tr>
							<th>标题:</th>	
							<td>${tcprojectAfter.paTitle}</td>
							<th>内容:</th>	
							<td>${tcprojectAfter.paContent}</td>
						</tr>
						<tr>
							<th>创建人:</th>	
							<td>
							<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tcprojectAfter.creator}"/>
							</td>
							<th>创建时间:</th>	
							<td>
							<fmt:formatDate value="${tcprojectAfter.createTime}" pattern="yyyy-MM-dd HH:mm" />
							</td>
						</tr>
						<%--<tr>
							<th >附件:</th>	
							<td  colspan="3">
							
							</td>
						</tr>
					--%></table>
				</form>
		</div>
</div> 
</body>
</html>