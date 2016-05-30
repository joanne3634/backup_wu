<%@page import="com.deelon.crowdfunding.model.backstage.TcprojectAfter"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>投后项目事件管理</title>
	<%@include file="/commons/include/form.jsp" %>
		<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
<%-- 	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=cmsSiteMenuContent"></script> --%>
	<script type="text/javascript"  src="${ctx }/js/deelon/platform/system/SysDialog.js"></script>
	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
	<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.attach.js" ></script>
<!--  <script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tprojectNews&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse);
		});
	</script>  -->
	
	
		<script type="text/javascript">
		$(function() {	
			 $("#tprojectNewsForm").validate({
				rules: {
					paTitle:{
						required:true
					},
					paContent:{
						required:true,
						maxlength:2000
					}
				},
				messages: {
					paTitle:{
						required:"必填"
					},
					paContent:{
						required:"必填",
						maxlength:"最多 2000 个字符."
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
				
				if($('#tprojectNewsForm').valid()){
				$.ajax({
					url : "save.ht",
					type : 'post',
					data : $('#tprojectNewsForm').serialize(),
					dataType : 'json',
					success : function(data,textStatus) {
						if(data.result == 1){
							$.ligerDialog.success('保存成功','提示信息',function(rtn){
								if(rtn){
									location.href = "list.ht";	
								}
								
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
			        <c:when test="${tcprojectAfter.afterId!=null}">
			            <span class="tbar-label">编辑<%=TcprojectAfter.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=TcprojectAfter.TABLE_ALIAS%></span>
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
		<form id="tprojectNewsForm" method="post" action="save.ht">
		<input type="hidden" name="afterId" value="${tcprojectAfter.afterId}" />
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="10%">项目名称:</th>	
								<td>							
									<f:description modelCode="t_c_project"  modelPropertyName="pname" modelPropertyValue="projectId" nodeKey="MODEL_DATA"  itemValue="${tcprojectAfter.projectId }"/>
								</td>
								<th width="10%">项目信息类型:<!-- 1项目动态 2项目信息披露: --></th>	
								<td>
									<c:choose>
										<c:when test="${tcprojectAfter.paTypeId==1}">
											<span >年度报表</span>
						   				</c:when>
						   				<c:when test="${tcprojectAfter.paTypeId==2}">
						   					<span >季度报表</span>
						   				</c:when>
						   				<c:otherwise>
						   				<span >重大事件披露</span>
						   				</c:otherwise>
									</c:choose>								 
									
								</td>
							</tr>

							<tr>
								<th width="10%">标题:</th>	
								<td>										 
									<input type="text" id="paTitle" name="paTitle" value="${tcprojectAfter.paTitle}" class="inputText" style="width: 250px;"/>
								</td>
								<th width="10%">创建人:</th>	
								<td>
									<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tcprojectAfter.creator}"/>										 
									
								</td>
							</tr>
							<tr>
							<th width="10%">附件:</th>
							<td colspan="3">
								<input type="text" name="fileId" id="fileId" class="attach" attachType="2" value="${tcprojectAfter.fileId}" />
							</td>
							</tr>
							<tr>
								<th width="10%">内容:</th>	
								<td colspan="3">				
									<textarea style="width: 950px;height: 140px;" id="paContent" name="paContent">${tcprojectAfter.paContent}</textarea>						 
									
								</td>
<!-- 								<th width="15%">创建时间:</th>	
								<td>										 
									
								</td> -->
								<input type="hidden" name="createTime" value="<fmt:formatDate value='${tcprojectAfter.createTime}'  pattern='yyyy-MM-dd HH:mm'/>" class="inputText date" style="width:40%"/>
							</tr>
					</table>
					
				</form>
		</div>
</div>
</body>
</html>