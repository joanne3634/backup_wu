<%@page import="com.deelon.loan.model.front.TUser"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>投资金额详情页面</title>
	<%@include file="/commons/include/form.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="${ctx}/crowdfunding/backstage/tcprojectinvest/paidlist.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
								<th width="25%">投资者用户名:</th>
								<td>										 
									${tMoneyMove.userName}
								</td>
								<th width="25%">投资者真实名:</th>
								<td>
									${tMoneyMove.realName}
								</td>
							</tr>
								<tr>
									<th width="25%">银行卡号:</th>
									<td>
										${tMoneyMove.cardId}
									</td>
									<th width="25%">付款金额:</th>
									<td>
										${tMoneyMove.moneyInOut}
									</td>
								</tr>
								<tr>
									<th width="25%">交易流水号:</th>
									<td>
										${tMoneyMove.flowCode}
									</td>
									<th width="25%">备注说明:</th>
									<td>
										${tMoneyMove.remark}
									</td>
								</tr>
						<tr>
							<th width="25%">是否线下支付:</th>
							<td colspan="3">
								<f:description nodeKey="sf"  itemValue="${tMoneyMove.isOffLine}"/>
							</td>
						</tr>
					</table>
		</div>
</div>
</body>
</html>