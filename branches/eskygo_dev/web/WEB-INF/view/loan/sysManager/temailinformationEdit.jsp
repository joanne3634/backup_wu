
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<!-- <script type="text/javascript" src="${ctx}/servlet/ValidJs?form=temailinformation&formSave=Y"></script> -->
	<script type="text/javascript">
	$(function() {
		//valid(showRequest,showResponse);

		
		 $("#temailinformationForm").validate({
			rules: {
				emailAddr:{
					required:true,
					//maxlength:20,
					email:true
				},
				messasge:{
					required:true,
					maxlength:200
				},
				header:{
					required:true
				}
			},
			messages: {

				emailAddr:{
					required:"邮箱地址 必填",
					//maxlength:"邮箱地址 最多 20 个字符.",
					email:"邮箱地址格式错误"
				},
				messasge:{
					required:"短信内容 必填",
					maxlength:"短信内容 最多 200 个字符."
				},
				header:{
					required:"消息标题 必填"
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
			if($('#temailinformationForm').valid()){
			$.ajax({
				url : "save.ht",
				type : 'post',
				data : $("#temailinformationForm").serialize(),
				dataType : 'json',
				success : function(data,textStatus) {
					if(data.result == 1){
						$.ligerDialog.success("操作成功","提示信息",function(){
							window.location.href="list.ht";
						});
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
			        <c:when test="${temailinformation.infoId!=null}">
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
		<form id="temailinformationForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">发送类型:</th>	
								<td>
									<c:choose>
							<c:when test="${temailinformation.serviceType==1}">
							<span>网站</span>
						   	</c:when>
						   	<c:when test="${temailinformation.serviceType==2}">
						   	<span>系统</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span>APP</span>
						   	</c:otherwise>
							</c:choose>							 
									<!-- <input type="text" id="serviceType" name="serviceType" value="${temailinformation.serviceType}" class="inputText" /> -->
								</td>
								
								
							</tr>
							<tr>
								<th >邮件地址:</th>	
								<td>										 
									<input type="text" id="emailAddr" name="emailAddr" value="${temailinformation.emailAddr}" class="inputText" style="width: 200px;" <c:if test="${temailinformation.infoId != null}">disabled="disabled"</c:if>/>
								</td>
								
							</tr>
							<tr>
								<th >邮件标题:</th>	
								<td>										 
									<input type="text" id="header" name="header" value="${temailinformation.header}" class="inputText" style="width: 200px;"/>
								</td>
								
							</tr>
							<tr>
								<th >邮件内容:</th>	
								<td>										 
									<textarea rows="5" cols="5" id="messasge" name="messasge" class="inputText">${temailinformation.messasge}</textarea>										 
								</td>
								
							</tr>
							<tr>
								<th >发送状态:</th>	
								<td>										 
									<!-- <input type="text" id="status" name="status" value="${temailinformation.status}" class="inputText" /> -->

									<f:select nodeKey="DXHFZT"  id="status" name="status" defaultValue="${temailinformation.status}"   showBlankOnTop="true"></f:select>
								</td>

							</tr><input type="hidden" name="createTime" value="${temailinformation.createTime}"/>
		<!-- 					<tr>
								<th width="15%">创建时间:</th>	
								<td>										 
									<input type="text" name="createTime" value="<fmt:formatDate value='${temailinformation.createTime}' />" class="inputText date" style="width: 200px;"/>
								</td>
							</tr> -->
					</table>
					<input type="hidden" name="infoId" value="${temailinformation.infoId}" />
				</form>
		</div>
</div>
</body>
</html>