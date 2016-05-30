<%@page import="com.deelon.crowdfunding.model.backstage.TcprojectContract"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TcprojectContract.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
	<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.attach.js" ></script>
	<script type="text/javascript">
		function submit(){
			$.ajax({
				url : "updates.ht",
				type : 'post',
				dataType : 'json',
				success : function(data) {
					$.ligerDialog.alertExt("数据操作成功.","提示信息",function(rtn){
						if(!rtn){
							$("#tcprojectContractForm").submit();
						}
						else{
							$("#tcprojectContractForm").submit();
						}
					});
				}
			});
		}
		$(function() {
			///valid(showRequest,showResponse);
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tcprojectContract.contractId!=null}">
			            <span class="tbar-label">编辑<%=TcprojectContract.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=TcprojectContract.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="javascript:submit()">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tcprojectContractForm" method="post" action="updates.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">合同编号:</th>	
								<td>										 
									<input type="text" id="pcNo" name="pcNo" value="${tcprojectContract.pcNo}" class="inputText" style="width:50%"/>
								</td>
								<th width="25%">合同名称:</th>	
								<td>										 
									<input type="text" id="pcname" name="pcname" value="${tcprojectContract.pcname}" class="inputText" style="width:50%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">公司名称:</th>	
								<td>										 
									<input type="text" id="pccompanyName" name="pccompanyName" value="${tcprojectContract.pccompanyName}" class="inputText" style="width:50%"/>
								</td>
								<th width="25%">签订日期:</th>	
								<td>										 
									<input type="text" name="pcsigningDate" value="<fmt:formatDate value='${tcprojectContract.pcsigningDate}' />" class="inputText date"  style="width:50%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">开始日期:</th>	
								<td>										 
									<input type="text" name="pcstarDate" value="<fmt:formatDate value='${tcprojectContract.pcstarDate}' />" class="inputText date"  style="width:50%"/>
								</td>
								<th width="25%">结束日期:</th>	
								<td>										 
									<input type="text" name="pcendDate" value="<fmt:formatDate value='${tcprojectContract.pcendDate}' />" class="inputText date"  style="width:50%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">签订人姓名:</th>	
								<td>										 
									<input type="text" id="pcsignPeople" name="pcsignPeople" value="${tcprojectContract.pcsignPeople}" class="inputText" style="width:50%" />
								</td>
								<th width="25%">签订地点:</th>	
								<td>										 
									<input type="text" id="pcsignAddress" name="pcsignAddress" value="${tcprojectContract.pcsignAddress}" class="inputText" style="width:50%" />
								</td>
							</tr>
							<tr>
								<th width="25%">合同附件:</th>	
								<td>										 
									<input type="text" name="fileId" id="fileId" class="attach" attachType="2" value="${tcprojectContract.fileId}" style="width:50%" /> 
								</td>
								</tr>
									<tr>
								<th width="25%">备注:</th>	
										
								<td colspan="3">				
									<textarea style="width: 950px;height: 140px;" id="pcremarks" name="pcremarks">${tcprojectContract.pcremarks}</textarea>						 
									
								</td>								 
								<%-- 	<input type="text" id="pcremarks" name="pcremarks" value="${tcprojecpcremarkstContract.pcremarks}" class="inputText" /> --%>
							
							</tr>
							 
					</table>
					<input type="hidden" name="contractId" value="${tcprojectContract.contractId}" />
					<input type="hidden" id="projectId" name="projectId" value="${tcprojectContract.projectId}" class="inputText" />
				</form>
		</div>
</div>
</body>
</html>