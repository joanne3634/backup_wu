<%@page import="com.deelon.loan.model.front.TBankcard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group">
							<f:a alias="search_cmsSiteConfig" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label" style="text-align: right;">持卡人:</span>
									<input type="text" name="realName" maxlength="200" class="inputText" value="${param['realName']}"/>
									<span class="label" style="text-align: right;">卡号:</span>
									<input type="text" name="cardId" maxlength="200" class="inputText" value="${param['cardId']}"/>
									<span class="label" style="text-align: right;">开户银行:</span>
									<%--<input type="text" name="bankName" maxlength="200" class="inputText" value="${param['bankName']}"/>--%>
									<f:select nodeKey="MODEL_DATA" id="bankName" modelCode="t_bank" modelPropertyName="bankName"  modelPropertyValue="bankName" showBlankOnTop="true" defaultValue="${param['bankName']}" />
									</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="bangkCardList" id="bangkCardList" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
<%-- 							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;"> --%>
<%-- 								  <input type="checkbox" class="pk" name="siteConfigId" id="siteConfigId" value="${bangkCardList.bankCardId}"> --%>
<%-- 							</display:column> --%>
							<display:column property="realName" title="持卡人" sortable="false" sortName="realName" style="text-align:center;width:10%;"/> 
							<display:column property="cardId" title="卡号" sortable="false" sortName="cardId" style="text-align:center;width:20%;"/>   
<%-- 							<display:column title="银行"  sortable="false" sortName="bankId" style="text-align:center;width:15%;"> 
								<f:description modelCode="t_bank" modelSqlKey="getById" modelPropertyName="bankName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${bangkCardList.bankId }"/>
							</display:column> --%>
<%--							<display:column property="city" title="开户城市" sortable="true" sortName="city" style="text-align:center;width:15%;"/>  --%> 
							<%-- <display:column title="开户银行" sortable="false" sortName="opening" style="text-align:center;width:15%;">
								<f:description modelCode="t_bank"  modelPropertyName="bankName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${bangkCardList.opening }"/>
							</display:column> --%>
							<display:column property="bankName" title="开户银行" sortable="false" sortName="false" style="text-align:center;width:15%;"/>
							
							<display:column title="添加时间" sortable="false" sortName="createTime" style="text-align:center;width:15%;">
								<fmt:formatDate value="${bangkCardList.createTime}" pattern="yyyy-MM-dd HH:mm"/>
							</display:column> 
							<display:column title="添加人" sortable="false" sortName="userId" style="text-align:center"> 
								<f:description modelCode="t_user" modelSqlKey="getById" modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${bangkCardList.userId }"/>
							</display:column>
						</display:table>
						<deelon:paging tableId="bankCardItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
