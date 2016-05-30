<%@page import="com.deelon.loan.model.front.TUser"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>投资金额线下支付</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript">
		$(function() {
			$("a.save").click(function() { 
				$("#TmoneyMoveForm").validate({
					rules: {//开始声明验证规则
						cardId:{
							required:true,
							digits:true,
							maxlength: 20

						},
						flowCode:{
							required:true,
							digits:true,
							maxlength: 50
//							chrnum: true,
//							minlength: 5,

						},
						moneyInOut:{
							required:true
						}
					},
					messages: {
						cardId:{
							required: "请输入银行卡号",
							digits: "必须输入数字",
							maxlength:"最大长度为20"
						},
						flowCode:{
							required: "请输入流水账号",
							digits: "必须输入数字",
							maxlength:"最大长度为20"

						},
						moneyInOut:{
							required:"必填"
						}
					}
				});
				if($('#TmoneyMoveForm').valid()){
					$.ajax({
						url : "${ctx}/crowdfunding/backstage/userinvest/toPayInvestMoney.ht",
						type : 'post',
						data : $('#TmoneyMoveForm').serialize(),
						dataType : 'json',
						success : function(data) {
							if(data.result == 1){
								$.ligerDialog.alertExt("数据操作成功","提示信息",function(rtn){
									if(rtn){
										location.href="${ctx}/crowdfunding/backstage/tcprojectinvest/toPayInvestMoneyList.ht?groupId=2";
									}
									else{
										location.href="#";
									}
								});
							}
						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							$.ligerDialog.alertExt("保存失败!","提示信息",function(rtn){
								if(rtn){
									location.href="${ctx}/crowdfunding/backstage/tcprojectinvest/toPayInvestMoneyList.ht?groupId=2";
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
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="${ctx}/crowdfunding/backstage/tcprojectinvest/toPayInvestMoneyList.ht?groupId=2"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="TmoneyMoveForm" method="post" action="${ctx}/crowdfunding/backstage/tcprojectinvest/toPayInvestMoney.ht?investId==${tcprojectInvestItem.investId}">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="25%">项目名称:</th>
							<td colspan="3">
								${tcproject.pname}
							</td>
						</tr>
						<tr>
								<th width="25%">投资者用户名:</th>
								<td>										 
									${tuser.loginName}
								</td>
								<th width="25%">投资者真实名:</th>
								<td>
									${tuser.realName}
								</td>
							</tr>
								<tr>
									<th width="25%">银行卡号:</th>
									<td>
										<input type="text" id="cardId" name="cardId" value="${tMoneyMove.cardId}" class="inputText" style="width: 250px;"/>
									</td>
									<th width="25%">投资金额:</th>
									<td>
										<input type="text" readonly="readonly" id="moneyInOut" name="moneyInOut" value="${tMoneyMove.moneyInOut}" class="inputText" style="width: 250px;background-color: #C9C9C9;"/>
									</td>
								</tr>
								<tr>
									<th width="25%">交易流水号:</th>
									<td>
										<input type="text" id="flowCode" name="flowCode" value="${tMoneyMove.flowCode}" class="inputText" style="width: 250px;"/>
									</td>
									<th width="25%">备注说明:</th>
									<td>
										<input type="text"  readonly="readonly" id="remark" name="remark" value="${tMoneyMove.remark}" class="inputText" style="width: 250px;background-color: #C9C9C9;"/>
									</td>
								</tr>
					</table>
					<input type="hidden" id="userId" name="userId" value="${tMoneyMove.userId}" />
					<input type="hidden" id="projectId" name="projectId" value="${tMoneyMove.projectId}" />
					<input type="hidden" id="investId" name="investId" value="<%=request.getParameter("investId")%>" />
		</form>
		</div>
</div>
</body>
</html>