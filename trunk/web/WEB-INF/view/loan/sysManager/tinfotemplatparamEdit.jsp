<%@page import="com.deelon.loan.model.sysManager.Tinfotemplatparam"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=Tinfotemplatparam.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tinfotemplatparam.infoTemplatId!=null}">
			            <span class="tbar-label">编辑<%=Tinfotemplatparam.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=Tinfotemplatparam.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="group"><a class="link close" id="dataFormclose" href="#"><span></span>关闭</a></div>
					<div class="group" style="margin-left:200px;" id="tips"></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tinfotemplatparamForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="15%">参数编号:</th>	
								<td width="35%">										 
									<input type="text" id="paramName" name="paramName" value="${tinfotemplatparam.paramName}" class="inputText" />
								</td>
								<th width="15%">参数说明:</th>	
								<td width="35%">										 
									<input type="text" id="comments" name="comments" value="${tinfotemplatparam.comments}" class="inputText" />
								</td>

							</tr>
					</table>
					<input type="hidden" name="infoTemplatId" value="${tinfotemplatparam.infoTemplatId}" />
				</form>
		</div>
</div>
</body>
<script type="text/javascript">
var __valid;

$(
function(){
	__valid=$("#tinfotemplatparamForm").validate({
		   
		rules: {
			paramName:{
				required:true,
				maxlength:64
			},
			comments:{
				required:true,
				maxlength:256
			}
		},
		messages: {
			paramName:{
				required:"参数名称 必填",
				maxlength:"参数名称 最多 64 个字符."
			},
			comments:{
				required:"参数说明 必填",
				maxlength:"参数说明 最多 256 个字符."
			}
		},
//		submitHandler:function(form){
//			$(form).ajaxSubmit(options);
	//   },
	    success: function(label) {
			label.removeClass("error");
		}
		});
	
	$("a.save").click(function() { 
		var flag = __valid.form(); 
		if(flag){
			var paramName = $("#paramName").val();
			var comments = $("#comments").val();
			var flag = parent.addTemplateParam(paramName,comments);
			if(!flag){
				$.ligerDialog.warn("参数编号重复！");
				return;
			}
			__valid.resetForm();
			var html = "<span style='color:red;'>已保存</span>";
			$("#tips").html(html);
			setTimeout(function(){
				$("#tips").children().hide(1500);
			},2000);
		}
	});
	$("#dataFormclose").click(function(){
		parent.addDialog.close();
	});	
	}
);

</script>
</html>