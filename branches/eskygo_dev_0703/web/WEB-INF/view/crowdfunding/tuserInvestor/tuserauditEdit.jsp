<%@page import="com.deelon.loan.model.sysManager.TuserAudit"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TuserAudit.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<!-- <script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tuserAudit&formSave=Y"></script> -->
	<script type="text/javascript">
		//$(function() {
		//	valid(showRequest,showResponse);
		//});
		$(function(){
			 $("#tuserAuditForm").validate({
					rules: {
						personalAddress:{
							required:true
						},
						idNo:{
							required:true,
							idNo:true,
							remote:"${ctx}/loan/sysManager/tuseraudit/validateidNo.ht?id=${userSafe.safeId}"
						},
						realName:{
							required:true
						},
						email:{
							required:true,
							email:true,
							remote:"${ctx}/loan/sysManager/tuseraudit/validateEmail.ht?id=${userSafe.safeId}"
						},
						mobile:{
							required:true,
							mobile:true,
							remote:"${ctx}/loan/sysManager/tuseraudit/validatePhone.ht?id=${userSafe.safeId}"
						},
						contactName:{
							required:true,
						},
						businessLicense: {
							required: true
						},
						isCompany:{
							required:true,
						},
						remarks:{
							required:true,
							maxlength:2000
						}
					},
					messages: {
						personalAddress:{
							required:"必填"
						},
						idNo:{
							required:"必填",
							idNo:"输入正确的身份证",
							remote:"身份证已存在"
						},
						realName:{
							required:"必填"
						},
						email:{
							required:"必填",
							email:"输入正确的邮箱",
							remote:"邮箱已存在"
						},
						mobile:{
							required:"必填",
							mobile:"输入正确的手机号",
							remote:"手机号已存在"
						},
						contactName:{
							required:"必填"
						},
						businessLicense: {
							required: "必填"
						},
						isCompany:{
							required:"必选"
						},
						remarks:{
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
			
		})
		function dataFormSaves(){
			if($('#tuserAuditForm').valid()){
				$.ajax({
					url : "save.ht",
					type : 'post',
					data : $('#tuserAuditForm').serialize(),
					dataType : 'json',
					success : function(data,textStatus) {
						if(data.result == 1){
							//alert("注册成功");
							$.ligerDialog.success( "操作成功","成功");
							//location.href = "list.ht";
							setTimeout('window.location= "list.ht"',1500);
						}		
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						$.ligerDialog.error( "操作失败","成功");
					}
				});
				}
		}
		function tuserAudit(p,userId){
				$.ajax({
					url : "tuserAudit.ht",
					type : 'post',
					data : "status=" + p + "&userId=" + userId, 
					dataType : 'json',
					success : function(data,textStatus) {
						if(data.result == 1){
							//alert("注册成功");
							$.ligerDialog.success( "操作成功","成功");
							setTimeout('window.location= "list.ht"',1500);
						}		
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						$.ligerDialog.error( "操作失败","成功");
					}
				});		
		}
		
	</script>
</head>

<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tuserAudit.userId!=null}">
			            <span class="tbar-label">编辑<%=TuserAudit.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=TuserAudit.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<!-- <div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div> -->
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tuserAuditForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="10%">会员:</th>	
								<td>										 
									${tuserAudit.loginName}
								</td>
								<th width="10%">会员类型:</th>	
								<td>					
									<f:description nodeKey="USERS_GROUP"  itemValue="${tuserAudit.groupId}"/>					 
									
								</td>
							</tr>
							<tr>
								<th width="10%">所在城市:</th>	
								<td>										 
									<h:getArea areaId="${tuserAudit.provincesId }"></h:getArea>
									<h:getArea areaId="${tuserAudit.cityId }"></h:getArea>
								</td>
								<th width="10%">个人地址:</th>	
								<td>
									<input type="text" id="personalAddress" name="personalAddress" value="${tuserAudit.personalAddress}" class="inputText" style="width: 250px;"/>									 
								</td>
							</tr>
							<tr>
							<c:if test="${tuserAudit.isCompany eq 1 }">  <!-- 机构投资 -->
								<th width="10%">联系人:</th>	
								<td>										 
									<input type="text" id="contactName" name="contactName" value="${tuserAudit.contactName }" class="inputText" style="width: 250px;"/>
								</td>
								<th width="10%">营业执照号:</th>	
								<td>										 
									<input type="text" id="businessLicense" name="businessLicense" value="${tuserAudit.businessLicense }" class="inputText" style="width: 250px;"/>
								</td>
							</c:if>
							</tr>
							<tr>
								<c:if test="${tuserAudit.isCompany eq 0 }"><!-- 个人投资 -->
								<th width="10%">身份证号码:</th>	
								<td>										 
									<c:choose>
										<c:when test="${userSafe.bindIdNo == 1 }">${userSafe.idNo }</c:when>
										<c:when test="${userSafe.bindIdNo == 0 }">
											<input type="text" id="idNo" name="idNo" value="${userSafe.idNo }" class="inputText" style="width: 250px;"/>
										</c:when>
									</c:choose>
								</td>
								<th width="10%">真实姓名:</th>	
								<td>
									<input type="text" id="realName" name="realName" value="${tuserAudit.realName }" class="inputText" style="width: 250px;"/>								 
								</td>
								</c:if>
							</tr>
							<tr>
								<th width="10%">邮箱:</th>	
								<td>										 

									<c:choose>
										<c:when test="${userSafe.bindEmail == 1 }">${userSafe.email }</c:when>
										<c:when test="${userSafe.bindEmail == 0 }">
											<input type="text" id="email" name="email" value="${userSafe.email }" class="inputText" style="width: 250px;"/>
										</c:when>
									</c:choose>
								</td>
								<th width="10%">手机:</th>	
								<td>
									<c:choose>
										<c:when test="${userSafe.bindMobile == 1 }">${userSafe.mobile }</c:when>
										<c:when test="${userSafe.bindMobile == 0 }">
											<input type="text" id="mobile" name="mobile" value="${userSafe.mobile }" class="inputText" style="width: 250px;"/>
										</c:when>
									</c:choose>									 
								</td>
							</tr>
							<tr>
								<th width="10%">注册时间:</th>	
								<td>										 
									<fmt:formatDate value="${tuserAudit.registerTime}" pattern="yyyy-MM-dd HH:MM"/>
								</td>
								<th width="10%">是否机构/公司:</th>	
								<td>
									<c:if test="${tuserAudit.isCompany eq 1}">是</c:if>
									<c:if test="${tuserAudit.isCompany eq 0}">否</c:if>
		<!-- 							是<input type="radio" name="isCompany" value="${tuserAudit.isCompany}" checked="checked" onclick="$(this).val('1');"/>									 
									否<input type="radio" name="isCompany" value="${tuserAudit.isCompany }" <c:if test="${tuserAudit.isCompany == 0 }">checked="checked"</c:if> onclick="$(this).val('0');"/> -->
								</td>
							</tr>
							<tr>
							<c:if test="${tuserAudit.isCompany eq 1}">
									<th width="10%">机构说明:</th>	
							</c:if>
							<c:if test="${tuserAudit.isCompany eq 0}">
									<th width="10%">个人说明:</th>	
							</c:if>
								<td colspan="3">
									<textarea style="width: 850px;height: 144px;" id="remarks" name="remarks">${tuserAudit.remarks }</textarea>										 
								</td>
							</tr>



					</table>
					<div style="text-align: center;padding-bottom: 20px;"></div>
					<div style="text-align: center;">
							<c:if test="${tuserAudit.isCheck == 0 }">
								<input class="sub-btn" type="button"
								value="审核通过" onclick="tuserAudit('1','${tuserAudit.userId}')">
								<input class="sub-btn" type="button"
								value="审核不通过" onclick="tuserAudit('2','${tuserAudit.userId}')">
							</c:if>
							<c:if test="${tuserAudit.isCheck != 0 }">
								<input class="sub-btn" type="button"
								value="取消审核" onclick="tuserAudit('0','${tuserAudit.userId}')">
							</c:if>
												
						
													<input id="sub-btn_save" class="sub-btn" type="button"
							value="修改并保存" onclick="dataFormSaves();">
					
					</div>
					
					
					
					<input type="hidden" name="userId" value="${tuserAudit.userId}" />
					<input type="hidden" name="safeId" value="${userSafe.safeId }"/>
				</form>
		</div>
</div>
</body>
</html>