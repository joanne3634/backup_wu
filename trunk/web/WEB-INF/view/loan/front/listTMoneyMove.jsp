<%@page import="com.deelon.loan.model.front.TMoneymove"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<%@include file="/commons/include/get.jsp" %>
	
	<script type="text/javascript">
		function update(moneyMoveId,audit) {
			var subval=$("#suburl").val();
			var url=subval+"/site/tmoneymoveSH/audit.ht?moneyMoveId="+moneyMoveId+"&&audit="+audit;
			$.ajax({
				url : url,
				type : 'post',
				dataType : 'json',
				success : function(data, status) {
					//window.location.href=subval+"/site/tmoneymoveSH/list.ht";
					window.location.href=subval+"/loan/front/tmoneymove/listTo.ht?Q_typeId_S=6";
				},
				error : function(xhr, textStatus, errorThrown) {
					$.ligerDialog.error('审核失败');
				}
			});
		}
	</script>
	
	
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group">							
							<f:a alias="search_cmsSiteConfig" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="listTo.ht">
							<div class="row">
<!-- 									<span class="label" style="text-align: right;">类型:</span>
										<f:select nodeKey="zjld" id="typeId" name="typeId" showBlankOnTop="true" defaultValue="${param['typeId']}" ></f:select> -->
									<span class="label" style="text-align: right;">会员:</span>
										<input type="text" id="Q_userName_S" name="Q_userName_S" maxlength="200" class="inputText" value="${param['Q_userName_S']}"/>
									<%--<span class="label" style="text-align: right;">操作结果:</span>
										<f:select nodeKey="JG" id="resultId" name="resultId" showBlankOnTop="true" defaultValue="${param['resultId']}" ></f:select>
									<span class="label" style="text-align: right;">审核状态:</span>
										<f:select nodeKey="SHZT" id="audit" name="audit" showBlankOnTop="true" defaultValue="${param['audit']}" ></f:select>--%>
									<span class="label">操作时间从:</span><input type="text" id="Q_beginDate_S" name="Q_beginDate_S"  class="inputText date"  value="${param['Q_beginDate_S']}"/>
									<span class="label" style="text-align:center;width:40px;">至:</span><input type="text" id="Q_endDate_DG" name="Q_endDate_DG"  class="inputText date"   value="${param['Q_endDate_DG']}"/>
										</div>
						</form>
					</div>
					<input type="hidden" id="suburl" value="${ctx}">
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="list" id="item" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
<%-- 							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;"> --%>
<%-- 								  <input type="checkbox" class="pk" name="moneyMoveId" id="moneyMoveId" value="${item.moneyMoveId}"}> --%>
<%-- 							</display:column> --%>
							<display:column   title="会员" sortable="false" sortName="userId" style="text-align:center;width:8%;"> 
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${item.userId }"/>
							</display:column>
							<display:column title="类型" sortable="false" sortName="typeId" style="text-align:center;width:8%;">
								<f:description itemValue="${item.typeId}" nodeKey="zjld" />
							</display:column>
<%-- 							<display:column property="typeId" title="通道來源" sortable="false" sortName="available" style="text-align:center;width:8%;"/>  --%>
							<display:column title="金额" sortable="false" sortName="moneyInOut" style="text-align:center;width:10%;"> 
								<fmt:formatNumber value="${item.moneyInOut }" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>
							<display:column title="手续费" sortable="false" sortName="getFee" style="text-align:center;width:8%;">   
								<fmt:formatNumber value="${item.getFee }" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>
							<display:column title="操作时间" sortable="false" sortName="CreateTime" style="text-align:center;width:12%;">
								<fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>
							<display:column title="操作结果" sortable="false" sortName="resultId" style="text-align:center;width:8%;">
								<f:description itemValue="${item.resultId}" nodeKey="JG" />
							</display:column>
							<%-- <display:column  title="审核状态" sortable="false" sortName="Audit" style="text-align:center;width:10%;">
								<f:description itemValue="${item.audit}" nodeKey="SHZT" />
							</display:column> 
							<display:column title="审核人" sortable="false" sortName="checker" style="text-align:center;width:8%;">
								<c:if test="${item.checker eq 0}">
									未审核
								</c:if>
								<c:if test="${item.checker != 0}">
									<f:description modelCode="sys_user"  modelPropertyName="fullname" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${item.checker }"/>
								</c:if>
							</display:column>
							<display:column title="审核时间" sortable="false" sortName="checkTime" style="text-align:center;width:12%;">
								<fmt:formatDate value="${item.checkTime}" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>  --%>
							<%-- <display:column title="操作" media="html" style="text-align:center">
								<c:if test="${item.audit == 1}">
									<a href='javascript:update(${item.moneyMoveId},${item.audit});' class="link edit">审核不通过</a>	
								</c:if>
								<c:if test="${item.audit == 0}">
									<a href='javascript:update(${item.moneyMoveId},${item.audit});' class="link edit">审核通过</a>	
								</c:if>
							</display:column> --%>
						</display:table>
						<deelon:paging tableId="item"/>
					</div>
				</div>			
	</div>
</body>
</html>
