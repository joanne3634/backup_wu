<%@page import="com.deelon.loan.model.sysManager.TprojectAuction"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TprojectAuction.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tprojectAuction&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse);
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tprojectAuction.auctionId!=null}">
			            <span class="tbar-label">编辑<%=TprojectAuction.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=TprojectAuction.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tprojectAuctionForm" method="post" action="save.html">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">转让ID:</th>	
								<td>										 
									<input type="text" id="transferId" name="transferId" value="${tprojectAuction.transferId}" class="inputText" />
								</td>
								<th width="25%">报价人:</th>	
								<td>										 
									<input type="text" id="userId" name="userId" value="${tprojectAuction.userId}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">已出最高价:</th>	
								<td>										 
									<input type="text" id="highestPrice" name="highestPrice" value="${tprojectAuction.highestPrice}" class="inputText" />
								</td>
								<th width="25%">我的报价:</th>	
								<td>										 
									<input type="text" id="offerPrice" name="offerPrice" value="${tprojectAuction.offerPrice}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">报价时间:</th>	
								<td>										 
									<input type="text" name="offerTime" value="<fmt:formatDate value='${tprojectAuction.offerTime}' />" class="inputText date" style="width:9%"/>
								</td>
								<th width="25%">中标:</th>	
								<td>										 
									<input type="text" id="isBid" name="isBid" value="${tprojectAuction.isBid}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">中标时间:</th>	
								<td>										 
									<input type="text" name="bidTime" value="<fmt:formatDate value='${tprojectAuction.bidTime}' />" class="inputText date" style="width:9%"/>
								</td>
								<th width="25%">撤销竞拍:</th>	
								<td>										 
									<input type="text" id="isCancel" name="isCancel" value="${tprojectAuction.isCancel}" class="inputText" />
								</td>
							</tr>
					</table>
					<input type="hidden" name="auctionId" value="${tprojectAuction.auctionId}" />
				</form>
		</div>
</div>
</body>
</html>