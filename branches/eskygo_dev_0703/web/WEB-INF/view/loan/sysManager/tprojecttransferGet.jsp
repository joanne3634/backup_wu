<%@page import="com.deelon.loan.model.sysManager.TprojectTransfer"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TprojectTransfer.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=TprojectTransfer.TABLE_ALIAS%>明细</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th>项目ID:</th>	
							<td>${tprojectTransfer.projectId}</td>
							<th>投资ID:</th>	
							<td>${tprojectTransfer.investId}</td>
						</tr>
						<tr>
							<th>转让者:</th>	
							<td>${tprojectTransfer.transferorId}</td>
							<th>转让债权总额:</th>	
							<td>${tprojectTransfer.claimsSum}</td>
						</tr>
						<tr>
							<th>竞拍底价:</th>	
							<td>${tprojectTransfer.upsetPrice}</td>
							<th>竞拍方式：1.明拍 2.暗拍:</th>	
							<td>${tprojectTransfer.auctionWay}</td>
						</tr>
						<tr>
							<th>竞拍数:</th>	
							<td>${tprojectTransfer.auctionCount}</td>
							<th></th>	
							<td></td>
						</tr>
						<tr>
							<th>浏览量:</th>	
							<td>${tprojectTransfer.viewCount}</td>
							<th>转让描述:</th>	
							<td>${tprojectTransfer.description}</td>
						</tr>
						<tr>
							<th>开放天数:</th>	
							<td>${tprojectTransfer.openDays}</td>
							<th>开放标日期:</th>	
							<td>${tprojectTransfer.openDate}</td>
						</tr>
						<tr>
							<th>关闭标日期:</th>	
							<td>${tprojectTransfer.closeDate}</td>
							<th>成交时间:</th>	
							<td>${tprojectTransfer.turnoverTime}</td>
						</tr>
						<tr>
							<th>中标价(最高):</th>	
							<td>${tprojectTransfer.bidPrice}</td>
							<th>中标人:</th>	
							<td>${tprojectTransfer.bidder}</td>
						</tr>
						<tr>
							<th>中标时间:</th>	
							<td>${tprojectTransfer.bidTime}</td>
							<th>撤销拍卖:</th>	
							<td>${tprojectTransfer.isCancel}</td>
						</tr>
						<tr>
							<th>状态ID:</th>	
							<td>${tprojectTransfer.stateId}</td>
							<th>是否通过审核:</th>	
							<td>${tprojectTransfer.isCheck}</td>
						</tr>
						<tr>
							<th>审核人:</th>	
							<td>${tprojectTransfer.checker}</td>
							<th>审核时间:</th>	
							<td>${tprojectTransfer.checkTime}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>