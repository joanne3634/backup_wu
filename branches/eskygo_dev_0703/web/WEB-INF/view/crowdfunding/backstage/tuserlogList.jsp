<%@page import="com.deelon.loan.model.TuserLog"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=TuserLog.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=TuserLog.TABLE_ALIAS%>管理列表</span>
					</div>
					<%-- <div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tuserLog" css="link search" id="btnSearch" >查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tuserLog" css="link add" href="edit.ht">添加</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tuserLog" css="link update" action="edit.ht">修改</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tuserLog" css="link del" action="del.ht">删除</f:a></div>
						</div>	
					</div>	 --%>
					
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><a class="link search" id="btnSearch"><span></span>查询</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link del"  action="del.ht"><span></span>删除</a></div>
						</div>	
					</div>
							
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">会员:</span>
									<input type="text" name="Q_loginName_S" value="${param['Q_loginName_S']}" maxlength="20" class="inputText" />
 									<!-- <select id="Q_userId_S" name="Q_userId_S">
										<option value=""></option>
										<c:forEach items="${userList }" var="list">
											<option value="${list.userId }" <c:if test="${param['Q_userId_S'] == list.userId }">selected</c:if>>${list.loginName }</option>
										</c:forEach>
									</select>-->
									<!-- <input type="text" name="Q_userId_S" value="${tuserLog.userId}" maxlength="19" class="inputText" /> -->
									<span class="label">类型<!-- ：1登录,2退出,3操作 -->:</span>
									<f:select nodeKey="YHRZLX" id="Q_typeId_S" name="Q_typeId_S" showBlankOnTop="true" defaultValue="${param['Q_typeId_S'] }"></f:select>
									<!-- <input type="text" name="Q_typeId_S" value="${tuserLog.typeId}" maxlength="10" class="inputText" /> -->
<!-- 									<span class="label">模块ID:</span><input type="text" name="Q_modelId_S" value="${tuserLog.modelId}" maxlength="10" class="inputText" />
									<span class="label">模块名称:</span><input type="text" name="Q_modelName_S" value="${tuserLog.modelName}" maxlength="50" class="inputText" /> -->
							</div>
<!-- 							<div class="row">
									<span class="label">操作名称:</span><input type="text" name="Q_actionName_S" value="${tuserLog.actionName}" maxlength="50" class="inputText" />
									<span class="label">发生时间:</span><input type="text" name="Q_beginactionTime_DL" value="<fmt:formatDate value='${tuserLog.beginactionTime}'/>" class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endactionTime_DG" value="<fmt:formatDate value='${tuserLog.endactionTime}'/>" class="inputText date" style="width:9%"/>
									<span class="label">平台1电脑,2手机:</span><input type="text" name="Q_platformId_S" value="${tuserLog.platformId}" maxlength="10" class="inputText" />
									<span class="label"> 客户IP/客户设备ID(手机)访问IP:</span><input type="text" name="Q_clientIpdeviceId_S" value="${tuserLog.clientIpdeviceId}" maxlength="50" class="inputText" />
							</div>
							<div class="row">
									<span class="label">操作状态：1成功 2失败 :</span><input type="text" name="Q_resultId_S" value="${tuserLog.resultId}" maxlength="10" class="inputText" />
									<span class="label">操作描述:</span><input type="text" name="Q_remarks_S" value="${tuserLog.remarks}" maxlength="300" class="inputText" />
							</div> -->
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tuserLogList" id="tuserLogItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="loginLogId" id="loginLogId" value="${tuserLogItem.loginLogId}"}>
							</display:column><!--：1登录,2退出,3操作--><!-- ：1电脑,2手机 -->
							<display:column title="会员" sortable="false" sortName="userId" style="text-align:left;width:80px;">
							<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tuserLogItem.userId}"/>			
							</display:column> 
							<display:column title="日志类型" sortable="false" sortName="typeId" style="text-align:left;width:60px;">
								<f:description nodeKey="YHRZLX"  itemValue="${tuserLogItem.typeId }"/>
							</display:column> 
							<display:column property="modelName" title="模块名称" sortable="false" sortName="modelName" style="text-align:left;width:100px;"/> 
							<display:column property="actionName" title="操作名称" sortable="false" sortName="actionName" style="text-align:left;width:100px;"/> 
							<display:column title="发生时间" sortable="false" sortName="actionTime" style="text-align:left;width:110px;">
								<fmt:formatDate value="${tuserLogItem.actionTime }" pattern="yyyy-MM-dd HH:mm"/>
							</display:column> 
							<display:column title="操作平台" sortable="true" sortName="platformId" style="text-align:left;width:60px;">
								<f:description nodeKey="PTLX"  itemValue="${tuserLogItem.platformId }"/>
							</display:column> 
							<display:column property="clientIpdeviceId" title="访问IP" sortable="false" sortName="clientIpdeviceId" style="text-align:left;width:80px;"/> 
							<display:column title="操作状态" sortable="false" sortName="resultId" style="text-align:left;width:60px;">
								<f:description nodeKey="JG"  itemValue="${tuserLogItem.resultId }"/>
							</display:column> 
							<display:column property="remarks" title="操作描述" sortable="false" sortName="remarks" style="text-align:left;width:130px;"/> 
							<display:column title="操作" media="html" style="width:40px;">
								<a href='get.ht?loginLogId=${tuserLogItem.loginLogId}' class="link edit">明细</a>	
								<!-- <a href='del.ht?loginLogId=${tuserLogItem.loginLogId}'  class='link del'>删除</a>	 -->													
							</display:column>
						</display:table>
						<deelon:paging tableId="tuserLogItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
