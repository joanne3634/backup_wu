<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript">
	
		
	   
	</script>
</head>
<body>
 <div class="panel">
		
		<div class="panel-body" style="margin-top: 1px">
		<c:if test="${notExistData eq '1' }">
			<span style="font-size: 18px;color: #666">不存在此笔交易!</span>
		</c:if>
		<c:if test="${not empty LoanOrderQueryBean }">
		
		<form id="tUserFundsForm1" method="post" action="save.ht">
				<span>&nbsp;&nbsp;&nbsp;</span>
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="9%">会员托管账户:</th>	
								<td width="15%">
									${LoanOrderQueryBean.loanOutMoneymoremore}	
								</td>
								
								<th width="9%">平台托管账户:</th>	
								<td  width="15%">
									${LoanOrderQueryBean.loanInMoneymoremore}	
								</td>
								
								<th width="9%">用途:</th>	
								<td width="15%">	
									${LoanOrderQueryBean.transferName}									 
								</td>
							</tr>
							<tr>
								<th width="9%">对账流水号:</th>	
								<td width="15%">										 
									${LoanOrderQueryBean.orderNo}
								</td>
								
								
								<th width="9%">转账金额:</th>	
								<td width="15%"> 	
								<fmt:formatNumber value="${LoanOrderQueryBean.amount}" pattern="###,###.##"/>
																	 
								</td>
								
								<th width="9%">转账类型:</th>	
								<td width="15%">
									<c:choose>
										<c:when test="${LoanOrderQueryBean.transferAction eq '1'}">投标</c:when>
										<c:when test="${LoanOrderQueryBean.transferAction eq '2'}">还款</c:when>
										<c:otherwise>转账</c:otherwise>
									</c:choose>	
								</td>
								
								
							</tr>
							<tr>
								<th width="9%">转账状态:</th>	
								<td width="15%">		
								<c:choose>
										<c:when test="${LoanOrderQueryBean.transferState eq '0'}">未转账</c:when>
										<c:when test="${LoanOrderQueryBean.transferState eq '1'}">已转账</c:when>
									</c:choose>									 
								</td>
								
								<th width="9%">转账时间:</th>	
								<td width="15%"> 	
								${LoanOrderQueryBean.transferTime}
								</td>
								<th width="9%">操作状态:</th>	
								<td width="15%">
								<c:choose>
										<c:when test="${LoanOrderQueryBean.actState eq '0'}">未操作</c:when>
										<c:when test="${LoanOrderQueryBean.actState eq '1'}">已通过</c:when>
										<c:when test="${LoanOrderQueryBean.actState eq '2'}">已退回</c:when>
										<c:when test="${LoanOrderQueryBean.actState eq '3'}">自动通过</c:when>
									</c:choose>		
								</td>
							</tr>
					</table>
				</form> 
				</c:if>
				
				<c:if test="${not empty LoanRechargeOrderQueryBean }">
		<form id="tUserFundsForm1" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="9%">会员托管账户:</th>	
								<td width="15%">
									${LoanRechargeOrderQueryBean.rechargeMoneymoremore}	
								</td>
								
								<th width="9%">平台托管账户:</th>	
								<td  width="15%">
									${LoanRechargeOrderQueryBean.rlatformMoneymoremore}	
								</td>
								
								<th width="9%">用途:</th>	
								<td width="15%">	
									充值									 
								</td>
							</tr>
							<tr>
								<th width="9%">对账流水号:</th>	
								<td width="15%">										 
									${LoanRechargeOrderQueryBean.orderNo}
								</td>
								
								
								<th width="9%">交易金额:</th>	
								<td width="15%"> 	
								${LoanRechargeOrderQueryBean.amount}									 
								</td>
								
								<th width="9%">手续费:</th>	
								<td width="15%">
									${LoanRechargeOrderQueryBean.fee }	
								</td>
								
								
							</tr>
							<tr>
								<th width="9%">手续费类型:</th>	
								<td width="15%">		
								<c:choose>
										<c:when test="${LoanRechargeOrderQueryBean.feeType eq '1'}">充值成功时从充值人账户全额扣除</c:when>
										<c:when test="${LoanRechargeOrderQueryBean.feeType eq '2'}">充值成功时从平台自有账户全额扣除</c:when>
										<c:when test="${LoanRechargeOrderQueryBean.feeType eq '3'}">充值成功时从充值人账户扣除与提现手续费的差值</c:when>
									</c:choose>									 
								</td>
								
								<th width="9%">充值时间:</th>	
								<td width="15%"> 	
								${LoanRechargeOrderQueryBean.rechargeTime}
								</td>
								<th width="9%">充值状态:</th>	
								<td width="15%">
								<c:choose>
										<c:when test="${LoanRechargeOrderQueryBean.rechargeState eq '0'}">未充值</c:when>
										<c:when test="${LoanRechargeOrderQueryBean.rechargeState eq '1'}">成功</c:when>
										<c:when test="${LoanRechargeOrderQueryBean.rechargeState eq '2'}">失败</c:when>
									</c:choose>		
								</td>
							</tr>
					</table>
				</form> 
				</c:if>
				<!--体现  -->
				<c:if test="${not empty LoanWithdrawsOrderQueryBean }">
		<form id="tUserFundsForm1" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="9%">会员托管账户:</th>	
								<td width="15%">
									${LoanWithdrawsOrderQueryBean.withdrawMoneymoremore}	
								</td>
								
								<th width="9%">平台托管账户:</th>	
								<td  width="15%">
									${LoanWithdrawsOrderQueryBean.platformMoneymoremore}	
								</td>
								
								<th width="9%">用途:</th>	
								<td width="15%">	
									提现								 
								</td>
							</tr>
							<tr>
								<th width="9%">对账流水号:</th>	
								<td width="15%">										 
									${LoanWithdrawsOrderQueryBean.orderNo}
								</td>
								
								
								<th width="9%">交易金额:</th>	
								<td width="15%"> 	
								${LoanWithdrawsOrderQueryBean.amount}									 
								</td>
								
								<th width="9%">提现状态:</th>	
								<td width="15%">
									<c:choose>
										<c:when test="${LoanWithdrawsOrderQueryBean.withdrawState eq '0'}">已提交</c:when>
										<c:when test="${LoanWithdrawsOrderQueryBean.withdrawState eq '1'}">成功</c:when>
										<c:when test="${LoanWithdrawsOrderQueryBean.withdrawState eq '2'}">已退回</c:when>
										
									</c:choose>	
								</td>
								
								
							</tr>
							<tr>
								
								
								<th width="9%">提现时间:</th>	
								<td width="15%">
								${LoanWithdrawsOrderQueryBean.withdrawsTime} 	
								</td>
								<th width="9%">会员承担的最高手续费:</th>	
								<td width="15%">
								${LoanWithdrawsOrderQueryBean.feeWithdraws }	
								</td>
								
								<th width="9%">会员实际承担手续费:</th>	
								<td width="15%">
								${LoanWithdrawsOrderQueryBean.feeWithdraws }	
								</td>
							</tr>
							<tr>
								
								
								<th width="9%">平台承担的手续费比例:</th>	
								<td width="15%"> 	
								${LoanWithdrawsOrderQueryBean.feePercent}
								</td>
								<th width="9%">平台承担手续费:</th>	
								<td width="15%">
								${LoanWithdrawsOrderQueryBean.fee }	
								</td>
								
								<th width="9%">平台扣除的免费提现额:</th>	
								<td width="15%">
								${LoanWithdrawsOrderQueryBean.freeLimit }	
								</td>
							</tr>
					</table>
				</form> 
				</c:if>
		
		</div>
</div>
</body>
</html>