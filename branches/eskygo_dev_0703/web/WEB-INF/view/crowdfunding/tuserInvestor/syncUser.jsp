<%@page import="com.deelon.loan.model.front.TUser"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>同步用户</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript">
		$(function() {
			$("#okBtn").click(function() { 
				$("#userForm").validate({
					rules: {//开始声明验证规则
						loginName:{
							required:true
						},
						loginPwd:{
							required:true
						},
						realName:{
							required:true
						},
						email:{
							required:true,
							email:true
						},
						mobile:{
							required:true,
							mobile:true
						},
						idNumber:{
							required:true,
							idNo:true
						},
						registerTime:{
							required:true
						}
						
					},
					messages: {
						loginName:{
							required:"必填"
						},
						loginPwd:{
								required:"必填"
							},
						realName:{
								required:"必填"
							},
						email:{
								required:"必填"
							},
							email:{
								required:"必填",
								email:"邮箱地址格式错误"
							},
						mobile:{
								required:"必填",
								mobile:"手机格式错误"
							},
						idNumber:{
								required:"必填",
								idNo:"身份证格式错误"
							},
						registerTime:{
							required:"必填"
						}
					}
				});
				if($('#userForm').valid()){
					$.ajax({
						url : "${ctx}/crowdfunding/tcuser/tcuser/syncInsertUser.ht",
						type : 'post',
						data : $('#userForm').serialize(),
						dataType : 'json',
						success : function(data) {
							if(data=="success"){
								$("#result").html("同步数据成功");
							}else{
								$("#result").html(data);
							}
							
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
			            <span class="tbar-label">同步用户</span>
			    
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<%--<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>同步</a></div>
					
				--%>
				
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="userForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="20%">登录名:</th>	
								<td>										 
									<input type="text" id="loginName" name="loginName" />
								</td>
								<th width="20%">登陆密码:</th>	
								<td>
									<input type="text" id="loginPwd" name="loginPwd" />
								</td>
							</tr>
							<tr>
								<th width="20%">真实姓名:</th>	
								<td>										 
									<input type="text" id="realName" name="realName" />
								</td>
								<th width="20%">用户邮箱:</th>	
								<td>										 
									<input type="text" id="email" name="email" />
								</td>
							</tr>
							<tr>
								<th width="20%">用户手机:</th>	
								<td>										 
									<input type="text" id="mobile" name="mobile" />
								</td>
								<th width="20%">身份证号:</th>	
								<td>										 
									<input type="text" id="idNumber" name="idNumber" />
								</td>
							</tr>
							<tr>
								<th width="20%">用户类型:</th>	
								<td>										 
									<select id="groupId" name="groupId">
									<option value="1">项目方</option>
									<option value="2">投资者</option>
									</select>
								</td>
								<th width="20%">注册时间:</th>	
								<td>										 
									<input type="text" id="registerTime" name="registerTime" class="datetime" />
								</td>
							</tr>

							<tr>
								<th width="20%">提交:</th>	
								<td colspan="3">										 
									<input type="button" id="okBtn" name="okBtn" value="确定" />
								</td>
							</tr>
							<tr>
								<th width="20%">处理结果:</th>	
								<td colspan="3">										 
									<div id="result"></div>
								</td>
							</tr>
							
					</table>
				</form>
		</div>
</div>
</body>
</html>