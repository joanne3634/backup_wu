<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript">
// 		function formSubmit(id) {
// 			var input_cart=document.getElementsByTagName("INPUT");
// 			var input_all=0;
// 			for   (var   i=0;   i<input_cart.length;   i++)   { 
// 				if   (input_cart[i].type=="text"   &&   input_cart[i].value=="")   {
// 					var num = i+1;
// 					input_all=input_all+1;
// 					$("#div_"+num).html("<font color='red'>请输入相关信息！！！</font>");
// 				}
// 			}  6
// 			if (input_all!=0)   { 
// // 				location.href="#";
// 			}else{
// 				$.ligerDialog.confirm("更新数据成功,是否继续操作","提示信息",function(rtn){
// 					$("#riskCompanyForm").ajaxSubmit(function(){return false;});
// 					if(!rtn){
// 						location.href="list.ht";
// 					}
// 					else{
// 						if(id == null){
// 							$("input[type=text]").val("");
// 						}else{
// 							location.href="edit.ht?companyId="+id;
// 						}
						
// 					}
// 				});
// 			}
// 		}
	$(function() {
		$("#riskCompanyForm").validate({
			rules: {//开始声明验证规则
				name:{
					required:true,
				},
				contact:{
					required:true
				},
				address:{
					required:true
				},
				code:{
					required:true,
					zipCode:true 
				},
				phone:{
					required:true,
					phone:true
				},
				mobile:{
					required:true,
					mobile:true
				},
				fax:{
					required:true
				},
				email:{
					required:true,
					email:true
				},
				summary:{
					required:true
				},
				rcPaypwd:{
					required:true
				}
			},
			messages: {
				name:{
					required:"公司名称 必填",
				},
				contact:{
					required:"联系人 必填",
				},
				address:{
					required:"公司地址 必填"
				},
				code:{
					required:"邮编 必填",
					zipCode:"邮编格式错误"            
				},
				phone:{
					required:"固定电话 必填",
					phone:"电话格式错误"           
				},
				mobile:{
					required:"手机号码 必填",
					mobile:"电话格式错误"
				},
				fax:{
					required:"传真 必填"
				},
				email:{
					required:"邮箱地址 必填",
					email:"邮箱地址格式错误"
				},
				summary:{
					required:"简介 必填"
				},
				rcPaypwd:{
					required:"垫付密码 必填"
				}
			},
		});
		$("a.save").click(function() { 
			if($('#riskCompanyForm').valid()){
			$.ajax({
				url : "save.ht",
				type : 'post',
				data : $("#riskCompanyForm").serialize(),
				dataType : 'json',
				success : function(data,textStatus) {
					$.ligerDialog.confirm("数据操作成功,是否继续操作","提示信息",function(rtn){
						if(!rtn){
							location.href="list.ht";
						}
						else{ 
							if($("#companyId").val()==""){
								$("input:text").val("");
							}else{
								location.href="edit.ht?fundsId="+id;
							}
						}
					});			
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
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div> 
		<div class="panel-body" style="margin-top: 1px">
		<form id="riskCompanyForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">公司名称:</th>	
								<td>	
									<input type="text"  id="name" name="name" value="${triskCompany.name}" class="inputText" style="width: 200px;"/>
								</td>
								<th width="45%"><div id="div_1" style="text-align: left;"></div></th>
							</tr>
							<tr>
								<th width="25%">联系人:</th>	
								<td>										 
									<input type="text"  id="contact" name="contact" value="${triskCompany.contact}" class="inputText" style="width: 200px;"/>
								</td>
								<th width="45%"><div id="div_2" style="text-align: left;"></div></th>
							</tr>
							<tr>
								<th width="25%">地址:</th>	
								<td>										 
									<input type="text"  id="address" name="address" value="${triskCompany.address}" class="inputText" style="width: 200px;"/>
								</td>
								<th width="45%"><div id="div_3" style="text-align: left;"></div></th>
							</tr>
							<tr>
								<th width="25%">邮政编码:</th>	
								<td>										 
									<input type="text"  id="code" name="code" value="${triskCompany.code}" class="inputText" style="width: 200px;"/>
								</td>
								<th width="45%"><div id="div_4" style="text-align: left;"></div></th>
							</tr>
							<tr>
								<th width="25%">固定电话:</th>	
								<td>										 
									<input type="text"  id="phone" name="phone" value="${triskCompany.phone}" class="inputText" style="width: 200px;"/>
								</td>
								<th width="45%"><div id="div_5" style="text-align: left;"></div></th>
							</tr>
							<tr>
								<th width="25%">移动电话:</th>	
								<td>										 
									<input type="text"  id="mobile" name="mobile" value="${triskCompany.mobile}" class="inputText" style="width: 200px;"/>
								</td>
								<th width="45%"><div id="div_6" style="text-align: left;"></div></th>
							</tr>
							<tr>
								<th width="25%">传真:</th>	
								<td>										 
									<input type="text"  id="fax" name="fax" value="${triskCompany.fax}" class="inputText" style="width: 200px;"/>
								</td>
								<th width="45%"><div id="div_7" style="text-align: left;"></div></th>
							</tr>
							<tr>
								<th width="25%">邮箱:</th>	
								<td>										 
									<input type="text"  id="email" name="email" value="${triskCompany.email}" class="inputText" style="width: 200px;"/>
								</td>
								<th width="45%"><div id="div_8" style="text-align: left;"></div></th>
							</tr>
							<tr>
								<th width="25%">简介:</th>	
								<td>										 
									<input type="text"  id="summary" name="summary" value="${triskCompany.summary}" class="inputText" style="width: 200px;"/>
								</td>
								<th width="45%"><div id="div_9" style="text-align: left;"></div></th>
							</tr>
							<tr>
								<th width="25%">默认风控机构:</th>	
								<td>	
									<f:select nodeKey="sf" name="rcDefault" id="rcDefault" defaultValue="${triskCompany.rcDefault}"></f:select>
								</td>
								<th width="45%"></th>
							</tr>
							<tr>
								<th width="25%">垫付密码:</th>	
								<td>										 
									<input type="text"  id="rcPaypwd" name="rcPaypwd" value="${triskCompany.rcPaypwd}" class="inputText" style="width: 200px;"/>
								</td>
								<th width="45%"><div id="div_10" style="text-align: left;"></div></th>
							</tr>
					</table>
					<input type="hidden" name="companyId" id="companyId" value="${triskCompany.companyId}" />
				</form>
		</div>
</div>
</body>
</html>