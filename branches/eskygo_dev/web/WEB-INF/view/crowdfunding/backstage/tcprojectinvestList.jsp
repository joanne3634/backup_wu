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
						<form id="searchForm" method="post"
							  <c:if test="${empty paidlist}">action="list.ht"</c:if>
							  <c:if test="${not empty paidlist }">action="paidlist.ht"</c:if>
							  >
							<div class="row">
									<span class="label">项目名称:</span><input type="text" name="Q_pname_S" value="${param['Q_pname_S']}" maxlength="19" class="inputText" />
									<span class="label">询价人:</span><input type="text" name="Q_userName_S" value="${param['Q_userName_S']}" maxlength="19" class="inputText" />
									<span class="label">状态:</span><f:select nodeKey="JG" id="Q_piisCheck_S" defaultValue="${param['Q_piisCheck_S']}" showBlankOnTop="true"></f:select> 
									<%-- <li><span class="label">询价日期:</span><input type="text" style="height:18px;" id="Q_piinvestTime_DL" name="Q_piinvestTime_DL"  class="inputText Wdate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'Q_piinvestTime_DL\');}'})" value="${param['Q_piinvestTime_DL']}"/></li> --%>
									<li><span class="label">询价日期:</span><input type="text" style="height:18px;" id="Q_piinvestTimeS_DL" name="Q_piinvestTimeS_DL"  class="inputText date" onfocus="WdatePicker()" value="${param['Q_piinvestTimeS_DL']}"/>
									<span >至</span>
									<input type="text" style="height:18px;" id="Q_piinvestTimeE_DL" name="Q_piinvestTimeE_DL"  class="inputText date" onfocus="WdatePicker()" value="${param['Q_piinvestTimeE_DL']}"/></li>
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
							<display:column title="询价人" sortName="userId" style="text-align:left">
								<f:description modelCode="t_user"  modelPropertyName="realName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tcprojectInvestItem.userId }"/> 
							</display:column>  
							<display:column property="piaskPriceTimes" title="询价次数" sortName="piaskPriceTimes" style="text-align:left"/> 
							<display:column title="询价估值" sortName="pivaluation" style="text-align:left">
								<fmt:formatNumber value="${tcprojectInvestItem.pivaluation}" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>   
							<display:column title="认投金额" sortName="piinvest" style="text-align:left">
								<fmt:formatNumber value="${tcprojectInvestItem.piinvest}" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>   
							<display:column title="询价日期 " sortName="piinvestTime" style="text-align:left">
								<fmt:formatDate value="${tcprojectInvestItem.piinvestTime}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
							</display:column>
							<display:column title="状态" sortName="piisCheck" style="text-align:left">
								<f:description nodeKey="JG"  itemValue="${tcprojectInvestItem.piisCheck }"/>
							</display:column>   
							<display:column title="审核人" sortName="pichecker" style="text-align:left">
								<f:description modelCode="t_user"  modelPropertyName="realName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tcprojectInvestItem.pichecker }"/> 
							</display:column>  
							<display:column title="审核日期" sortName="picheckTime" style="text-align:left">
								<fmt:formatDate value="${tcprojectInvestItem.picheckTime}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
							</display:column>  
							<%-- <display:column property="pidenyReason" title="拒绝理由" sortName="pidenyReason" style="text-align:left"/> --%> 
							<display:column title="管理" media="html" style="width:50px;">
								<c:if test="${empty paidlist}">
								<a href='get.ht?investId=${tcprojectInvestItem.investId}&list=1' class="link edit">查看</a>
								</c:if>
								<c:if test="${not empty paidlist}">
									<a href='get.ht?investId=${tcprojectInvestItem.investId}&list=2' class="link edit">查看投资信息</a>
									<a href='/crowdfunding/backstage/userinvest/toTMoneyMoveDetail.ht?investId=${tcprojectInvestItem.investId}' class="link edit">查看付款信息</a>
								</c:if>
							</display:column>
						</display:table>
						<deelon:paging tableId="tcprojectInvestItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
