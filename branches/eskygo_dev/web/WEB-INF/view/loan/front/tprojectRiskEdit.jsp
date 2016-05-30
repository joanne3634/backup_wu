<%@page import="com.deelon.core.util.AppUtil"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>管理</title>
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
			        <c:when test="">
			            <span class="tbar-label">编辑</span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加</span>
			        </c:otherwise>
			    </c:choose> 
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div> 
		<div class="panel-body" style="margin-top: 1px">
		<form id="cmsSiteConfigForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
							</tr>
							<tr>
								<th width="25%">贷款项目:</th>	
								<td>
									${tprojectRisk.projectId}	
								</td>
								<th width="25%">风险金比例:</th>	
								<td>	
									${tprojectRisk.prriskRate} 
								</td>
							</tr> 
							<tr> 
								<th width="25%">风险金:</th>	
								<td>	
									 ${tprojectRisk.prrisk} 
								</td>
								<th width="25%">担保机构:</th>	
								<td>			
									 ${tprojectRisk.prcompay}			
								</td>
							</tr>
							<tr>
								<th width="25%">担保审核:</th>	
								<td>	
									<f:description nodeKey="DBSH" itemValue="${tprojectRisk.praudit}"></f:description>                                      									 
								</td>
								<th width="25%">是否担保机构还款:</th>	
								<td>	
									<f:description nodeKey="sf" itemValue="${tprojectRisk.prisReplacePay}"></f:description>		
								</td>
							</tr>
							<tr> 
								<th width="25%">担保机构还款金额:</th>	
								<td>			
									${tprojectRisk.prreplacePay}							 
								</td>
								<th width="25%">垫付时间:</th>	
								<td>	
									<fmt:formatDate value="${tprojectRisk.prreplacePayTime}" pattern="yyyy-MM-dd HH:mm" /> 
								</td>
							</tr>
							<tr>  
							<tr>
								<th width="25%">风控意见:</th>	
								<td colspan="3">	
									<textarea rows="5" cols="80" id="pradvice" name="pradvice"  class="inputText">${tprojectRisk.pradvice}</textarea>	 
								</td>
							</tr>
					</table>
					<input type="hidden" name="riskId" value="${tprojectRisk.riskId}" />
				</form>
		</div>
</div>
</body>
</html>