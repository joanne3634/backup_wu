<%@page import="com.deelon.cmsform.model.site.CmsSiteConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=CmsSiteConfig.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=CmsSiteConfig.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group">							
							<f:a alias="search_cmsSiteConfig" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_cmsSiteConfig" css="link add" href="edit.ht"><span></span>添加</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_cmsSiteConfig" css="link update" action="edit.ht"><span></span>修改</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_cmsSiteConfig" css="link del" action="del.ht"><span></span>删除</f:a></div> 
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">垫付时间从:</span>
									<input type="text" id="beginDate" name="Q_beginDate_S" value="${param['Q_beginDate_S']}" class="inputText date" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\');}'})" />
									<span class="label">至:</span>
									<input type="text" id="endDate" name="Q_endDate_DG" value="${param['Q_endDate_DG']}" class="inputText date" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\');}'})" />
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="list" id="item" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="riskId" id="riskId" value="${item.riskId}"}>
							</display:column>
							<display:column property="prrisk" title="风险金"  style="text-align:center; width:8%" sortable="felse" sortName="prrisk" /> 
							<display:column title="担保机构"   sortable="felse"  sortName="prcompay" style="text-align:center; width:10%"> 
								<f:description modelCode="t_risk_company" modelPropertyName="name" modelPropertyValue="companyId"
								modelSqlKey="findById"
								 nodeKey="MODEL_DATA"  itemValue="${item.prcompay }"/>
							</display:column>  
							<%-- <display:column property="praudit" title="担保审核" style="text-align:center; width:14%" sortable="felse"  sortName="praudit"/>   --%>
							<display:column  title="担保审核"  sortName="praudit" style="text-align:center;width:10%;">
								<f:description itemValue="${item.praudit}" nodeKey="DBSH" />
							</display:column>   
							<display:column property="prreplacePay" title="担保机构<br/>还款金额"  style="text-align:center; width:8%" sortable="felse"  sortName="prreplacePay"/>  
							
							<display:column property="prreplacePayTime" format="{0,date,yyyy-MM-dd  hh:mm}" title="垫付时间"  style="text-align:center; width:10%" sortable="felse" sortName="prreplacePayTime"/>
							
							<display:column property="pradvice" title="风控意见" style="text-align:center; width:40%" sortable="felse"  sortName="pradvice"/>  
							<%-- <display:column title="公司分类"  style="text-align:left">
								<f:entityComBo valueFieldVal="${cmsSiteConfigItem.siteOrgId}" entityFiledId="orgId" entityFiledName="orgName" entityCode="sys_org" />
							</display:column>  --%>
							<display:column title="操作" media="html" style="text-align:center;width:12%;">
								<a href='edit.ht?riskId=${item.riskId}' class="link edit">编辑</a>	
								<a href='del.ht?riskId=${item.riskId}'  class='link del'>删除</a>													
							</display:column>
						</display:table>
						<deelon:paging tableId="item"/>
					</div>
				</div>			
	</div>
</body>
</html>
