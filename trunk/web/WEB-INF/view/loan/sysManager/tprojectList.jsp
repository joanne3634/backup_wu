<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>借款项目后台管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">借款项目后台管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tproject" css="link search" id="btnSearch" >查询</f:a></div>
							<div class="l-bar-separator"></div>
							 
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht?${queryParam }">
							<div class="row">
 
									<span class="label" style="text-align:right;">会员:</span><input type="text" name="Q_applyName_S" value="${param['Q_applyName_S']}" maxlength="10" class="inputText" />
									<span class="label" style="text-align:right;">项目名称:</span><input type="text" name="Q_pname_S" value="${param['Q_pname_S']}" maxlength="30" class="inputText" />
									<span class="label" style="text-align:right">逾期天数:</span><input type="text" name="Q_plateDays_S" value="${param['Q_plateDays_S']}" maxlength="10" class="inputText"/>
 
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll"> 
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tprojectList" id="tprojectItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:left;">
								  <input type="checkbox" class="pk" name="projectId" id="projectId" value="${tprojectItem.projectId}">
							</display:column>
							<display:column property="applyName" title="会员"  style="text-align:left;width:50px;"/>
							<display:column property="pname" title="项目名称"  style="text-align:left;width:60px;"/> 
							<display:column title="项目状态"   style="text-align:left;width:40px;">
							 	<f:description nodeKey="xmzt"  itemValue="${tprojectItem.pstatusId }"/>
							</display:column> 
 
							<display:column property="ploanReal" title="实际借<br/>款金额" style="text-align:left;width:1px;"/> 
							<display:column property="prateIn" title="借款年<br/>利率(%)"  style="text-align:left;width:1px;"/> 
							<display:column property="psumInterest" title="应还总<br/>利息"   style="text-align:left;width:40px;"/> 
							<display:column property="pdeadline" title="贷款期限" style="text-align:left;width:1px;"/> 
							<display:column property="pbided" title="投标数"  style="text-align:left;width:1px;"/> 
							<display:column title="是否逾期"   style="text-align:left;width:1px;">
								<f:description nodeKey="sf"  itemValue="${tprojectItem.pisLate }"/>
							</display:column> 
							<display:column property="plateDays" title="逾期天数"  style="text-align:left;width:1px;"/> 
 
							<c:if test="${queryParam=='Q_psumLateHavedPay_S=1' }">
 
							<display:column property="psumLate" title="逾期罚金"  style="text-align:left;width:1px;"/> 
							<display:column property="prreplacePay" title="垫付金额" style="text-align:left;width:1px;"/> 
							<display:column property="prreplacePayTime" title="垫付时间" style="text-align:left;width:1px;"/> 
							<display:column title="垫付机构"  style="text-align:left;width:1px;">
								<f:description modelCode="t_risk_company" modelPropertyName="name" modelPropertyValue="companyId"
								modelSqlKey="findById" nodeKey="MODEL_DATA"  itemValue="${tprojectItem.prcompay }"/>
							</display:column> 
							<display:column property="psumLateHavedPay" title="已付罚金<br/>（含垫付）" style="text-align:left;width:1px;"/> 
							<display:column title="跟进人" style="text-align:left;width:1px;">
								<f:description modelCode="sys_user" modelSqlKey="getById" modelPropertyName="fullname" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tprojectItem.pclerk }"/>
							</display:column> 
							<display:column property="prisReplacePay" title="状态" style="text-align:left;width:40px;"/> 
							</c:if>
							<!-- display:column property="pdesc" title="项目描述" sortable="true" sortName="pdesc" style="text-align:left;width:1px;"/>  -->
							<c:if test="${queryParam!='Q_pstatusId_S=7' }">
							<display:column title="操作" style="text-align:left;width:100px;">
								<a href='#' class="link edit">提示</a>	
								<a href='${ctx}/loan/sysManager/tprojectRepayment/list.ht?Q_projectId_S=${tprojectItem.projectId}'  class='link edit'>跟进</a>
							</display:column> 
							</c:if>
						</display:table>
						<deelon:paging tableId="tprojectItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
