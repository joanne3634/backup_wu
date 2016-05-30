<%@page import="com.deelon.loan.model.front.TUserFunds"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<%-- 	<title><%=CmsSiteConfig.TABLE_ALIAS%>管理</title> --%>
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
									<span class="label">会员:
										&nbsp;&nbsp;&nbsp;
										<input type="text" name="userName" maxlength="200" class="inputText" value="${param['userName']}"/>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										真实姓名:
										&nbsp;&nbsp;&nbsp;
										<input type="text" name="realName" maxlength="200" class="inputText" value="${param['realName']}"/>
										
									</span>
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="userFundsList" id="userFundsList" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
<%-- 							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;"> --%>
<%-- 								  <input type="checkbox" class="pk" name="fundsId" id="fundsId" value="${userFundsList.fundsId}"> --%>
<%-- 							</display:column> --%>
							<display:column   title="会员名" sortable="true" sortName="userId" style="text-align:center;width:10%;"> 
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${userFundsList.userId }"/>
							</display:column>
							<display:column property="realName" title="真实姓名" sortable="false" sortName="realName" style="text-align:center;width:15%;"/>
							<display:column property="available" title="投资金额" sortable="false" sortName="available" style="text-align:center;width:15%;"/>   
							<display:column property="available" title="融资金额" sortable="false" sortName="available" style="text-align:center;width:15%;"/> 
							<display:column property="balance" title="账户余额" sortable="false" sortName="balance" style="text-align:center;width:15%;"/>   
							<%-- <display:column property="freeze" title="冻结金额" sortable="false" sortName="freeze" style="text-align:center;width:15%;"/> --%> 
							<display:column property="available" title="可用金额" sortable="false" sortName="available" style="text-align:center;width:15%;"/> 
							<display:column title="操作" media="html" style="text-align:center">
							
								<a href='statement.ht?payMark=${userFundsList.payMark}&fundsId=${userFundsList.fundsId}'  class="link edit">查看资金流动记录</a>	
							</display:column>
						</display:table>
						<deelon:paging tableId="userFundsItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
