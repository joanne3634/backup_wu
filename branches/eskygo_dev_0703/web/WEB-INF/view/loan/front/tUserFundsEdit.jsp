<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript">
		function formSubmit(id) {
			var input_cart=document.getElementsByTagName("INPUT");
			var input_all=0;
			for   (var   i=0;   i<input_cart.length;   i++)   { 
				if   (input_cart[i].type=="text"   &&   input_cart[i].value=="")   {
					var num = i+1;
					input_all=input_all+1;
					$("#div_"+num).html("<font color='red'>请输入相关信息！！！</font>");
				}
			}  
			if (input_all!=0)   { 
// 				location.href="#";
			}else{
				$.ligerDialog.confirm("更新数据成功,是否继续操作","提示信息",function(rtn){
					$("#tUserFundsForm").ajaxSubmit(function(){return false;});
					if(!rtn){
						location.href="list.ht";
					}
					else{
						location.href="edit.ht?fundsId="+id;
					}
				});
			}
		}
		
		function checkMoneyFormat1(obj){
	        var reg = /^[0-9]{0}([0-9]|[.])+$/;
	        if(reg.test(obj.value)!=true){
	        	$("#div_1").html("<font color='red'>输入的金额格式错误！！！</font>");
	        	obj.value="";
	        }else{
	        	$("#div_1").html("<font color='red'></font>");
	        }
	    }
		
		function checkMoneyFormat2(obj){
	        var reg = /^[0-9]{0}([0-9]|[.])+$/;
	        if(reg.test(obj.value)!=true){
	        	$("#div_2").html("<font color='red'>输入的金额格式错误！！！</font>");
	        	obj.value="";
	        }else{
	        	$("#div_2").html("<font color='red'></font>");
	        }
	    }
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="javascript:formSubmit(${tUserFunds.fundsId});"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div> 
		<div class="panel-body" style="margin-top: 1px">
		<form id="tUserFundsForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">会员:</th>	
								<td>	
									<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tUserFunds.userId }"/>
								</td>
								<th width="45%"></th>
							</tr>
							<tr>
								<th width="25%">账户余额:</th>	
								<td>										 
									${tUserFunds.balance}
								</td>
								<th width="45%"></th>
							</tr>
							<tr>
								<th width="25%"><font color='red'>*</font>冻结金额:</th>	
								<td>										 
									<input type="text"  id="freeze" name="freeze" value="${tUserFunds.freeze}" class="inputText" style="width: 200px;" onkeyup="javascript:checkMoneyFormat1(this);"/>
								</td>
								<th width="45%" style="text-align: left;"><div id="div_1" style="display: inline;text-align: left;"></div></th>
							</tr>
							<tr>
								<th width="25%"><font color='red'>*</font>可用金额:</th>	
								<td>										 
									<input type="text" id="available" name="available" value="${tUserFunds.available}" class="inputText" style="width: 200px;"  onkeyup="javascript:checkMoneyFormat2(this);"/>
								</td>
								<th width="45%" style="text-align: left;"><div id="div_2" style="display: inline;"></div></th>
							</tr>
					</table>
					<input type="hidden" name="fundsId" value="${tUserFunds.fundsId}" />
					<input type="hidden" name="fundsIn" value="${tUserFunds.fundsIn}" />
					<input type="hidden" name="fundsOut" value="${tUserFunds.fundsOut}" />
					<input type="hidden" name="creditOut" value="${tUserFunds.creditOut}" />
					<input type="hidden" name="creditIn" value="${tUserFunds.creditIn}" />
					<input type="hidden" name="limitMaxIn" value="${tUserFunds.limitMaxIn}" />
					<input type="hidden" name="limitMaxOut" value="${tUserFunds.limitMaxOut}" />
					<input type="hidden" name="userId" value="${tUserFunds.userId}" />
					<input type="hidden" name="balance" value="${tUserFunds.balance}" />
				</form>
		</div>
</div>
</body>
</html>