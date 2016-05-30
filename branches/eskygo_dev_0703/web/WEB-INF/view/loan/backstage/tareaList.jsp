<%@page import="com.deelon.loan.model.front.Tarea"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>区域管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">区域管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tarea" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tarea" css="link add" href="edit.ht"><span></span>添加</f:a></div>
<!-- 							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tarea" css="link update" action="edit.ht">修改</f:a></div> -->
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tarea" css="link del" action="del.ht"><span></span>删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">地区名称:</span><input type="text" name="Q_areaName_S" value="${param['Q_areaName_S']}" maxlength="30" class="inputText" />
									<span class="label">层级:</span>
									<f:select nodeKey="nodeLevel" id="Q_nodeLevel_S" name="Q_nodeLevel_S" showBlankOnTop="true" defaultValue="${param['Q_nodeLevel_S'] }"></f:select>
									<!--<input type="text" name="Q_nodeLevel_S"  value="${param['Q_nodeLevel_S']}"  maxlength="10" class="inputText" />-->
									<span class="label">邮政编码:</span><input type="text" name="Q_areaZip_S" value="${param['Q_areaZip_S']}" maxlength="6" class="inputText" />
									<span class="label">区号:</span><input type="text" name="Q_areaCode_S"  value="${param['Q_areaCode_S']}" maxlength="4" class="inputText" />
									<span class="label">是否推荐项:</span><f:select nodeKey="sf" id="Q_isRecommended_S" name="Q_isRecommended_S" defaultValue="${param['Q_isRecommended_S']}" showBlankOnTop="true"></f:select>
<!-- 									<span class="label">助记码:</span><input type="text" name="Q_helpCode_S" value="${tarea.helpCode}" maxlength="30" class="inputText" />
									<span class="label">上级ID:</span><input type="text" name="Q_parentId_S" value="${tarea.parentId}" maxlength="19" class="inputText" />
									<span class="label">层级:</span><input type="text" name="Q_nodeLevel_S" value="${tarea.nodeLevel}" maxlength="10" class="inputText" /> 
									<span class="label">排序:</span><input type="text" name="Q_orderCode_S" value="${tarea.orderCode}" maxlength="30" class="inputText" />
									-->
							</div>
							<div class="row">
									

							</div>
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tareaList" id="tareaItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="areaId" id="areaId" value="${tareaItem.areaId}"}>
							</display:column>
							<display:column title="地区名称" sortable="false" sortName="areaName" style="text-align:left"> 
								<a href="list.ht?parentId=${tareaItem.areaId}">${tareaItem.areaName }</a>
							</display:column>
							<display:column property="areaZip" title="邮政编码" sortable="false" sortName="areaZip" style="text-align:left"/> 
							<display:column property="areaCode" title="区号" sortable="false" sortName="areaCode" style="text-align:left"/> 
							<display:column title="推荐项" sortable="false" sortName="isRecommended" style="text-align:left">
								<f:description nodeKey="sf"  itemValue="${tareaItem.isRecommended }"/>
							</display:column> 
							<display:column property="areaNumber" title="地区代码" sortable="false" sortName="areaNumber" style="text-align:left"/>
							<display:column title="管理" media="html" style="width:120px;">
								<a href='edit.ht?areaId=${tareaItem.areaId}' class="link edit">编辑</a>	
								<a href='del.ht?areaId=${tareaItem.areaId}'  class='link del'>删除</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="tareaItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
