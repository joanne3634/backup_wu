<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteConfig"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=CmsSiteConfig.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=cmsSiteConfig&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse);
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${cmsSiteConfig.siteConfigId!=null}">
			            <span class="tbar-label">编辑<%=CmsSiteConfig.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=CmsSiteConfig.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" <c:if test="${not empty audit}"> href="listToAutid.ht?Q_inCharge_S=1" </c:if>  <c:if test="${empty audit}"> href="list.ht" </c:if>><span></span>返回</a></div>
				</div>
			</div>
		</div> 
		<div class="panel-body" style="margin-top: 1px">
		<form id="cmsSiteConfigForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
							</tr>
							<tr>
								<th width="25%">会员:</th>	
								<td>	
									<f:description modelCode="t_user"  modelPropertyName="realName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tmoneymove.userId}"/>									 
								</td>
								<th width="25%">类型:</th>	
								<td>										 
									<f:description nodeKey="zjld" itemValue="${tmoneymove.typeId }"></f:description>
								</td>
							</tr> 
							<tr> 
								<th width="25%">金额:</th>	
								<td>											
									<fmt:formatNumber value="${tmoneymove.moneyInOut}" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>								 
								</td>
								<th width="25%">手续费:</th>	
								<td>			
										
									<fmt:formatNumber value="${tmoneymove.getFee}" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>			 
								</td>
							</tr>
							<tr> 
								<th width="25%">操作时间:</th>	
								<td>	
									<fmt:formatDate value="${tmoneymove.createTime}" pattern="yyyy-MM-dd HH:mm" /> 
								</td>
								<th width="25%">结果:</th>	
								<td>	
									<f:description nodeKey="zjldjg" itemValue="${tmoneymove.resultId }"></f:description>									 
								</td>
							</tr>
							<tr>  
							<tr>
								<th width="25%">备注描述:</th>	
								<td colspan="3">	
									<textarea rows="5" cols="80" id="remarkInfo" name="remark"  class="inputText">${tmoneymove.remark}</textarea>	 
								</td>
								
							</tr>
							
					</table>
					<input type="hidden" name="moneyMoveId" value="${tmoneymove.moneyMoveId}" />
				</form>
		</div>
</div>
</body>
</html>