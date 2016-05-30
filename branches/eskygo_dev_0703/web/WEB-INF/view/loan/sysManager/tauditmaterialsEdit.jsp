
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	
	<script type="text/javascript">
		function submitForm(){
			//var creditAdd = $("#creditAdd").val();
			var input_cart=document.getElementsByTagName("INPUT");
			var input_all=0;
			//if(isNaN(creditAdd)){
 			//	$("#div_4").html("<font color='red'>增加信用必须为数字</font>");
 			//	input_all=input_all+1;
 			//}
			for   (var   i=0;   i<input_cart.length;   i++)   { 
				if   (input_cart[i].type=="text"   &&   input_cart[i].value=="")   {
					var num = i+1;
					input_all=input_all+1;
					$("#div_"+num).html("<font color='red'>请输入相关信息！！！</font>");
				}
			}  
			
			
			//var isType=$("#isType").val();
			var isType = $("select[name='isType']").val();
			if (input_all!=0)   { 
// 				location.href="#";
			}else if(isType=="" || isType==null || isType=="undefined"){
				$("#div_5").html("<font color='red'>必选</font>");
				//$.ligerDialog.error('必选');
			}else{
				$.ajax({
	 				url : "save.ht?isType="+isType,
	 				type : 'post',
	 				data : $("#tauditmaterialsForm").serialize(),
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
// 			var name = $("#name").val();
// 			var description = $("#description").val();
// 			var creditAdd = $("#creditAdd").val();
// 			if($("#typeId").val() == ""){
// 				$("#div_4").html("<font color='red'>材料类型不为空</font>");
// 			}else{
// 				$("#div_4").html("");
// 			}
// 			if(name == ""){
// 				$("#div_1").html("<font color='red'>材料名称不为空</font>");
// // 				$.ligerDialog.error('材料名称不为空');
// 				return;
// 			}else{
// 				$("#div_1").html("");
// 			}
// 			if(description == ""){
// 				$("#div_2").html("<font color='red'>材料说明不为空</font>");
// // 				$.ligerDialog.error('材料说明不为空');
// 				return;
// 			}else{
// 				$("#div_2").html("");
// 			}
// 			if(creditAdd == ""){
// 				$("#div_3").html("<font color='red'>增加信用不为空'</font>");
// // 				$.ligerDialog.error('增加信用不为空');
// 				return;
// 			}else if(isNaN(creditAdd)){
// 				$("#div_3").html("<font color='red'>增加信用必须为数字</font>");
// // 				$.ligerDialog.error('增加信用必须为数字');
// 				return;
// 			}else{
// 				$("#div_3").html("");
// 			}
// 			
		}
		
		
		
		
		
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tauditmaterials.materialsId!=null}">
			            <span class="tbar-label">编辑</span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加</span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="javascript:;" onclick="submitForm();">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tauditmaterialsForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<%-- <tr>
								<th width="30%">材料类型:</th>	
								<td>										 
									<input type="text" id="typeId" name="typeId" value="${tauditmaterials.typeId}" class="inputText" style="width: 250px;"/>
								</td>
								<th width="40%" style="text-align: left;"><div id="div_1" style="display: inline;"></div></th>
							</tr> --%>
							<tr>
								<th width="30%">材料名称:</th>	
								<td>										 
									<input type="text" id="name" name="name" value="${tauditmaterials.name}" class="inputText"  style="width: 350px;"/>
								</td>
								<!-- <th width="40%" style="text-align: left;"><div id="div_2" style="display: inline;"></div></th> -->
							</tr>
							<tr>
								<th width="30%">材料说明:</th>	
								<td>										 
									<input type="text" id="description" name="description" value="${tauditmaterials.description}" class="inputText"  style="width: 350px;"/>
								</td>
								<!-- <th width="40%" style="text-align: left;"><div id="div_3" style="display: inline;"></div></th> -->
							</tr>
							<tr>
								<th width="30%">是否必须上传:</th>	
								<td>	
									<f:select nodeKey="sf" id="isMust" showBlankOnTop="true" defaultValue="${tauditmaterials.isMust }"></f:select>	
									<!-- <select id="isMust" name="isMust" class="inputText" style="width: 250px;">
						   					<option value="1">是</option>
						   					<option value="0">否</option>	
									</select> -->								 
									<!-- <input type="text" id="isMust" name="isMust" value="${tauditmaterials.isMust}" class="inputText" /> -->
								</td>
								<!-- <th></th> -->
							</tr>
							<tr>
								<th width="30%">证件类型:</th>	
								<td>	
									<f:select nodeKey="zjlx"  id="isType" name="isType"  showBlankOnTop="true" defaultValue="${tauditmaterials.isType }"></f:select>
									<!-- <select id="isType" name="isType" class="inputText" style="width: 70px;">
									<option value="0"></option>
									<option value="1">项目方</option>
									<option value="2">投资者</option>
									</select> -->
									<div id="div_5" style="display: inline;">
								</td>
							</tr>
							<%--
							<tr>
								<th width="30%">是否需要审核:</th>	
								<td>	
									<f:select nodeKey="sf" id="isAudit" showBlankOnTop="true" defaultValue="${tauditmaterials.isAudit }"></f:select>
									<!-- <select id="isAudit" name="isAudit" class="inputText" style="width: 250px;">
											<option value="1" selected>是</option>
											<option value="0">否</option>
									</select> -->										 
									<!-- <input type="text" id="isAudit" name="isAudit" value="${tauditmaterials.isAudit}" class="inputText" /> -->
								</td>
								<th></th>
							</tr>
							<tr>
								<th width="25%">审校通过后增加信用:</th>	
								<td>										 
									<input type="text" id="creditAdd" name="creditAdd" value="${tauditmaterials.creditAdd}" class="inputText"  style="width: 250px;"/>
								</td>
								<th width="40%" style="text-align: left;"><div id="div_4" style="display: inline;"></div></th>
							</tr>
							<tr>
								<th width="25%">是否要上传:</th>	
								<td>	
									<f:select nodeKey="sf" id="isUpload" showBlankOnTop="true" defaultValue="${tauditmaterials.isUpload }"></f:select>
								<!-- 	<select id="isUpload" name="isUpload" class="inputText" style="width: 250px;">
											<option value="1" selected>是</option>
											<option value="0">否</option>
									</select>	 -->								 
									<!-- <input type="text" id="isUpload" name="isUpload" value="${tauditmaterials.isUpload}" class="inputText" /> -->
								</td>
								<th></th>
							</tr>
					--%></table>
					<input type="hidden" name="isAudit" value="1" />
					<input type="hidden" name="isUpload" value="1" />
					<input type="hidden" name="creditAdd" value="1" />
					<input type="hidden" name="materialsId" value="${tauditmaterials.materialsId}" />
				</form>
		</div>
</div>
</body>
</html>