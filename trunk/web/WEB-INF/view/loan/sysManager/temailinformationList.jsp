
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
							<div class="group"><f:a alias="search_temailinformation" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_temailinformation" css="link add" href="edit.ht"><span></span>添加</f:a></div>
<!-- 							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_temailinformation" css="link update" action="edit.ht"><span></span>修改</f:a></div> -->
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_temailinformation" css="link del" action="del.ht"><span></span>删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">类型:</span>
									<f:select nodeKey="NOTICE_TYPE" name="Q_serviceType_S" id="Q_serviceType_S" defaultValue="${param['Q_serviceType_S']}" showBlankOnTop="true"></f:select>
									<span class="label">发送状态:</span>
									<f:select nodeKey="DXHFZT"  name="Q_status_S" id="Q_status_S" defaultValue="${param['Q_status_S']}" showBlankOnTop="true"></f:select>
									<span class="label">邮件地址:</span><input type="text" name="Q_emailAddr_S" value="${param['Q_emailAddr_S']}" maxlength="128" class="inputText" />
									<!-- <span class="label">消息标题:</span><input type="text" name="Q_header_S" value="${param['Q_header_S']}" maxlength="512" class="inputText" /> -->
									<!-- <span class="label">短信内容:</span><input type="text" name="Q_messasge_S" value="${param['Q_messasge_S']}" maxlength="200" class="inputText" /> -->
									<%-- <span class="label">创建时间从:</span><input type="text" id="Q_beginDate_S" name="Q_beginDate_S"  class="inputText date" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'Q_beginDate_S\');}'})" value="${param['Q_beginDate_S']}"/>
									<span class="label" style="text-align:center;width:40px;">至:</span><input type="text" id="Q_endDate_DG" name="Q_endDate_DG"  class="inputText date" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'Q_endDate_DG\');}'})"  value="${param['Q_endDate_DG']}"/> --%>
							
							</div>
							<div class="row">


							</div>
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="temailinformationList" id="temailinformationItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:4%;text-align:center;">
								  <input type="checkbox" class="pk" name="infoId" id="infoId" value="${temailinformationItem.infoId}"}>
							</display:column>
							<display:column title="类型" sortable="false" sortName="serviceType" style="text-align:center;width:8%;">
							<c:choose>
							<c:when test="${temailinformationItem.serviceType==1}">
							<span>网站</span>
						   	</c:when>
						   	<c:when test="${temailinformationItem.serviceType==2}">
						   	<span>系统</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span>APP</span>
						   	</c:otherwise>
							</c:choose>
							</display:column>
							
							 
							<display:column property="emailAddr" title="邮件地址" sortable="false" sortName="emailAddr" style="text-align:center;"/> 
							<display:column property="header" title="标题" sortable="false" sortName="header" style="text-align:center;width:8%;"/> 
							<display:column  title="发送状态" sortable="false" sortName="status" style="text-align:center;width:8%;"> 
							<c:choose>
							<c:when test="${temailinformationItem.status=='0'}">
								<span class="green">待发</span>
						   	</c:when>
						   	<c:when test="${temailinformationItem.status=='1'}">
						   		<span >发送中</span>
						   	</c:when>
						   	<c:when test="${temailinformationItem.status=='2'}">
						   		<span >成功</span>
						   	</c:when>
						   	<c:otherwise>
						   		<span class="red">失败</span>
						   	</c:otherwise>
							</c:choose>
							</display:column>	
						<%-- 	<display:column  title="创建人" sortable="false" sortName="creator" style="text-align:center;width:10%;"> 
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${temailinformationItem.creator }"/>
							</display:column>
							<display:column  title="创建时间" sortable="false" sortName="createTime" style="text-align:center;width:15%;"> 
								<fmt:formatDate value="${temailinformationItem.createTime }" pattern="yyyy-MM-dd HH:mm"/>
							
							</display:column> --%>
							<display:column title="操作" media="html" style="text-align:center;width:8%;">
								<!-- <a>重发</a> -->
								<a href='edit.ht?infoId=${temailinformationItem.infoId}' class="link edit">编辑</a>	
								<!-- <a href='del.ht?infoId=${temailinformationItem.infoId}'  class='link del'>删除</a> -->														
							</display:column>
						</display:table>
						<deelon:paging tableId="temailinformationItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
