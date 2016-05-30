<%@page import="com.deelon.core.util.AppUtil"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tprojectRisk&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse,1);
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
		<form id="tprojectRiskForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
							</tr>
							<tr>
								<th width="25%">贷款项目:</th>	
								<td>	
									<input type="text" style="width: 200px" id="projectId" name="projectId" value="" class="inputText" />
								</td>
								<th width="25%">风险金比例:</th>	
								<td>	
									<input type="text" style="width: 200px" id="prriskRate" name="prriskRate" value="" class="inputText" />
								</td>
							</tr> 
							<tr> 
								<th width="25%">风险金:</th>	
								<td>	
									<input type="text" style="width: 200px" id="prrisk" name="prrisk" value="" class="inputText" />
								</td>
								<th width="25%">担保机构:</th>	
								<td>						
									 <input type="text" style="width:200px" id="prcompay" name="prcompay" value="" class="inputText" />			 
								</td>
							</tr>
							<tr>
								<th width="25%">担保审核:</th>	
								<td>	
									<!-- <input type="text" style="width: 200px" id="praudit" name="praudit" value="" class="inputText" /> -->
									<f:select nodeKey="DBSH"  id="praudit" showBlankOnTop="true" name="praudit"></f:select> 								 
								</td>
								<th width="25%">是否担保机构还款:</th>	
								<td>	
									<f:select nodeKey="sf"  id="prisReplacePay" showBlankOnTop="true" name="prisReplacePay"></f:select> 		
								</td>
							</tr>
							<tr> 
								<th width="25%">担保机构还款金额:</th>	
								<td>			
									<input type="text" style="width: 200px" id="prreplacePay" name="prreplacePay" value="" class="inputText" />							 
								</td>
								<th width="25%">垫付时间:</th>	
								<td>	
									<input type="text" id="prreplacePayTime"  name="prreplacePayTime" value="" style="width: 200px" class="inputText Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" /> 
								</td>
								
							</tr>
							<tr>  
							<tr>
								<th width="25%">风控意见:</th>	
								<td colspan="3">	
									<textarea rows="5" cols="80" id="pradvice" name="pradvice"  class="inputText"></textarea>	 
								</td>
								
							</tr>
							
					</table>
					<input type="hidden" name="riskId" value="${tprojectRisk.riskId}" />
				</form>
		</div>
</div>
</body>
</html>