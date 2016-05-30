<%@page import="com.deelon.loan.model.sysManager.Tinfotemplatparam"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=Tinfotemplatparam.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=Tinfotemplatparam.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tinfotemplatparam" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
<%-- 							<div class="group"><f:a alias="add_tinfotemplatparam" css="link add" href="edit.ht"><span></span>添加</f:a></div> --%><!-- 添加参数在模板编辑中 -->
<!-- 							<div class="l-bar-separator"></div> -->
							<div class="group"><f:a alias="upd_tinfotemplatparam" css="link update" action="edit2.ht"><span></span>修改</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tinfotemplatparam" css="link del" action="del.ht"><span></span>删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<style>
								.label{
									text-align:right;
								}
							</style>
							<div class="row">
									<span class="label">模板名称:</span><input type="text" name="Q_templateName_S" value="${param['Q_templateName_S']}" maxlength="19" class="inputText" />
									<span class="label">参数名称:</span><input type="text" name="Q_paramName_S" value="${param['Q_paramName_S']}" maxlength="64" class="inputText" />
									<span class="label">参数说明:</span><input type="text" name="Q_comments_S" value="${param['Q_comments_S']}" maxlength="256" class="inputText" />
									<%--<span class="label">创建时间:</span><input type="text" name="Q_createTimeBegin_DL" value="${param['Q_createTimeBegin_DL']}" class="inputText date" style="width:9%"/>
									<span class="label" style="width:40px;text-align:center;">至</span><input type="text" name="Q_createTimeEnd_DG" value="${param['Q_createTimeEnd_DG']}" class="inputText date" style="width:9%"/>
							--%></div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tinfotemplatparamList" id="tinfotemplatparamItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="infoTemplatParamId" id="infoTemplatParamId" value="${tinfotemplatparamItem.infoTemplatParamId}">
							</display:column>
							<display:column property="templateName" title="模板名称" sortable="false" sortName="templateName" style="text-align:center;width:10%;"/> 
							<display:column property="paramName" title="参数编号" sortable="false" sortName="paramName" style="text-align:center;width:8%;"/> 
							<display:column property="comments" title="参数说明" sortable="false" sortName="comments" style="text-align:center;width:57%;"/> 
							<%--<display:column property="createTime" title="创建时间" format="{0,date,yyyy-MM-dd HH:dd}" sortable="false" sortName="createTime" style="text-align:center;width:10%;"/> 
							--%><display:column title="操作" media="html" style="text-align:center;">
								<a href='edit2.ht?infoTemplatParamId=${tinfotemplatparamItem.infoTemplatParamId}' class="link edit">编辑</a>	
								<a href='del.ht?infoTemplatParamId=${tinfotemplatparamItem.infoTemplatParamId}'  class='link del'>删除</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="tinfotemplatparamItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
