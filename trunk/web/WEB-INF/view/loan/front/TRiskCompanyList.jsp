<%@page import="com.deelon.loan.model.front.TriskCompany"%>
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
							<div class="group"><f:a alias="add_tsettings" css="link add" href="edit.ht">添加</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label" style="text-align: right;">公司名称:</span>
									<input type="text" name="name" maxlength="200" class="inputText" value="${param['name']}"/>
									<span class="label" style="text-align: right;">公司地址:</span>
									<input type="text" name="address" maxlength="200" class="inputText" value="${param['address']}"/>
									<span class="label" style="text-align: right;">联系人:</span>
									<input type="text" name="contact" maxlength="200" class="inputText" value="${param['contact']}"/>
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="riskCompanyList" id="list" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
<%-- 							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;"> --%>
<%-- 								  <input type="checkbox" class="pk" name="siteConfigId" id="siteConfigId" value="${list.companyId}"> --%>
<%-- 							</display:column> --%>
							<display:column property="name" title="公司名称" sortable="false" sortName="RC_Name" style="text-align:center;width:12%;"/> 
							<display:column property="contact" title="联系人" sortable="false" sortName="RC_Contact" style="text-align:center;width:8%;"/>   
							<display:column property="address" title="地址"  sortable="false" sortName="RC_Address" style="text-align:center;width:23%;"/> 
							<display:column property="code" title="邮政编码" sortable="false" sortName="RC_Code" style="text-align:center;width:8%;"/>   
							<display:column property="phone" title="电话" sortable="false" sortName="RC_Phone" style="text-align:center;width:10%;"/>
							<display:column property="fax" title="传真" sortable="false" sortName="RC_Fax" style="text-align:center;width:10%;"/>
							<display:column property="email" title="邮箱" sortable="false" sortName="RC_Email" style="text-align:center;width:12%;"/> 
							<display:column title="操作" media="html" style="text-align:center;">
								<a href='edit.ht?companyId=${list.companyId}' class="link edit">修改</a>	
								<a href='del.ht?companyId=${list.companyId}' class="link edit">删除</a>	
							</display:column>
						</display:table>
						<deelon:paging tableId="riskCompanyItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
