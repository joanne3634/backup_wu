
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tsmsinformation" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tsmsinformation" css="link add" href="edit.ht"><span></span>添加</f:a></div>
<!-- 							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tsmsinformation" css="link update" action="edit.ht"><span></span>修改</f:a></div> -->
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tsmsinformation" css="link del" action="del.ht"><span></span>删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">类型:</span><!-- <input type="text" name="Q_serviceType_S" value="${param['Q_serviceType_S']}" maxlength="10" class="inputText" /> -->
<!-- 									<select  name="Q_serviceType_S" class="inputText" value="${param['Q_serviceType_S']}">
										<option value="" selected>请选择</option>
										<option value="1" <c:if test="${param['Q_serviceType_S'] == '1'}">selected</c:if>>网站</option>
										<option value="2" <c:if test="${param['Q_serviceType_S'] == '2'}">selected</c:if>>系统</option>
										<option value="3" <c:if test="${param['Q_serviceType_S'] == '3'}">selected</c:if>>APP</option>
									</select> -->
									<f:select nodeKey="NOTICE_TYPE" name="Q_serviceType_S" id="Q_serviceType_S" defaultValue="${param['Q_serviceType_S']}" showBlankOnTop="true"></f:select>
									
									<span class="label">手机号码:</span><input type="text" name="Q_mobileNum_S" value="${param['Q_mobileNum_S']}" maxlength="20" class="inputText" />
									<span class="label">发送状态:</span>

									<f:select nodeKey="DXHFZT"  name="Q_status_S" id="Q_status_S" defaultValue="${param['Q_status_S']}" showBlankOnTop="true"></f:select>
									<span class="label">发送时间从:</span><input type="text" id="Q_beginSendDate_S" name="Q_beginSendDate_S"  class="inputText date" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'Q_beginSendDate_S\');}'})" value="${param['Q_beginSendDate_S']}"/>
									<span class="label" style="text-align:center;width:40px;">至:</span><input type="text" id="Q_endSendDate_DG" name="Q_endSendDate_DG"  class="inputText date" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'Q_endSendDate_DG\');}'})"  value="${param['Q_endSendDate_DG']}"/>
							
							</div>
							<div class="row">
				
								</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tsmsinformationList" id="tsmsinformationItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:4%;text-align:center;">
								  <input type="checkbox" class="pk" name="infoId" id="infoId" value="${tsmsinformationItem.infoId}"}>
							</display:column>
							<display:column title="类型" sortable="false" sortName="serviceType" style="text-align:center;width:5%;"> 
							<c:choose>
							<c:when test="${tsmsinformationItem.serviceType==1}">
							<span>网站</span>
						   	</c:when>
						   	<c:when test="${tsmsinformationItem.serviceType==2}">
						   	<span>系统</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span>APP</span>
						   	</c:otherwise>
							</c:choose>
							</display:column>
							<display:column property="mobileNum" title="手机号码" sortable="false" sortName="mobileNum" style="text-align:center;width:8%;"/> 
							<display:column property="messasge" title="短信内容" sortable="false" sortName="messasge" style="text-align:center;width:42%;"/> 
							<%--<display:column title="创建人" sortable="false" sortName="creator" style="text-align:center;width:10%;">
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tsmsinformationItem.creator }"/>
							</display:column> 
							<display:column  title="创建时间" sortable="false" sortName="createTime" style="text-align:center;width:13%;">
								<fmt:formatDate value="${tsmsinformationItem.createTime }" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>
							--%><display:column title="发送状态" sortable="false" sortName="status" style="text-align:center;width:5%;"> 
							<c:choose>
							<c:when test="${tsmsinformationItem.status==0}">
								<span class="green">待发</span>
						   	</c:when>
						   	<c:when test="${tsmsinformationItem.status==1}">
						   		<span >发送中</span>
						   	</c:when>
						   	<c:when test="${tsmsinformationItem.status==2}">
						   		<span >成功</span>
						   	</c:when>
						   	<c:when test="${tsmsinformationItem.status==3}">
						   		<span class="red">失败</span>
						   	</c:when>
							</c:choose>
							</display:column>	
							<display:column  title="发送时间" sortable="false" sortName="sendTime" style="text-align:center;width:10%;">
								<fmt:formatDate value="${tsmsinformationItem.sendTime }" pattern="yyyy-MM-dd hh:mm"/>
							
							</display:column>
							<display:column title="操作" media="html" style="text-align:center;width:5%;">
								<!-- <c:if test="${tsmsinformationItem.status == 3 }">
									<a>重发</a>
								</c:if> -->
								<a href='edit.ht?infoId=${tsmsinformationItem.infoId}' class="link edit">编辑</a>	
								<!-- <a href='del.ht?infoId=${tsmsinformationItem.infoId}'  class='link del'>删除</a> -->														
							</display:column>
						</display:table>
						<deelon:paging tableId="tsmsinformationItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
