
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<!-- <script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tuserAuditmat&formSave=Y"></script> -->
	<script type="text/javascript">
	$(function() {
		//valid(showRequest,showResponse);

		
		 $("#tuserAuditmatForm").validate({
			rules: {
				reasons:{
					required:true
				}
			},
			messages: {
				reasons:{
					required:"必填"
				}
			},

			});
	});
	
	
	
	function submitForm(){
		//var reasons = $("#reasons").val();
		//if(reasons == ""){
		//	$.ligerDialog.error('是否理由不为空');
		//	return;
		//}
		if($('#tuserAuditmatForm').valid()){
		$.ajax({
			url : "save.ht",
			type : 'post',
			data : $("#tuserAuditmatForm").serialize(),
			dataType : 'json',
			success : function(data,textStatus) {
				if(data.result == 1){
					location = "list.ht";
				}else{
					$.ligerDialog.error(data.message);
				}			
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.statusText);
			}
		});
		}
	}
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tuserAuditmat.auditMatId!=null}">
			            <span class="tbar-label">编辑</span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加</span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="javascript:;" onclick="submitForm();"><span></span>确定</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tuserAuditmatForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<!-- 		<tr>
								<th width="25%">用户ID:</th>	
								<td>										 
									<input type="text" id="userId" name="userId" value="${tuserAuditmat.userId}" class="inputText" />
								</td>
								<th width="25%">材料ID:</th>	
								<td>										 
									<input type="text" id="materialsId" name="materialsId" value="${tuserAuditmat.materialsId}" class="inputText" />
								</td>
							</tr> -->
							<tr>
								<th width="25%">审核状态:</th>	
								<td>
									<f:select nodeKey="sf" id="isPass" showBlankOnTop="true" defaultValue="${isPass}"></f:select>
									<!-- <select id="isPass" name="isPass" class="inputText" >
										<option value="1">是</option>
										<option value="0">否</option>
									</select>	 -->									 
									<!-- <input type="text" id="isPass" name="isPass" value="${tuserAuditmat.isPass}" class="inputText" /> -->
								</td>
								</tr>
								<tr>
								<th width="25%">备注说明:</th>	
								<td>										 
									<input type="text" id="reasons" name="reasons" value="" class="inputText" style="width: 300px;"/>
								</td>
<!-- 								<th width="25%">审核人:</th>	
								<td>										 
									<input type="text" id="checker" name="checker" value="${tuserAuditmat.checker}" class="inputText" />
								</td> -->
							</tr>
							<tr>
<!-- 								<th width="25%">审核时间:</th>	
								<td>										 
									<input type="text" name="checkTime" value="<fmt:formatDate value='${tuserAuditmat.checkTime}' />" class="inputText date" />
								</td> -->
<!-- 								<th width="25%">末通过理由:</th>	
								<td>										 
									<input type="text" id="reasons" name="reasons" value="${tuserAuditmat.reasons}" class="inputText" />
								</td> -->
							</tr>
<!-- 							<tr>
								<th width="25%">是否重新审核:</th>	
								<td>										 
									<input type="text" id="isRePass" name="isRePass" value="${tuserAuditmat.isRePass}" class="inputText" />
								</td>
							</tr> -->
					</table>
					<c:forEach items="${tuserAuditMatUpload }" var="t">
					<img  src="${ctx }/loan/sysManager/tuserauditmat/getFileById.ht?fileId=${t.uploadId}"/>
					</c:forEach>
					<input type="hidden" name="auditMatId" value="${tuserAuditmat.auditMatId}" />
				</form>
		</div>
</div>
</body>
</html>