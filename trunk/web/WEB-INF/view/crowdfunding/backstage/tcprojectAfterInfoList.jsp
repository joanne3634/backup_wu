<%@page import="com.deelon.crowdfunding.model.backstage.TcprojectNews"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=TcprojectNews.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=TcprojectNews.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tprojectAfters" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
<!-- 							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tprojectAfters" css="link add" href="edit.ht"><span></span>添加</f:a></div> -->
							<div class="l-bar-separator"></div>
							<%--<div class="group"><f:a alias="upd_tprojectAfters" css="link update" action="edit.ht"><span></span>修改</f:a></div>
							--%><%--<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tprojectAfters" css="link del" action="delShow.ht"><span></span>删除</f:a></div>
						--%></div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">项目名称:</span>
									<input type="text" name="Q_projectName_S" value="${param['Q_projectName_S']}" class="inputText" />
									
									<span class="label">标题:</span><input type="text" name="Q_paTitle_S" value="${param['Q_paTitle_S']}" maxlength="150" class="inputText" style="width: 150px;"/>
									<span class="label">类型:</span>
									<select id="paTypeId" name="Q_paTypeId_S">
									<option value="" ></option>
									<option value="1" <c:if test="${paTypeId==1 }">selected</c:if>>年度报表</option>
								 	<option value="2" <c:if test="${paTypeId==2 }">selected</c:if>>季度报表</option>
								 	<option value="3" <c:if test="${paTypeId==3 }">selected</c:if>>重大事件披露</option>
									</select>
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tcprojectAfterList" id="tprojectAfterItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<%--<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="afterId" id="afterId" value="${tprojectAfterItem.afterId}"}>
							</display:column>
							--%><display:column  title="项目名称" sortable="false" sortName="projectId" style="text-align:leftwidth:100px;">
								<%--<f:description modelCode="t_c_project"  modelPropertyName="pname" modelPropertyValue="projectId" nodeKey="MODEL_DATA"  itemValue="${tprojectAfterItem.projectId }"/>
							--%>
							<a title="点击查看" href="${ctx}/crowdfunding/backstage/proAudit/edit.ht?projectId=${tprojectAfterItem.projectId }&flag=tcAfter" ><f:description modelCode="t_c_project"  modelPropertyName="pname" modelPropertyValue="projectId" nodeKey="MODEL_DATA"  itemValue="${tprojectAfterItem.projectId }"/></a>
							</display:column> 	
							<display:column property="paTitle" title="事件标题" sortable="false" sortName="paTitle" style="text-align:left"/> 

							<display:column title="创建人" sortable="false" sortName="creator" style="text-align:left;width:100px;">
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tprojectAfterItem.creator }"/>
							</display:column> 
							<display:column title="类型" sortable="false" sortName="paTypeId" style="text-align:left;width:100px;">
								<c:choose>
										<c:when test="${tprojectAfterItem.paTypeId==1}">
											<span >年度报表</span>
						   				</c:when>
						   				<c:when test="${tprojectAfterItem.paTypeId==2}">
						   					<span >季度报表</span>
						   				</c:when>
						   				<c:when test="${tprojectAfterItem.paTypeId==3}">
						   					<span >重大事件披露</span>
						   				</c:when>
								</c:choose>		
							</display:column>
							<display:column property="createTime" title="创建时间" sortable="false" format="{0,date,yyy-MM-dd HH:mm}" sortName="createTime" style="text-align:left;width:110px;"/>
							<display:column title="操作" media="html" style="text-align:left;width:110px;">
							<a href='get.ht?afterId=${tprojectAfterItem.afterId}' class="link detail">查看</a>
								<a href='edit.ht?afterId=${tprojectAfterItem.afterId}' class="link edit">编辑</a>	
								<!-- <a href='del.ht?afterId=${tprojectAfterItem.afterId}'  class='link del'>删除</a>		 -->												
							</display:column>
						</display:table>
						<deelon:paging tableId="tprojectAfterItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
