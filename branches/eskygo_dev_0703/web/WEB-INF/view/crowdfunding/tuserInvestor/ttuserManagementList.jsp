<%@page import="com.deelon.loan.model.front.TUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>投资人管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">投资人管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tuser" css="link search" id="btnSearch" >查询</f:a></div>
<!-- 							<div class="l-bar-separator"></div> -->
<%-- 							<div class="group"><f:a alias="add_tuser" css="link add" href="edit.ht">添加</f:a></div> --%>
<!-- 							<div class="l-bar-separator"></div> -->
<%-- 							<div class="group"><f:a alias="upd_tuser" css="link update" action="edit.ht">修改</f:a></div> --%>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tuser" css="link del" action="del.ht">批量删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">会员名:</span><input type="text" name="Q_loginName_S" value="${param['Q_loginName_S']}" maxlength="20" class="inputText" />
									<span class="label">真实姓名:</span><input type="text" name="Q_realName_S" value="${param['Q_realName_S']}" maxlength="20" class="inputText" />
									<span class="label">手机号码:</span><input type="text" name="Q_mobile_S" value="${param['Q_mobile_S']}" maxlength="20" class="inputText" />
									<span class="label">身份证:</span><input type="text" name="Q_idNo_S" value="${param['Q_idNo_S']}" maxlength="20" class="inputText" />
							</div>
							<div class="row">
									<span class="label">注册时间从:</span><input type="text" id="registerTimeBegin" name="registerTimeBegin"  class="inputText date" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'registerTimeEnd\');}'})" value="${param['registerTimeBegin']}"/>
									<span class="label" style="text-align:center;width:40px;">至</span><input type="text" id="registerTimeEnd" name="registerTimeEnd"  class="inputText date" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'registerTimeBegin\');}'})"  value="${param['registerTimeEnd']}"/>
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tuserList" id="tuserItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="userId" id="userId" value="${tuserItem.userId}"/>
							</display:column>
							<display:column property="loginName" title="会员名" sortable="false" sortName="loginName" style="text-align:center"/> 
							<display:column property="realName" title="真实姓名" sortable="false" sortName="realName" style="text-align:center"/>
							<display:column property="idNo" title="身份证" sortable="false" sortName="id_no" style="text-align:center"/>  
							<display:column title="机构（公司）" sortable="false" sortName="isCompany" style="text-align:center">
								<f:description nodeKey="sf"  itemValue="${tuserItem.isCompany }"/>
							</display:column>
							<display:column property="businessLicense" title="营业执照" sortable="false" sortName="BusinessLicense" style="text-align:center"/>  
							<display:column title="领投人" sortable="false" sortName="isLeader" style="text-align:center">
								<f:description nodeKey="sf"  itemValue="${tuserItem.isLeader }"/>
							</display:column>  
							<display:column title="询价资格" sortable="false" sortName="isCompany" style="text-align:center">
								<f:description nodeKey="sf"  itemValue="${tuserItem.isAskPrice }"/>
							</display:column>
<%-- 							<display:column title="锁定" sortable="false" sortName="isLock" style="text-align:center"> --%>
<%-- 								<f:description nodeKey="sf"  itemValue="${tuserItem.isLock }"/> --%>
<%-- 							</display:column>  --%>
<%-- 							<display:column title="激活" sortable="false" sortName="isActive" style="text-align:center"> --%>
<%-- 								<f:description nodeKey="sf"  itemValue="${tuserItem.isActive }"/> --%>
<%-- 							</display:column>   --%>
							<display:column title="注册时间" sortable="false" sortName="RegisterTime" style="text-align:center">
								<fmt:formatDate value="${tuserItem.registerTime}" pattern="yyyy-MM-dd HH:MM"/>
							</display:column>
							<display:column title="操作" media="html" style="width:120px;">
								<a href='tedit.ht?userId=${tuserItem.userId}' class="link edit">编辑</a>	
								<a href='del.ht?userId=${tuserItem.userId}'  class='link del'>删除</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="tuserItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
