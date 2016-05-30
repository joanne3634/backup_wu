<%@page import="com.deelon.loan.model.sysManager.TprojectTransfer"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TprojectTransfer.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tprojectTransfer&formSave=Y"></script>
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
			        <c:when test="${tprojectTransfer.transferId!=null}">
			            <span class="tbar-label">编辑<%=TprojectTransfer.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=TprojectTransfer.TABLE_ALIAS%></span>
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
		<form id="tprojectTransferForm" method="post" action="save.html">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">项目ID:</th>	
								<td>										 
									<input type="text" id="projectId" name="projectId" value="${tprojectTransfer.projectId}" class="inputText" />
								</td>
								<th width="25%">投资ID:</th>	
								<td>										 
									<input type="text" id="investId" name="investId" value="${tprojectTransfer.investId}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">转让者:</th>	
								<td>										 
									<input type="text" id="transferorId" name="transferorId" value="${tprojectTransfer.transferorId}" class="inputText" />
								</td>
								<th width="25%">转让债权总额:</th>	
								<td>										 
									<input type="text" id="claimsSum" name="claimsSum" value="${tprojectTransfer.claimsSum}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">竞拍底价:</th>	
								<td>										 
									<input type="text" id="upsetPrice" name="upsetPrice" value="${tprojectTransfer.upsetPrice}" class="inputText" />
								</td>
								<th width="25%">竞拍方式：1.明拍 2.暗拍:</th>	
								<td>										 
									<input type="text" id="auctionWay" name="auctionWay" value="${tprojectTransfer.auctionWay}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">竞拍数:</th>	
								<td>										 
									<input type="text" id="auctionCount" name="auctionCount" value="${tprojectTransfer.auctionCount}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">浏览量:</th>	
								<td>										 
									<input type="text" id="viewCount" name="viewCount" value="${tprojectTransfer.viewCount}" class="inputText" />
								</td>
								<th width="25%">转让描述:</th>	
								<td>										 
									<input type="text" id="description" name="description" value="${tprojectTransfer.description}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">开放天数:</th>	
								<td>										 
									<input type="text" id="openDays" name="openDays" value="${tprojectTransfer.openDays}" class="inputText" />
								</td>
								<th width="25%">开放标日期:</th>	
								<td>										 
									<input type="text" name="openDate" value="<fmt:formatDate value='${tprojectTransfer.openDate}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">关闭标日期:</th>	
								<td>										 
									<input type="text" name="closeDate" value="<fmt:formatDate value='${tprojectTransfer.closeDate}' />" class="inputText date" style="width:9%"/>
								</td>
								<th width="25%">成交时间:</th>	
								<td>										 
									<input type="text" name="turnoverTime" value="<fmt:formatDate value='${tprojectTransfer.turnoverTime}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">中标价(最高):</th>	
								<td>										 
									<input type="text" id="bidPrice" name="bidPrice" value="${tprojectTransfer.bidPrice}" class="inputText" />
								</td>
								<th width="25%">中标人:</th>	
								<td>										 
									<input type="text" id="bidder" name="bidder" value="${tprojectTransfer.bidder}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">中标时间:</th>	
								<td>										 
									<input type="text" name="bidTime" value="<fmt:formatDate value='${tprojectTransfer.bidTime}' />" class="inputText date" style="width:9%"/>
								</td>
								<th width="25%">撤销拍卖:</th>	
								<td>										 
									<input type="text" id="isCancel" name="isCancel" value="${tprojectTransfer.isCancel}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">状态ID:</th>	
								<td>										 
									<input type="text" id="stateId" name="stateId" value="${tprojectTransfer.stateId}" class="inputText" />
								</td>
								<th width="25%">是否通过审核:</th>	
								<td>										 
									<input type="text" id="isCheck" name="isCheck" value="${tprojectTransfer.isCheck}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">审核人:</th>	
								<td>										 
									<input type="text" id="checker" name="checker" value="${tprojectTransfer.checker}" class="inputText" />
								</td>
								<th width="25%">审核时间:</th>	
								<td>										 
									<input type="text" name="checkTime" value="<fmt:formatDate value='${tprojectTransfer.checkTime}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr>
					</table>
					<input type="hidden" name="transferId" value="${tprojectTransfer.transferId}" />
				</form>
		</div>
</div>
</body>
</html>