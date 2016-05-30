
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<!-- <script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tsmsinformation&formSave=Y"></script> -->
	<script type="text/javascript">
		$(function() {
			//valid(showRequest,showResponse);

			
			 $("#tsmsinformationForm").validate({
				rules: {
					mobileNum:{
						required:true,
						maxlength:20,
						mobile:true
					},
					messasge:{
						required:true,
						maxlength:200
					}
				},
				messages: {

					mobileNum:{
						required:"手机号码 必填",
						maxlength:"手机号码 最多 20 个字符.",
						mobile:"手机号码格式错误"
					},
					messasge:{
						required:"短信内容 必填",
						maxlength:"短信内容 最多 200 个字符."
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
				if($('#tsmsinformationForm').valid()){
				$.ajax({
					url : "save.ht",
					type : 'post',
					data : $("#tsmsinformationForm").serialize(),
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
			        <c:when test="${tsmsinformation.infoId!=null}">
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
		<form id="tsmsinformationForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">类型:</th>	
								<td>								 <!-- <c:if test="${tsmsinformation.infoId != null}">disabled="disabled"</c:if> -->
									<!-- <input type="hidden" id="serviceType" name="serviceType" value="${tsmsinformation.serviceType}" class="inputText" /> -->
									<%--<select id="serviceType" name="serviceType" class="inputText" <c:if test="${tsmsinformation.infoId != null}">disabled="disabled"</c:if>>
										<option value="1" >网站</option>
										<option value="2">系统</option>
										<option value="3">APP</option>
									</select>--%>
									<c:choose>
							<c:when test="${tsmsinformation.serviceType==1}">
							<span>网站</span>
						   	</c:when>
						   	<c:when test="${tsmsinformation.serviceType==2}">
						   	<span>系统</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span>APP</span>
						   	</c:otherwise>
							</c:choose>
									</td>
								
							</tr>
							<tr>
								<th >手机号码:</th>	
								<td>										 
									<input type="text" id="mobileNum" name="mobileNum" value="${tsmsinformation.mobileNum}" class="inputText" <c:if test="${tsmsinformation.infoId != null}">disabled="disabled"</c:if>/>
								</td>
							</tr>
							<tr>
								<th >发送状态:</th>	
								<td>										 
									<!-- <input type="text" id="status" name="status" value="${tsmsinformation.status}" class="inputText" /> -->
									<f:select nodeKey="DXHFZT"  id="status" name="status" defaultValue="${tsmsinformation.status}"   showBlankOnTop="true"></f:select>
								</td>
							</tr>
							<tr><input type="hidden" name="createTime" value="${tsmsinformation.createTime}"/>
<!-- 								<th width="25%">创建人ID:</th>	
								<td>										 
									<input type="text" id="creator" name="creator" value="${tsmsinformation.creator}" class="inputText" />
								</td> -->
								<th  >短信内容:</th>	
								<td >
									<textarea rows="5" cols="5" id="messasge" name="messasge" class="inputText">${tsmsinformation.messasge}</textarea>										 
								</td>
							</tr>
					</table>
					<input type="hidden" name="infoId" value="${tsmsinformation.infoId}" />
				</form>
		</div>
</div>
</body>
</html>