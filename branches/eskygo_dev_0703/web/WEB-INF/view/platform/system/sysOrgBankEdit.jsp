<%--
	time:2013-12-14 14:37:08
	desc:edit the sys_org_bank
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 sys_org_bank</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/deelon/CustomValid.js"></script>    
	<script type="text/javascript">
		$(function() {
			$("a.save").click(function() {
				$("#sysOrgBankForm").attr("action","save.ht");
				submitForm();
			});
		});
		//提交表单
		function submitForm(){
			if($("#bankRegister").val().isEmpty()){
				$.ligerDialog.warn("开户行不能为空!","提示");
			}
			var options={};
			if(showResponse){
				options.success=showResponse;
				if(${sysOrgBank.bankId==null}){
					options.isReset=1;
				}
			}
			var frm=$('#sysOrgBankForm').form();
			frm.ajaxForm(options);
			if(frm.valid()){
				frm.submit();
			}
		}
		
		function showResponse(responseText, statusText)  { 
			var self=this;
			var obj=new com.deelon.form.ResultMessage(responseText);
			if(obj.isSuccess()){//成功
				$.ligerDialog.confirm( obj.getMessage()+",是否继续操作","提示信息",function(rtn){
					if(!rtn){
						window.close();
					}
					else{
						if(self.isReset==1){
							$('#sysOrgBankForm').resetForm();
						}
					}
				});
				
		    }else{//失败
		    	$.ligerDialog.error( obj.getMessage(),"出错了");
		    }
		}  
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
			    <c:when test="${sysOrgBank.bankId !=null}">
			        <span class="tbar-label">编辑sys_org_bank</span>
			    </c:when>
			    <c:otherwise>
			        <span class="tbar-label">添加sys_org_bank</span>
			    </c:otherwise>			   
		    </c:choose>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link back" href="#" onclick="javascript:window.close()"><span></span>关闭</a></div>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<form id="sysOrgBankForm" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
				<tr>
					<th width="20%">开户银行: </th>
					<td>
					<input class="dicCombo" nodeKey="yxfl"  valueFieldID="bankRegister" treeLeafOnly="true" name="bankRegisterName" value="${sysOrgBank.bankRegister}"
					  height="200" width="200"    /> 
					 </td>
				</tr>
				<tr>
					<th width="20%">银行帐号: </th>
					<td><input type="text" id="bankAccount" name="bankAccount" style="width: 230px" value="${sysOrgBank.bankAccount}" validate="{required:true,maxlength:300}" class="inputText"/></td>
				</tr>
				<tr>
					<th width="20%">开户名称: </th>
					<td><input type="text" id="bankName" name="bankName" style="width: 230px" value="${sysOrgBank.bankName}" validate="{required:true,maxlength:300}" class="inputText"/></td>
				</tr> 
				<tr>
					<th width="20%">备注: </th>
					<td><textarea   id="bankRemark" name="bankRemark" rows="5"   class="inputText">${sysOrgBank.bankRemark}</textarea>
					</td>
				</tr>
			</table>
			<input type="hidden" name="bankId" value="${sysOrgBank.bankId}" />	
			<input type="hidden" id="orgid" name="orgid" value="${param['orgId']}"  class="inputText"/>				
		</form>
	</div>
</div>
</body>
</html>
