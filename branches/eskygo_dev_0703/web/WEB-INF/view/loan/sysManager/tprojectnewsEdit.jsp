<%@page import="com.deelon.crowdfunding.model.backstage.TcprojectNews"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TcprojectNews.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
		<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
<%-- 	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=cmsSiteMenuContent"></script> --%>
	<script type="text/javascript"  src="${ctx }/js/deelon/platform/system/SysDialog.js"></script>
	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
	<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.attach.js" ></script>
<%--  <script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tprojectNews&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse);
		});
	</script>  --%>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tprojectNews&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse<c:if test="${tprojectNews.projectId==null}">,1</c:if>);
		});
		
		function showRequest(formData, jqForm, options) { 	
			return true;
		} 
		var __valid;
		function showResponse(responseText, statusText)  { 
			var self=this;
			var obj=new com.deelon.form.ResultMessage(responseText);
			if(obj.isSuccess()){//成功
				$.ligerDialog.confirm( obj.getMessage()+",是否继续操作","提示信息",function(rtn){
					if(!rtn){
						var returnUrl=$("#returnUrl").val();
						if($("#returnUrl").length>0 && returnUrl!=""){
							location.href=returnUrl;
							return;
						}
						var linkBack=$("a.back");
						if(linkBack.length>0){
							var returnUrl=linkBack.attr("href");
							if(returnUrl!=""){
								location.href=returnUrl;
								return;
							}
						}
					}
					else{
						if(obj.getPkName()&&obj.getPkId()){ 
							$("#"+obj.getPkName()).val(obj.getPkId());
						}
						if(self.isReset==1){
							__valid.resetForm();
						}
					}
				});
				
		    }else{//失败
		    	$.ligerDialog.error( obj.getMessage(),"出错了");
		    }
		} 
		
		
		function valid(showRequest,showResponse,isReset){

			var options={};

			if(showRequest )
				options.beforeSubmit=showRequest;

			if(showResponse )
				options.success=showResponse;

			if(isReset){
				options.isReset=isReset;
			}

			__valid=$("#tprojectNewsForm").validate({
			   
				rules: {
					projectId:{
						required:true
					},
					pntitle:{
						required:true
					},
					pncontent:{
						required:true,
						maxlength:2000
					}
				},
				messages: {
					projectId:{
						required:"必选"
					},
					pntitle:{
						required:"必填"
					},
					pncontent:{
						required:"必填",
						maxlength:"最多 2000 个字符."
					}
				},
				submitHandler:function(form){
					$(form).ajaxSubmit(options);
			    },
			    success: function(label) {
					label.removeClass("error");
				}
				});
			}
		
		
		$(function() {  
			$("a.save").click(function() { 
				$("#tprojectNewsForm").submit(); 
			});
		});
	</script>
	
	
<!-- 		<script type="text/javascript">
		$(function() {	
			 $("#tprojectNewsForm").validate({
				rules: {
					projectId:{
						required:true
					},
					pntitle:{
						required:true
					},
					pncontent:{
						required:true,
						maxlength:2000
					}
				},
				messages: {
					projectId:{
						required:"必选"
					},
					pntitle:{
						required:"必填"
					},
					pncontent:{
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
							//alert("注册成功");
							//location.href = "list.ht";
						}		
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						
					}
				});
				}
		});
		});
		
		

		
	</script> -->
	
	
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tprojectNews.newsId!=null}">
			            <span class="tbar-label">编辑<%=TcprojectNews.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=TcprojectNews.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tprojectNewsForm" method="post" action="save.ht">
		<input type="hidden" name="newsId" value="${tprojectNews.newsId}" />
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="10%">项目名称:</th>	
								<td>							
									<select  id="projectId" name="projectId" class="inputText" style="width: 250px;">
										<option value="">请选择</option>
											<c:forEach items="${tcProjectList }" var="list">
												<option value="${list.projectId }" <c:if test="${tprojectNews.projectId == list.projectId }">selected</c:if>>${list.pname }</option>
											</c:forEach>
									</select>			 
									<!-- <input type="text" id="projectId" name="projectId" value="${tprojectNews.projectId}" class="inputText" /> -->
								</td>
								<th width="10%">项目信息类型:<!-- 1项目动态 2项目信息披露: --></th>	
								<td>
									<c:choose>
										<c:when test="${tprojectNews.pntypeId==1}">
											<span >项目动态</span>
						   				</c:when>
						   				<c:when test="${tprojectNews.pntypeId==2}">
						   					<span >项目信息披露</span>
						   				</c:when>
									</c:choose>								 
									
								</td>
							</tr>

							<tr>
								<th width="10%">标题:</th>	
								<td>										 
									<input type="text" id="pntitle" name="pntitle" value="${tprojectNews.pntitle}" class="inputText" style="width: 250px;"/>
								</td>
								<th width="10%">创建人:</th>	
								<td>
									<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tprojectNews.creator}"/>										 
									
								</td>
							</tr>
							<tr>
							<th width="10%">附件:</th>
							<td colspan="3">
								<input type="text" name="fileId" id="fileId" class="attach" attachType="2" value="${tprojectNews.fileId}" />
							</td>
							</tr>
							<tr>
								<th width="10%">内容:</th>	
								<td colspan="3">				
									<textarea style="width: 950px;height: 140px;" id="pncontent" name="pncontent">${tprojectNews.pncontent}</textarea>						 
									
								</td>
<!-- 								<th width="15%">创建时间:</th>	
								<td>										 
									
								</td> -->
								<input type="hidden" name="createTime" value="<fmt:formatDate value='${tprojectNews.createTime}'  pattern='yyyy-MM-dd HH:mm'/>" class="inputText date" style="width:40%"/>
							</tr>
					</table>
					
				</form>
		</div>
</div>
</body>
</html>