<%@page import="com.deelon.loan.model.sysManager.TUserMobileChange"%>
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
									<span class="label" style="text-align: right;">会员名:</span><input type="text" name="userName" value="${param['userName']}" maxlength="200" class="inputText" />
									<span class="label" style="text-align: right;">旧手机号:</span><input type="text" name="mobileOld" value="${param['mobileOld']}" maxlength="200" class="inputText" />
									<span class="label" style="text-align: right;">新手机号:</span><input type="text" name="mobileNew" value="${param['mobileNew']}" maxlength="200" class="inputText" />
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tUserMobileChangeList" id="tUserMobileChangeList" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
<%-- 							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;"> --%>
<%-- 								  <input type="checkbox" class="pk" name="mobileChangeid" id="mobileChangeid" value="${tUserMobileChangeList.mobileChangeid}"> --%>
<%-- 							</display:column> --%>
							<display:column   title="会员名" sortable="false" sortName="userId" style="text-align:center;width:25%;"> 
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tUserMobileChangeList.userId }"/>
							</display:column>
							<display:column property="mobileOld" title="旧手机号" sortable="false" sortName="mobileOld" style="text-align:center;width:25%;"/>   
							<display:column property="mobileNew" title="新手机号" sortable="false" sortName="mobileNew" style="text-align:center;width:25%;"/> 
							<display:column title="修改时间" sortable="false" sortName="createTime" style="text-align:center;width:25%;">
								<fmt:formatDate value="${tUserMobileChangeList.createTime}" pattern="yyyy-MM-dd HH:MM"/>
							</display:column>   
						</display:table>
						<deelon:paging tableId="tUserMobileChangeItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
