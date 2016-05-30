<%@page import="com.deelon.loan.model.sysManager.Tbank"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=Tbank.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=Tbank.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tbank" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tbank" css="link add" href="add.ht"><span></span>添加</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tbank" css="link update" action="edit.ht"><span></span>修改</f:a></div>
							<%--<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tbank" css="link del" action="del.ht"><span></span>删除</f:a></div>--%>
						</div>	
					</div>	
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label"> 银行名称:</span><input type="text" name="Q_bankName_S" value="${param['Q_bankName_S']}" maxlength="100" class="inputText" />
<%-- 									<span class="label">上级名称:</span><input type="text" name="Q_parentName_S" value="${tbank.parentId}" maxlength="10" class="inputText" /> --%>
 									<%-- <span class="label">创建人:</span><input type="text" name="Q_creator_S" value="${param['Q_creator_S']}" maxlength="19" class="inputText" /> --%>
 									<%--<span class="label">创建人:</span><input type="text" name="Q_fullName_S" value="${param['Q_fullName_S']}" maxlength="19" class="inputText" />
									<span class="label">创建时间:</span><input type="text" id="beginDate" name="Q_beginDate_DL" value="${param['Q_beginDate_DL']}" class="inputText date" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\')||\'2020-10-01\'}'})" />
									<span class="label" style="text-align:center;width:40px;">至:</span><input type="text" id="endDate" name="Q_endDate_DG" value="${param['Q_endDate_DG']}" class="inputText date" onclick="WdatePicker({minDate:'#F{$dp.$D(\'endDate\')}',maxDate:'2020-10-01'})"/>
									--%>
							</div>
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tbankList" id="tbankItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="bankId" id="bankId" value="${tbankItem.bankId}"}>
							</display:column>
							<display:column property="bankName" title=" 银行名称" sortable="false" sortName="bankName" style="text-align:center;width:40%;"/>
							
							<display:column property="bankCode" title=" 银行代码" sortable="false" sortName="bankCode" style="text-align:center;width:10%;"/>
							<display:column  title="支持投资机构付款" sortable="false" sortName="isCompanyPay" style="text-align:center;width:10%;">
							<f:description nodeKey="sf" itemValue="${tbankItem.isCompanyPay}"/>
							</display:column>
							 
 							<%-- <display:column property="parentId" title="上级银行" sortable="false" sortName="parentId" style="text-align:center;width:25%;"/>
							<display:column title="上级银行" style="text-align:center" sortProperty="${tbankItem.parentId }" sortable="false" sortName="creator" > 
								<f:description modelCode="t_bank"  modelPropertyName="bankName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tbankItem.parentId  }"/>
							</display:column> 
							--%>
							<%-- <display:column property="bankPic" title=" 银行图片" sortable="false" sortName="bankPic" style="text-align:center"/>  --%>
							<display:column title="创建人" style="text-align:center;width:10%;" sortProperty="${tbankItem.creator }" sortable="false" sortName="creator" > 
							<%-- <f:description modelCode="sys_user"  modelPropertyName="fullname" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tbankItem.creator  }"/> --%>
							<c:choose>
							<c:when test="${tbankItem.creator == 0  }">
								<span></span>
						   	</c:when>
						   	<c:when test="${tbankItem.creator !=0}">
						   	<span><f:description modelCode="sys_user"  modelPropertyName="fullname" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tbankItem.creator  }"/></span>
						   	</c:when>
							</c:choose>
							</display:column>
							<display:column property="createTime" title="创建时间" sortable="false" sortName="createTime" style="text-align:center;width:15%;" format="{0,date,yyyy-MM-dd  hh:mm}"/> 
							<display:column title="操作" media="html" style="text-align:center;">
								<a href='edit.ht?bankId=${tbankItem.bankId}' class="link edit">编辑</a>	
								<a href='del.ht?bankId=${tbankItem.bankId}'  class='link del'>删除</a>
								</display:column>
						</display:table>
						<deelon:paging tableId="tbankItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
