<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>系统设置管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">系统设置管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="yhjbSerch" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tsettings" css="link add" href="edit.ht?${queryParam }"><span></span>添加</f:a></div>
						<%-- 	<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tsettings" css="link update" action="edit.ht?${queryParam }"><span></span>修改</f:a></div> --%>
							<%--
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tsettings" css="link del" action="del.ht"><span></span>删除</f:a></div>--%>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht?${queryParam }">
							<div class="row">
									<span class="label">设置项名称:</span><input type="text" name="Q_setDesc_S" value="${param['Q_setDesc_S']}" maxlength="300" class="inputText" />
									<%--<span class="label">设置项代码:</span><input type="text" name="Q_setCode_S" value="${param['Q_setCode_S']}" maxlength="50" class="inputText" />--%>
									<span class="label">设置项值:</span><input type="text" name="Q_setValue_S" value="${param['Q_setValue_S']}" maxlength="100" class="inputText" />
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tsettingsList" id="tsettingsItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:left;">
								  <input type="checkbox" class="pk" name="settingsId" id="settingsId" value="${tsettingsItem.settingsId}"}>
							</display:column>
							<display:column property="setDesc" title="设置项名称"  style="text-align:left;width:50%;"/> 
							<%--<display:column property="setCode" title="设置项代码"  style="text-align:left;width:20%;"/> --%>
							<display:column property="setValue" title="设置项值"  style="text-align:left;width:44%;"/> 
							<%--
							<display:column  title="类型  "   style="text-align:left;width:8%;">
								<f:description itemValue="${tsettingsItem.typeId}" nodeKey="xtszlx" />
							</display:column>--%> 
							<display:column title="操作" media="html" style="text-align:center;width:6%;">
								<a href='edit.ht?settingsId=${tsettingsItem.settingsId}&typeId=${tsettingsItem.typeId }' class="link edit">编辑</a>	
								<%--<a href='del.ht?settingsId=${tsettingsItem.settingsId}'  class='link del'>删除</a>--%></display:column>
						</display:table>
						<deelon:paging tableId="tsettingsItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
