<%@page import="com.deelon.crowdfunding.model.backstage.TcprojectInvest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=TcprojectInvest.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
   <style type="text/css">
     .row select {
    width: 70px !important;
    }
	</style>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=TcprojectInvest.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tcprojectInvest" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
						</div>	
						
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="${ctx}/crowdfunding/backstage/tcprojectinvest/toPayInvestMoneyList.ht?groupId=2">
							<div class="row">
									<span class="label">项目名称:</span><input type="text" name="Q_pname_S" value="${param['Q_pname_S']}" maxlength="19" class="inputText" />
									<span class="label">询价人:</span><input type="text" name="Q_userName_S" value="${param['Q_userName_S']}" maxlength="19" class="inputText" />
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tcprojectInvestList" id="tcprojectInvestItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="investId" id="investId" value="${tcprojectInvestItem.investId}">
							</display:column>
							<display:column title="项目名称" sortName="projectId" style="text-align:left">
								<f:description modelCode="t_c_project"  modelPropertyName="pname" modelPropertyValue="projectId" nodeKey="MODEL_DATA"  itemValue="${tcprojectInvestItem.projectId }"/> 
							</display:column>   
							<display:column title="投资人" sortName="userId" style="text-align:left">
								<f:description modelCode="t_user"  modelPropertyName="realName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tcprojectInvestItem.userId }"/>
							</display:column>
							<display:column title="认投金额" sortName="piinvest" style="text-align:left">
								<fmt:formatNumber value="${tcprojectInvestItem.piinvest}" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>
							<display:column title="付款状态" sortName="piisPay" style="text-align:left">
								<f:description nodeKey="sf"  itemValue="${tcprojectInvestItem.piisPay }"/>
							</display:column>
							<display:column title="审核状态" sortName="piisCheck" style="text-align:left">
								<f:description nodeKey="JG"  itemValue="${tcprojectInvestItem.piisCheck }"/>
							</display:column>   
							<%--<display:column title="审核人" sortName="pichecker" style="text-align:left">--%>
								<%--<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tcprojectInvestItem.pichecker }"/>--%>
							<%--</display:column>  --%>
							<display:column title="审核日期" sortName="picheckTime" style="text-align:left">
								<fmt:formatDate value="${tcprojectInvestItem.picheckTime}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
							</display:column>  
							<display:column title="操作" media="html" style="width:30px;">
								<a href='/crowdfunding/backstage/userinvest/investorMoneyAdd.ht?investId=${tcprojectInvestItem.investId}' class="link edit">线下支付</a>
							</display:column>
						</display:table>
						<deelon:paging tableId="tcprojectInvestItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
