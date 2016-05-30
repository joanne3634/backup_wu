
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title></title>
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
							<div class="group"><f:a alias="search_tauditmaterials" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tauditmaterials" css="link add" href="edit.ht"><span></span>添加</f:a></div>
							<!--
							<div class="l-bar-separator"></div>
							 <div class="group"><f:a alias="upd_tauditmaterials" css="link update" action="edit.ht">修改</f:a></div> -->
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tauditmaterials" css="link del" action="del.ht"><span></span>删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row"><%--
									<span class="label">材料类型:</span>
									<input type="text" name="Q_typeId_S" value="${param['Q_typeId_S']}" maxlength="10" class="inputText" />
									--%>
									<span class="label">材料名称:</span>
									<input type="text" name="Q_name_S" value="${param['Q_name_S']}" maxlength="100" class="inputText" />
									<span class="label">材料说明:</span>
									<input type="text" name="Q_description_S" value="${param['Q_description_S']}" maxlength="300" class="inputText" />
									<span class="label">是否必须上传:</span>
									<f:select nodeKey="sf" id="Q_isMust_S" showBlankOnTop="true" defaultValue="${param['Q_isMust_S']}" ></f:select>
									
									<span class="label">证件类型:</span>
									<f:select nodeKey="zjlx" id="Q_isType_S" showBlankOnTop="true" defaultValue="${param['Q_isType_S']}" ></f:select>
									<%--<span class="label" style="width: 120px">审校通过后增加信用:
									</span><input type="text" name="Q_creditAdd_S" value="${param['Q_creditAdd_S']}" maxlength="10" class="inputText" />
							--%></div>
							<%--<div class="row">
									<span class="label">是否需要审核:</span>
									<f:select nodeKey="sf" id="Q_isAudit_S" showBlankOnTop="true" defaultValue="${param['Q_isAudit_S']}"></f:select>
									 <select name="Q_isAudit_S" class="select" value="${param['Q_isAudit_S']}">
										<option value="">--选择--</option>
										<option value="1" <c:if test="${param['Q_isAudit_S'] == '1' }">selected</c:if>>是</option>
										<option value="0" <c:if test="${param['Q_isAudit_S'] == '0' }">selected</c:if>>否</option>
									</select> 
 									<input type="text" name="Q_isAudit_S" value="${param['Q_isAudit_S']}" maxlength="3" class="inputText" /> 
									<span class="label">是否要上传:</span>
									<f:select nodeKey="sf" id="Q_isUpload_S" showBlankOnTop="true" defaultValue="${param['Q_isUpload_S']}"></f:select>
									 <select name="Q_isUpload_S" class="select" value="${param['Q_isUpload_S']}">
										<option value="">--选择--</option>
										<option value="1" <c:if test="${param['Q_isUpload_S'] == '1' }">selected</c:if>>是</option>
										<option value="0" <c:if test="${param['Q_isUpload_S'] == '0' }">selected</c:if>>否</option>
									</select> 
 									<input type="text" name="Q_isUpload_S" value="${param['Q_isUpload_S']}" maxlength="3" class="inputText" /> 
									<span class="label">是否必须的:</span>
									<f:select nodeKey="sf" id="Q_isMust_S" showBlankOnTop="true" defaultValue="${param['Q_isMust_S']}"></f:select>
									 <select name="Q_isMust_S" class="select" value="${param['Q_isMust_S']}">
										<option value="" selected>--选择--</option>
										<option value="1" <c:if test="${param['Q_isMust_S'] == '1' }">selected</c:if>>是</option>
										<option value="0" <c:if test="${param['Q_isMust_S'] == '0' }">selected</c:if>>否</option>
									</select> 
 									<input type="text" name="Q_isMust_S" value="${param['Q_isMust_S']}" maxlength="3" class="inputText" /> 
									
							</div>
								
						--%></form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tauditmaterialsList" id="tauditmaterialsItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="materialsId" id="materialsId" value="${tauditmaterialsItem.materialsId}"}>
							</display:column>
							<%-- <display:column property="typeId" title="材料类型" sortable="false" sortName="TypeID" style="text-align:center;width:8%;"/>  --%>
							<display:column property="name" title="材料名称" sortable="false" sortName="Name" style="text-align:center;width:30%;"/> 
							<display:column property="description" title="材料说明" sortable="false" sortName="Description" style="text-align:center;width:35%;"/> 
							<display:column media="html" sortable="false" sortName="Is_Must" title="是否必须上传"  style="text-align:center;width:8%;"> 
							<c:choose>
							<c:when test="${tauditmaterialsItem.isMust==1}">
								<span class="green">是</span>
						   	</c:when>
						   	<c:when test="${tauditmaterialsItem.isMust==0}">
						   	<span class="red">否</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span class="yellow">待审核</span>
						   	</c:otherwise>
							</c:choose>
							
							</display:column>
							
							<display:column media="html" sortable="false" sortName="Is_Type" title="证件类型"  style="text-align:center;width:8%;"> 
							<c:choose>
							<c:when test="${tauditmaterialsItem.isType==1}">
								<span class="green">项目方</span>
						   	</c:when>
						   	<c:when test="${tauditmaterialsItem.isType==2}">
						   	<span class="red">投资者</span>
						   	</c:when>
					       <%-- 	<c:otherwise>
						    	<span class="yellow">其它</span>
						   	</c:otherwise> --%>
							</c:choose>
							
							</display:column>
							
							<%--
							<display:column property="creditAdd" title="审校通过后<br/>增加信用" sortable="false" sortName="CreditAdd" style="text-align:center;width:8%;"/> 
							<display:column media="html" sortable="false" sortName="Is_Upload" title="是否要上传" style="text-align:center;width:8%;"> 
							<c:choose>
							<c:when test="${tauditmaterialsItem.isUpload==1}">
								<span class="green">是</span>
						   	</c:when>
						   	<c:when test="${tauditmaterialsItem.isUpload==0}">
						   	<span class="red">否</span>
						   	</c:when>
					       	<c:otherwise>
					       		<span class="yellow">待审核</span>
						   	</c:otherwise>
						    </c:choose>
							</display:column>
							--%>
							<display:column title="操作" media="html" style="text-align:center;">
								<a href='edit.ht?materialsId=${tauditmaterialsItem.materialsId}' class="link edit">编辑</a>	
								<a href='del.ht?materialsId=${tauditmaterialsItem.materialsId}'  class='link del'>删除</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="tauditmaterialsItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
