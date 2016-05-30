<%@page import="com.deelon.loan.model.sysManager.TprojectAuction"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TprojectAuction.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=TprojectAuction.TABLE_ALIAS%>明细</span>
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
							<th>转让ID:</th>	
							<td>${tprojectAuction.transferId}</td>
							<th>报价人:</th>	
							<td>${tprojectAuction.userId}</td>
						</tr>
						<tr>
							<th>已出最高价:</th>	
							<td>${tprojectAuction.highestPrice}</td>
							<th>我的报价:</th>	
							<td>${tprojectAuction.offerPrice}</td>
						</tr>
						<tr>
							<th>报价时间:</th>	
							<td>${tprojectAuction.offerTime}</td>
							<th>中标:</th>	
							<td>${tprojectAuction.isBid}</td>
						</tr>
						<tr>
							<th>中标时间:</th>	
							<td>${tprojectAuction.bidTime}</td>
							<th>撤销竞拍:</th>	
							<td>${tprojectAuction.isCancel}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>