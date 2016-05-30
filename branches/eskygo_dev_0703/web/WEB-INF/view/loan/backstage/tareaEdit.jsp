<%@page import="com.deelon.loan.model.front.Tarea"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>区域管理编辑添加</title>
	<%@include file="/commons/include/form.jsp" %>
<!-- 	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tarea&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse);
		});
	</script> -->
	
			<script type="text/javascript">
		$(function() {	
			 $("#tareaForm").validate({
				rules: {
					areaName:{
						required:true
					},
					isRecommended:{
						required:true
					},
					parentId:{
						required:true
					},
					nodeLevel:{
						required:true
					},
					orderCode:{
						required:true,
						digits:true
					},
					areaZip:{
						required:true,
						zipCode:true
					},
					areaCode:{
						required:true,
						digits:true,
						maxlength:4
					},
					areaNumber:{
						required:true,
						digits:true,
						maxlength:4
					}
				},
				messages: {
					areaName:{
						required:"必填"
					},
					isRecommended:{
						required:"必选"
					},
					parentId:{
						required:"必选"
					},
					nodeLevel:{
						required:"必选"
					},
					orderCode:{
						required:"必填",
						digits: "必须输入整数"
					},
					areaZip:{
						required:"必填",
						zipCode:"邮政编码格式有误"
					},
					areaCode:{
						required:"必填",
						digits:"必须输入整数",
						maxlength: jQuery.validator.format("请输入{0}位数字的区号")
					},
					areaNumber:{
						required:"必填",
						digits:"必须输入整数",
					}
				},
			//	submitHandler:function(form){
			//		$(form).ajaxSubmit(options);
			//    },
			//    success: function(label) {
			//		label.removeClass("error");
			//	}
				});
			
			$("a.save").click(function() { 
				
				if($('#tareaForm').valid()){
				$.ajax({
					url : "save.ht",
					type : 'post',
					data : $('#tareaForm').serialize(),
					dataType : 'json',
					success : function(data,textStatus) {
						if(data.result == 1){
							$.ligerDialog.success("操作成功");
							setTimeout('location.href="list.ht?parentId=1";',2000);
						}		
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						
					}
				});
				}
		});
		});
		
		

		
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tarea.areaId!=null}">
			            <span class="tbar-label">编辑区域</span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加区域</span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht?parentId=1"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tareaForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">地区名称:</th>	
								<td>										 
									<input type="text" id="areaName" name="areaName" value="${tarea.areaName}" class="inputText" />
								</td>
								<th width="25%">是否推荐项:</th>	
								<td>										 
									<f:select styleValue="inputText" styleClass="inputText" nodeKey="sf" id="isRecommended" name="isRecommended" defaultValue="${tarea.isRecommended}" showBlankOnTop="true"></f:select>
								</td>
							</tr>
							<tr>
								<th width="25%">上级地区名称:</th>	
								<td>	
									<select id="parentId" name="parentId" class="inputText">
										<option value="1">最上级地区</option>
										<c:forEach items="${tareaList }" var="list">
											<option value="${list.areaId }" <c:if test="${list.areaId == tarea.parentId }">selected</c:if>>${list.areaName }</option>
										</c:forEach>
									</select>									 
								</td>
								<th width="25%">地区等级:</th>	
								<td>			
									<select id="nodeLevel" name="nodeLevel" class="inputText">
										<option></option>
										<option <c:if test="${tarea.nodeLevel == 1 }">selected</c:if> value="1">省份</option>
										<option <c:if test="${tarea.nodeLevel == 2 }">selected</c:if> value="2">市</option>
										<option <c:if test="${tarea.nodeLevel == 3 }">selected</c:if> value="2" value="3">区，县</option>
									</select>							 
								</td>
							</tr>
							<tr>
								<th width="25%">排序:</th>	
								<td>										 
									<input type="text" id="orderCode" name="orderCode" value="${tarea.orderCode}" class="inputText" />
								</td>
								<th width="25%">邮政编码:</th>	
								<td>										 
									<input type="text" id="areaZip" name="areaZip" value="${tarea.areaZip}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">区号:</th>	
								<td>										 
									<input type="text" id="areaCode" name="areaCode" value="${tarea.areaCode}" class="inputText" />
								</td>
								<th width="25%">地区代码:</th>	
								<td>										 
									<input type="text" id="areaNumber" name="areaNumber" value="${tarea.areaNumber}" class="inputText" />
								</td>
							</tr>
					</table>
					<input type="hidden" name="areaId" value="${tarea.areaId}" />
				</form>
		</div>
</div>
</body>
</html>