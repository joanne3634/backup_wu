<%@page import="com.deelon.crowdfunding.model.backstage.TuserApplyLeader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=TuserApplyLeader.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
	<style>
	.customCss1{
	width: 120px;
	}
	</style>
</head>
<body>		
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title"><span class="tbar-label"><%=TuserApplyLeader.TABLE_ALIAS%>管理列表</span></div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><f:a alias="search_tuserApplyLeader" css="link search" id="btnSearch"><span></span>查询</f:a></div>
					<div class="l-bar-separator"></div>
					<%--<div class="group"><f:a alias="add_cmsSiteConfig" css="link add" href="edit.ht"><span></span>批量审核</f:a></div>
					<div class="l-bar-separator"></div> --%>
					<%--<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tuser" css="link del" action="del.ht"><span></span>删除</f:a></div>
						</div>	--%>
				</div>	
			</div>
		</div>
		<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">申请用户:</span>
									<input type="text" name="Q_loginName_S" value="${param['Q_loginName_S']}" maxlength="20" class="inputText" />
									<span class="label">申请时间从:</span><input type="text" id="applyTimeBegin" name="applyTimeBegin"  class="inputText date" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'applyTimeBegin\');}'})" value="${param['applyTimeBegin']}"/>
									<span class="label" style="text-align:center;width:40px;">至</span><input type="text" id="applyTimeEnd" name="applyTimeEnd"  class="inputText date" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'applyTimeEnd\');}'})"  value="${param['applyTimeEnd']}"/>
									<span class="label">审核状态:</span>
											<select name="isCheck" class="select" value="${isCheck}">
												<option value=""  <c:if test="${isCheck eq '' || empty isCheck}">selected="selected"</c:if>></option>
												<option value="1" <c:if test="${isCheck eq '1' }">selected="selected"</c:if>>已通过</option>
												<option value="2" <c:if test="${isCheck eq '2' }">selected="selected"</c:if>>未通过</option>
												<option value="0" <c:if test="${isCheck eq '0' }">selected="selected"</c:if>>未审核</option>
											</select>
								   <%-- <span class="label">审核状态:</span><f:select nodeKey="JG" id="Q_piisCheck_S" defaultValue="${param['Q_piisCheck_S']}" showBlankOnTop="true"></f:select> --%>
							</div>

						</form>
					</div>
		
		<div class="panel-body">
			<div class="panel-data">
		    	<c:set var="checkAll"><input type="checkbox" id="chkall"/></c:set>
			    <display:table name="tApplyLeaderList" id="tApplyLeaderItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
					<display:column title="${checkAll}" media="html" style="width:3%;text-align:center;">
						  <input type="checkbox" class="pk" name="applyLeaderId" id="applyLeaderId" value="${tApplyLeaderItem.industryDesc}"}>
					</display:column>
					<display:column property="loginName" title="申请用户"   style="text-align:center;width:8%;"/> 
					<display:column  title="申请时间"  sortable="false" sortName="ApplyTime" style="text-align:center;width:10%;">  
					<fmt:formatDate value="${tApplyLeaderItem.applyTime}" pattern="yyyy-MM-dd HH:mm"/>
					</display:column> 
					<display:column property="industryDesc" title="领投项目行业"  style="text-align:center;width:32%;"/> 
					<display:column property="checkerName" title="审核人"   style="text-align:center;width:8%;"/> 
					<display:column  title="审核时间"  sortable="false" sortName="CheckTime" style="text-align:center;width:10%;">  
					<fmt:formatDate value="${tApplyLeaderItem.checkTime}" pattern="yyyy-MM-dd HH:mm"/>
					</display:column> 
					<display:column title="审核状态" sortable="false" sortName="isCheck" style="text-align:center;width:8%" class="customCss1">
						<c:choose>
							<c:when test="${tApplyLeaderItem.isCheck==1}"><span class="green">已通过</span></c:when>
							<c:when test="${tApplyLeaderItem.isCheck==2}"><span class="red">未通过</span></c:when>
							<c:otherwise><span class="blue">未审核</span></c:otherwise>
						</c:choose>
					</display:column>
					<%-- <display:column property="applyInfo" title="个人/机构说明"  style="text-align:center;width:16%;"/>--%>
					<display:column title="操作" media="html" style="text-align:center;width:10%;">
					
					<%-- <c:choose>
						<c:when test="${tApplyLeaderItem.isCheck==0}">
						<a href='edit.ht?applyLeaderId=${tApplyLeaderItem.applyLeaderId}' class="link edit">审核</a>	
						</c:when>	
						<c:when test="${tApplyLeaderItem.isCheck==1}">
						<a href='fail.ht?applyLeaderId=${tApplyLeaderItem.applyLeaderId}' class='link edit'>否决</a>	
						</c:when>
						<c:when test="${tApplyLeaderItem.isCheck==2}">
						<a href='pass.ht?applyLeaderId=${tApplyLeaderItem.applyLeaderId}' class='link edit'>通过</a>	
						</c:when>
					</c:choose>	
					--%>	
					<a href='edit.ht?applyLeaderId=${tApplyLeaderItem.applyLeaderId}' class="link edit">审核</a>
					<a href='del.ht?applyLeaderId=${tApplyLeaderItem.applyLeaderId}'  class='link del'>删除</a>									
					</display:column>
				</display:table>
				<deelon:paging tableId="tApplyLeaderItem"/>
			</div>
		</div>			
	</div>
</body>
</html>
