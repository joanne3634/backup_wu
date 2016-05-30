<%@page import="com.deelon.loan.model.front.TUser"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>创业者管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript">
		$(function() {
			$("a.save").click(function() { 
				$("#TcuserForm").validate({
					rules: {//开始声明验证规则
						email:{
							required:true,
							email:true
						},
						personalAddress:{
							required:true
						}
					},
					messages: {
						email:{
							required:"邮箱地址 必填",
							email:"邮箱地址格式错误"
						},
						personalAddress:{
							required:"个人住址 必填"
						}
					},
				});
				if($('#TcuserForm').valid()){
					$.ajax({
						url : "${ctx}/crowdfunding/TCUser/tcuser/save.ht",
						type : 'post',
						data : $('#TcuserForm').serialize(),
						dataType : 'json',
						success : function(data) {
							$.ligerDialog.confirm("数据操作成功,是否继续操作","提示信息",function(rtn){
								if(!rtn){
									location.href="list.ht?groupId=1";
								}
								else{
									location.href="#";
								}
							});
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
			        <c:when test="${Tcuser.userId!=null}">
			            <span class="tbar-label">编辑创业者</span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加创业者</span>
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
		<form id="TcuserForm" method="post" action="save.html">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">登录名:</th>	
								<td>										 
									${tuser.loginName}
								</td>
							</tr>
							<tr>
								<th width="25%">真实姓名:</th>	
								<td>										 
									${tuser.realName}
								</td>
							</tr>
<!-- 							<tr> -->
<!-- 								<th width="25%">用户组:</th>	 -->
<!-- 								<td>										  -->
<%-- 									<f:description nodeKey="USERS_GROUP"  itemValue="${tuser.groupId}"/> --%>
<!-- 								</td> -->
<!-- 							</tr> -->
							<tr>
								<th width="25%">身份证:</th>	
								<td>										 
									${tuser.idNo}
								</td>
							</tr>
							<tr>
								<th width="25%">邮箱:</th>	
								<td>										 
									${tuser.email}										 
									<input type="hidden" id="email" name="email" value="${tuser.email}" class="inputText" style="width: 250px;"/>
								</td>
							</tr>
							<tr>
								<th width="25%">手机号码:</th>	
								<td>										 
									${tuser.mobile}
								</td>
							</tr>
							<tr>
								<th width="25%">个人住址:</th>	
								<td>										 
									<input type="text" id="personalAddress" name="personalAddress" value="${tuser.personalAddress}" class="inputText"  style="width: 600px;"/>
								</td>
							</tr>
							<tr>
								<th width="25%">个人说明:</th>	
								<td>										 
									<textarea cols="10" rows="5" id="remarks" name="remarks" class="inputText">${tuser.remarks}</textarea>
								</td>
							</tr>
					</table>
					<input type="hidden" name="userId" value="${tuser.userId}" />
				</form>
		</div>
</div>
</body>
</html>