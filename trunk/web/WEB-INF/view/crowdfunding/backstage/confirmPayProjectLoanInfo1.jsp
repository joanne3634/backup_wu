<%@page import="com.deelon.cmsform.model.site.TcprojectLoanRecords"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=TcprojectLoanRecords.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=TcprojectLoanRecords.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tcprojectLoanRecords" css="link search" id="btnSearch" >查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tcprojectLoanRecords" css="link add" href="edit.ht">添加</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tcprojectLoanRecords" css="link update" action="edit.ht">修改</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tcprojectLoanRecords" css="link del" action="del.ht">删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.html">
							<div class="row">
									<span class="label">放款记录id:</span><input type="text" name="Q_loanRecordId_S" value="${tcprojectLoanRecords.loanRecordId}" maxlength="19" class="inputText" />
									<span class="label">项目id:</span><input type="text" name="Q_projectId_S" value="${tcprojectLoanRecords.projectId}" maxlength="19" class="inputText" />
									<span class="label">本次线下放款金额:</span><input type="text" name="Q_loanAmout_S" value="${tcprojectLoanRecords.loanAmout}" maxlength="11" class="inputText" />
									<span class="label">本次线下放款时间:</span><input type="text" name="Q_beginloanDate_DL" value="<fmt:formatDate value='${tcprojectLoanRecords.beginloanDate}' class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endloanDate_DG" value="<fmt:formatDate value='${tcprojectLoanRecords.endloanDate}' class="inputText date" style="width:9%"/>
							</div>
							<div class="row">
									<span class="label">线下放款人:</span><input type="text" name="Q_loanPerson_S" value="${tcprojectLoanRecords.loanPerson}" maxlength="30" class="inputText" />
									<span class="label">线下放款的交易流水号:</span><input type="text" name="Q_loanFlowCode_S" value="${tcprojectLoanRecords.loanFlowCode}" maxlength="50" class="inputText" />
									<span class="label">本条信息创建人:</span><input type="text" name="Q_creatPerson_S" value="${tcprojectLoanRecords.creatPerson}" maxlength="19" class="inputText" />
									<span class="label">createtime:</span><input type="text" name="Q_begincreatetime_DL" value="<fmt:formatDate value='${tcprojectLoanRecords.begincreatetime}' class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endcreatetime_DG" value="<fmt:formatDate value='${tcprojectLoanRecords.endcreatetime}' class="inputText date" style="width:9%"/>
							</div>
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tcprojectLoanRecordsList" id="tcprojectLoanRecordsItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column property="loanRecordId" title="放款记录id" sortable="true" sortName="loanRecordId" style="text-align:left"/> 
							<display:column property="projectId" title="项目id" sortable="true" sortName="projectId" style="text-align:left"/> 
							<display:column property="loanAmout" title="本次线下放款金额" sortable="true" sortName="loanAmout" style="text-align:left"/> 
							<display:column property="loanDate" title="本次线下放款时间" sortable="true" sortName="loanDate" style="text-align:left"/> 
							<display:column property="loanPerson" title="线下放款人" sortable="true" sortName="loanPerson" style="text-align:left"/> 
							<display:column property="loanFlowCode" title="线下放款的交易流水号" sortable="true" sortName="loanFlowCode" style="text-align:left"/> 
							<display:column property="creatPerson" title="本条信息创建人" sortable="true" sortName="creatPerson" style="text-align:left"/> 
							<display:column property="createtime" title="createtime" sortable="true" sortName="createtime" style="text-align:left"/> 
						</display:table>
						<deelon:paging tableId="tcprojectLoanRecordsItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
