<%@page import="com.deelon.loan.model.sysManager.Tbank"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=Tbank.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<%-- <script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tbank&formSave=Y"></script> --%>
	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.attach.js" ></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse,1);
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

		__valid=$("#tbankForm").validate({
		   
			rules: {
				bankId:{
					digits:true
				},
				bankName:{
					required:true,
					maxlength:100
				},
				bankCode:{
					required:true,
					maxlength:100
				},
				parentId:{
					maxlength:10
				},
				bankPic:{
					maxlength:100
				}
			},
			messages: {
				bankId:{
					digits:"银行ID 必须填写整数."
				},
				bankName:{
					required:"银行名称 必填",
					maxlength:"银行名称 最多 100 个字符."
				},
				bankCode:{
					required:"银行代码 必填",
					maxlength:"银行代码 最多 100 个字符."
				},
				parentId:{
					maxlength:"上级ID 最多 10 个字符."
				},
				bankPic:{
					maxlength:"银行图片 最多 100 个字符."
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
				$("#tbankForm").submit(); 
			});
		}); 

	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tbank.bankId!=null}">
			            <span class="tbar-label">编辑<%=Tbank.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=Tbank.TABLE_ALIAS%></span>
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
		<form id="tbankForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%"> 银行名称:</th>	
								<td>										 
									<input type="text" id="bankName" name="bankName" value="${tbank.bankName}" class="inputText" />
								</td>
								<%--<th width="25%">上级银行:</th>	
								<td>										
									 <f:select nodeKey="MODEL_DATA" showBlankOnTop="true" id="Q_userId_S" modelCode="t_user" modelPropertyName="loginName" modelPropertyValue="userId"  /> 
									<f:select nodeKey="MODEL_DATA" showBlankOnTop="true" defaultValue="${tbank.parentId }" id="parentId" name="parentId" modelCode="t_bank" modelPropertyName="bankName" modelPropertyValue="bankId"/> 
									 <input type="text" id="parentId" name="parentId" value="${tbank.parentId}" class="inputText" /> 
								</td>
							--%>
							</tr>
							<tr>
								<th width="25%"> 银行代码:</th>	
								<td>										 
									<input type="text" id="bankCode" name="bankCode" value="${tbank.bankCode}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%"> 银行图片:</th>	
								<td>										 
									<input type="text" id="bankPic" name="bankPic" value="${tbank.bankPic}" class="attach" attachType="2" />
								</td>
							</tr>
					</table>
					<input type="hidden" name="bankId" value="${tbank.bankId}" />
				</form>
		</div>
</div>
</body>
</html>