<%@page import="com.deelon.loan.model.front.TuserCredit"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=TuserCredit.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=TuserCredit.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tuserCredit" css="link search" id="btnSearch" >查询</f:a></div>
							<div class="l-bar-separator"></div>
							<!-- <div class="group"><f:a alias="add_tuserCredit" css="link add" href="edit.ht">添加</f:a></div> -->
<!-- 							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tuserCredit" css="link update" action="edit.ht">修改</f:a></div> -->
<!-- 							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tuserCredit" css="link del" action="del.ht">删除</f:a></div> -->
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<!-- <span class="label">用户ID:</span><input type="text" name="Q_userId_S" value="${tuserCredit.userId}" maxlength="19" class="inputText" /> -->
									<span class="label">类型:</span>
									<f:select nodeKey="xylx" id="Q_typeId_S" showBlankOnTop="true" defaultValue="${param['Q_typeId_S']}"></f:select>
									<!-- <input type="text" name="Q_typeId_S" value="${tuserCredit.typeId}" maxlength="10" class="inputText" /> -->
									<!-- <span class="label">相关主键ID:</span><input type="text" name="Q_keyId_S" value="${tuserCredit.keyId}" maxlength="19" class="inputText" /> -->
									<span class="label">增加信用:</span><input type="text" name="Q_creditAdd_S" value="${param['Q_creditAdd_S']}" maxlength="10" class="inputText" />
									<span class="label">创建时间:</span><input type="text" name="Q_createTimeBegin_DL" value="${param['Q_createTimeBegin_DL']}" class="inputText date"/>
									&nbsp;至&nbsp;<input type="text" name="Q_createTimeEnd_DG" value="${param['Q_createTimeEnd_DG']}" class="inputText date"/>
							
							</div>
							<div class="row">
									<!-- <span class="label">描述:</span><input type="text" name="Q_description_S" value="${tuserCredit.description}" maxlength="150" class="inputText" /> -->	

							</div>
								
						</form>
					</div>
					<div class="panel-data">
				    	
					    <display:table name="tuserCreditList" id="tuserCreditItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							
							<display:column title="会员" sortable="false" sortName="userId" style="text-align:center;width:50px;"> 
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tuserCreditItem.userId }"/>
							</display:column>
							<display:column title="类型"  style="text-align:center; width:5%"  sortable="felse"  sortName="typeId" >
								<f:description nodeKey="xylx" itemValue="${tuserCreditItem.typeId }"></f:description>
							</display:column>
							<display:column property="creditAdd" title="增加信用" sortable="false" sortName="creditAdd" style="text-align:center;width:8%;"/> 
							<display:column property="description" title="描述" sortable="false" sortName="description" style="text-align:center;width:53%;"/> 
							<display:column  title="创建时间" sortable="false" sortName="createTime" style="text-align:center;width:80px;">
								<fmt:formatDate value="${tuserCreditItem.createTime }" pattern="yyyy-MM-dd HH:mm"/>
							</display:column> 
				<!-- 			
								 <a href='edit.ht?creditId=${tuserCreditItem.creditId}' class="link edit">编辑</a>	
								 <a href='del.ht?creditId=${tuserCreditItem.creditId}'  class='link del'>删除</a>														
							 -->
						</display:table>
						<deelon:paging tableId="tuserCreditItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
