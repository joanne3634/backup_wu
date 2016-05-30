<%@page import="com.deelon.loan.model.sysManager.Tinfotemplat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=Tinfotemplat.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=Tinfotemplat.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tinfotemplat" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tinfotemplat" css="link add" href="edit.ht"><span></span>添加</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tinfotemplat" css="link update" action="edit.ht"><span></span>修改</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tinfotemplat" css="link del" action="del.ht"><span></span>删除</f:a></div>
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
									<span class="label">模板名称:</span><input type="text" name="Q_templateName_S" value="${param['Q_templateName_S']}" maxlength="64" class="inputText" />
									<span class="label">通知类型:</span>
										<f:select  nodeKey="NOTICE_TYPE" id="Q_serviceType_S" defaultValue="${param['Q_serviceType_S']}" showBlankOnTop="true" styleValue="width:50px"  />
									<span class="label">通知方式:</span>
										<f:select  nodeKey="NOTICE_METHOD" id="Q_infoType_S" defaultValue="${param['Q_infoType_S']}" showBlankOnTop="true" styleValue="width:50px"  />
									<%--<span class="label">创建时间:</span><input type="text" name="Q_createTimeBegin_DL" value="${param['Q_createTimeBegin_DL']}" class="inputText date" style="width:9%"/>
									<span class="label" style="text-align:center;width:40px;">至</span><input type="text" name="Q_createTimeEnd_DG" value="${param['Q_createTimeEnd_DG']}" class="inputText date" style="width:9%"/>
							--%></div>					
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tinfotemplatList" id="tinfotemplatItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="infoTemplateId" id="infoTemplateId" value="${tinfotemplatItem.infoTemplateId}">
							</display:column>
							<display:column property="templateName" title="模板名称" sortable="false" sortName="templateName" style="text-align:center;width:10%;"/> 
							<display:column title="通知类型" sortable="false" sortName="serviceType" style="text-align:center;width:6%;">
								<f:description itemValue="${tinfotemplatItem.serviceType}" nodeKey="NOTICE_TYPE" />
							</display:column> 
							<display:column title="通知方式" sortable="false" sortName="infoType" style="text-align:center;width:6%;">
								<f:description itemValue="${tinfotemplatItem.infoType}" nodeKey="NOTICE_METHOD" />
							</display:column> 
							<display:column property="infoFlag" title="通知对象" sortable="false" sortName="infoFlag" style="text-align:center;width:6%;"/> 
							<display:column property="header" title="标题" sortable="false" sortName="header" style="text-align:center;width:15%;"/> 
							<display:column property="messasge" title="消息内容" sortable="false" sortName="messasge" style="text-align:center;width:33%;"/> 
							<%--<display:column property="createTime" format="{0,date,yyyy-MM-dd HH:dd}" title="创建时间" sortable="false" sortName="createTime" style="text-align:center;width:10%;"/> 
							--%><display:column title="操作" media="html" style="text-align:center;">
								<a href='edit.ht?infoTemplateId=${tinfotemplatItem.infoTemplateId}' class="link edit">编辑</a>	
								<a href='del.ht?infoTemplateId=${tinfotemplatItem.infoTemplateId}'  class='link del'>删除</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="tinfotemplatItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
