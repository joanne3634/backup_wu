<%@page import="com.deelon.loan.model.front.TUser"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>投资人管理</title>
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
							required:"必填",
							email:"邮箱地址格式错误"
						},
						personalAddress:{
							required:"必填"
						}
					}
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
									var sf=$("input[name='iscompany']").val();
									location.href="listToSelect.ht?groupId=2&isCompany="+sf;
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
			            <span class="tbar-label">编辑投资人</span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加投资人</span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="listToSelect.ht?groupId=2&isCompany=${tuser.isCompany}"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="TcuserForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">会员名:</th>	
								<td>										 
									${tuser.loginName}
								</td>
								<th width="25%">邮箱:</th>	
								<td>
									${tuser.email}										 
									<input type="hidden" id="email" name="email" value="${tuser.email}" class="inputText" style="width: 250px;"/>
								</td>
							</tr>
							<c:if test="${tuser.isCompany eq 0}">
							<tr>
								<th width="25%">真实姓名:</th>	
								<td>										 
									${tuser.realName}
								</td>
								<th width="25%">手机号码:</th>	
								<td>										 
									${tuser.mobile}
								</td>
							</tr>
							</c:if>
							<c:if test="${tuser.isCompany == 1}">
							<tr>
								<th width="25%">联系人姓名:</th>	
								<td>										 
									${tuser.contactName}
								</td>
								<th width="25%">手机号码:</th>	
								<td>										 
									${tuser.mobile}
								</td>
							</tr>
							</c:if>
							<tr>
								<%--<th width="25%">机构（公司）:</th>	
								--%>
								<th width="25%">是否机构:</th>	
								<td>										 
									<f:description nodeKey="sf"  itemValue="${tuser.isCompany}"/>
								</td>
								<%--<th width="25%">领投人:</th>	
								--%>
								<th width="25%">是否领投人:</th>	
								<td>										 
										<f:description nodeKey="sf"  itemValue="${tuser.isLeader}"/>
								</td>
							</tr>
							<c:if test="${tuser.isCompany == 1}">
								<tr>
									<th width="25%">营业执照</th>
									<td>										 
										${tuser.businessLicense}
									</td>
									<th width="25%">机构住址:</th>	
									<td>										 
										<input type="text" id="personalAddress" name="personalAddress" value="${tuser.personalAddress}" class="inputText" style="width: 250px;"/>
									</td>
								</tr>
								<tr>
									<th width="25%">机构说明:</th>	
									<td colspan="3">
										<textarea cols="10" rows="5" id="remarks" name="remarks" class="inputText" style="width: 250px;">${tuser.remarks}</textarea>
									</td>
								</tr>

							</c:if>
							<c:if test="${tuser.isCompany == 0}">
								<tr>
									<th width="25%">身份证:</th>
									<td>
										${tuser.idNo}
									</td>

									<th width="25%">个人住址:</th>
									<td>
											 <input type="text" id="personalAddress" name="personalAddress" value="${tuser.personalAddress}" class="inputText" style="width: 300px;"/>
									</td>
								</tr>
								<tr>
									<th width="25%">个人说明:</th>
									<td colspan="3">
										<textarea cols="10" rows="5" id="remarks" name="remarks" class="inputText" style="width: 250px;">${tuser.remarks}</textarea>
									</td>
								</tr>

								</c:if>
								<tr>
									<th width="25%">是否询价资格:</th>
									<td>
										<f:description nodeKey="sf"  itemValue="${tuser.isAskPrice}"/>
									</td>
									<th width="25%">是否激活:</th>	
									<td>
										<f:select nodeKey="sf" id="isActive" name="isActive" defaultValue="${tuser.isActive}" styleValue="inputText" styleClass="inputText"></f:select>
									</td>
								</tr>
								<tr>
									<th width="25%">是否锁定:</th>	
									<td>										 
										<f:select nodeKey="sf" id="isLock" name="isLock" defaultValue="${tuser.isLock}" styleValue="inputText" styleClass="inputText"></f:select>
									</td>
									<th width="25%">是否推荐:</th>	
									<td>
										<f:select nodeKey="sf" id="isRecommended" name="isRecommended" defaultValue="${tuser.isRecommended}" styleValue="inputText" styleClass="inputText"></f:select>
									</td>
								</tr>

							
					</table>
					<input type="hidden" name="userId" value="${tuser.userId}" />
					<input type="hidden" name="iscompany" value="${tuser.isCompany}" />
				</form>
		</div>
</div>
</body>
</html>