<%@page import="com.deelon.crowdfunding.model.backstage.Tcproject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=Tcproject.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=Tcproject.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tcproject" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
<!-- 							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tcproject" css="link add" href="edit.ht"><span></span>添加</f:a></div> -->
<!-- 							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tcproject" css="link update" action="edit.ht"><span></span>修改</f:a></div> -->
<!-- 							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tcproject" css="link del" action="del.ht"><span></span>删除</f:a></div> -->
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">项目名称:</span><input type="text" name="Q_pname_S" value="${param['Q_pname_S']}" maxlength="100" class="inputText" />
									<span class="label">项目状态:</span>
									<f:select nodeKey="xmzt" id="Q_pstateId_S" name="Q_pstateId_S" showBlankOnTop="true" defaultValue="${param['Q_pstateId_S'] }">
									</f:select>
									
									<%--<span class="label">放款时间:</span><input type="text" name="Q_ppayTimeBegin_DL" value="${param['Q_ppayTimeBegin_DL'] }" class="inputText date" style="width:9%"/>
									&nbsp;至&nbsp;<input type="text" name="Q_ppayTimeEnd_DG" value="${param['Q_ppayTimeEnd_DG'] }" class="inputText date" style="width:9%"/>
							--%></div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tcprojectList" id="tcprojectItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<%--<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="projectId" id="projectId" value="${tcprojectItem.projectId}"}>
							</display:column>--%>
							<display:column property="pname" title="项目名称" sortable="false" sortName="pname" style="text-align:left;width:150px;"/> 
							<display:column title="项目状态" sortable="false" sortName="pstateId" style="text-align:left;width:60px;"> 
								<f:description nodeKey="xmzt" itemValue="${tcprojectItem.pstateId }"></f:description>
							</display:column>
							<%--<display:column title="放款时间" sortable="false" sortName="ppayTime" style="text-align:left;width:90px;">
								<fmt:formatDate value="${tcprojectItem.ppayTime }" pattern="yyyy-MM-dd HH:mm"/>
							</display:column> 
							--%><display:column title="申请时间" sortable="false" sortName="createTime" style="text-align:left;width:90px;">
								<fmt:formatDate value="${tcprojectItem.createTime }" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>
							<display:column title="融资金额（万元）" sortable="false" sortName="pfinancingAmount" style="text-align:left;width:60px;">
								<span style="color: red;">
								<fmt:formatNumber value="${tcprojectItem.pfinancingAmount/10000 }" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>
								</span>
							</display:column> 
							<%--<display:column title="放款状态" sortable="false" sortName="pisPay" style="text-align:left;width:60px;"> 
								<c:choose>
									<c:when test="${tcprojectItem.pisPay == 1 }">已放款</c:when>
									<c:when test="${tcprojectItem.pisPay == 0 }">未放款</c:when>
								</c:choose>
							</display:column>
							--%><display:column title="操作" media="html" style="text-align:left;width:40px;">
								<!-- <a href='edit.ht?projectId=${tcprojectItem.projectId}' class="link edit">编辑</a> -->
								<!-- getInvest.ht?projectId=${tcprojectItem.projectId} -->	
								<a href='${ctx }/crowdfunding/backstage/tcprojectinvest/paylist.ht?project=${tcprojectItem.projectId}'  class='link edit'>投资人付款明细</a>												
							</display:column>
						</display:table>
						<deelon:paging tableId="tcprojectItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
