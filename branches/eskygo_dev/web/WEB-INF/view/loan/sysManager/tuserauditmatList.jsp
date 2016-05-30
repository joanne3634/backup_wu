
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tuserAuditmat" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
				<!-- 			<div class="group"><f:a alias="add_tuserAuditmat" css="link add" href="edit.ht"><span></span>添加</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tuserAuditmat" css="link update" action="edit.ht"><span></span>修改</f:a></div>
							<div class="l-bar-separator"></div> -->
							<div class="group"><f:a alias="del_tuserAuditmat" css="link del" action="del.ht"><span></span>删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
<!-- 									<span class="label">用户ID:</span><input type="text" name="Q_userId_S" value="${param['Q_userId_S']}" maxlength="19" class="inputText" />
									<span class="label" style="width: 40px;">材料ID:</span><input type="text" name="Q_materialsId_S" value="${param['Q_materialsId_S']}" maxlength="10" class="inputText" /> -->
									<span class="label" style="width: 60px;">审核人:</span>
									
									<select id="Q_checker_S" name="Q_checker_S">
										<option value=""></option>
										<c:forEach items="${listjuese }" var="sysuser">
											<option value="${sysuser.userId }" <c:if test="${param['Q_checker_S'] == sysuser.userId}">selected</c:if>>${sysuser.fullname }</option>
										</c:forEach>
									</select>
									
									<span class="label">审核状态:</span>
									<f:select nodeKey="SHZT" id="Q_isPass_S" showBlankOnTop="true" defaultValue="${param['Q_isPass_S']}"></f:select>
									
									<%-- <select name="Q_isPass_S" class="inputText">
										<option value="">请选择</option>
										<option value="2" <c:if test="${param['Q_isPass_S'] == '2'}">selected</c:if>>待审核</option>
										<option value="1" <c:if test="${param['Q_isPass_S'] == '1'}">selected</c:if>>通过</option>
										<option value="0" <c:if test="${param['Q_isPass_S'] == '0'}">selected</c:if>>未通过</option>
									</select> --%>
									<span class="label">审核时间:</span><input type="text" name="Q_checkTimeBegin_DL" value="${param['Q_checkTimeBegin_DL']}" class="inputText date"/>
									<span class="label" style="text-align:center;width:40px;">至</span><input type="text" name="Q_checkTimeEnd_DG" value="${param['Q_checkTimeEnd_DG']}" class="inputText date"/>	
									<!-- <span class="label" style="width: 60px;">末通过理由:</span><input type="text" name="Q_reasons_S" value="${param['Q_reasons_S']}" maxlength="100" class="inputText" /> -->
									<!-- <input type="text" name="Q_isPass_S" value="${param['Q_isPass_S']}" maxlength="3" class="inputText" /> -->
<!-- 												<span class="label">是否重新审核:</span>
									<select name="Q_isRePass_S" class="inputText">
										<option value="">请选择</option>
										<option value="1" <c:if test="${param['Q_isRePass_S'] == '1'}">selected</c:if>>是</option>
										<option value="0" <c:if test="${param['Q_isRePass_S'] == '0'}">selected</c:if>>否</option>
									</select> -->
							
							</div>
							<div class="row">
						
									<!-- <input type="text" name="Q_isRePass_S" value="${param['Q_isRePass_S']}" maxlength="3" class="inputText" /> -->
							</div>
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tuserAuditmatList" id="tuserAuditmatItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="auditMatId" id="auditMatId" value="${tuserAuditmatItem.auditMatId}">
							</display:column>
							<display:column title="会员" sortable="false" sortName="userId" style="text-align:center;width:10%;"> 
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tuserAuditmatItem.userId }"/>
							</display:column>
							<display:column  title="材料名称" sortable="false" sortName="materialsId" style="text-align:center;width:18%;"> 
								<f:description modelCode="t_auditmaterials"  modelPropertyName="name" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tuserAuditmatItem.materialsId }"/>
							</display:column>
							<display:column media="html" title="审核状态" style="text-align:center;width:8%;">
							<c:choose>
							<c:when test="${tuserAuditmatItem.isPass==1}">
								<span class="green">审核通过</span>
						   	</c:when>
						   	<c:when test="${tuserAuditmatItem.isPass==0}">
						   	<span class="red">审核未通过</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span class="yellow">待审核</span>
						   	</c:otherwise>
							</c:choose>
							</display:column> 
							
							<display:column  title="审核人" sortable="false" sortName="checker" style="text-align:center;width:7%;">
								<c:if test="${tuserAuditmatItem.checker eq 0 }"><font style="color: red;font-size: 12px;"></font></c:if>
								<c:if test="${tuserAuditmatItem.checker != 0 }">
									<f:description modelCode="sys_user"  modelPropertyName="fullname" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tuserAuditmatItem.checker }"/>
								</c:if>
							</display:column> 
							<display:column  title="审核时间"  sortable="false" sortName="checkTime" style="text-align:center;width:10%;">
								<c:if test="${empty tuserAuditmatItem.checkTime  }">
									<font style="color: red;font-size: 12px;"> </font>
								</c:if>
								<fmt:formatDate value="${tuserAuditmatItem.checkTime }" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>
							<display:column property="reasons"  title="备注说明" sortable="false" sortName="reasons" style="text-align:center;width:35%;"/> 
							
							<display:column title="操作" media="html" style="text-align:center;">
								<a class="link edit" href="getTUploadImages.ht?auditMatId=${tuserAuditmatItem.auditMatId}&userId=${tuserAuditmatItem.userId}" >预览</a>
								<c:if test="${tuserAuditmatItem.isPass!=1&&tuserAuditmatItem.isPass!=0}">
									<a class="link edit" href='edit.ht?auditMatId=${tuserAuditmatItem.auditMatId}&userId=${tuserAuditmatItem.userId}'>审核</a>
								</c:if>
							</display:column>
						</display:table>
						<deelon:paging tableId="tuserAuditmatItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
