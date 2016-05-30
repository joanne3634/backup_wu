<%@page import="com.deelon.crowdfunding.model.backstage.TcprojectInvest"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=TcprojectInvest.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=TcprojectInvest.TABLE_ALIAS%>明细</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="${preurl}.ht?project=${tcprojectInvest.projectId}">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th>是否是领投人:  </th>	
							<td><c:choose>
									<c:when test="${tcprojectInvest.piisLeader==1}">
										<span class="">是</span>
									</c:when>
								   	<c:when test="${tcprojectInvest.piisLeader==0}">
									   	<span class="">否</span>
								   	</c:when>
							    </c:choose> </td>
							<th>认投类型 :</th>	
							<td><c:choose>
									<c:when test="${tcprojectInvest.pitypeId==1}">
										<span class="">领投全部</span>
									</c:when>
								   	<c:when test="${tcprojectInvest.pitypeId==2}">
									   	<span class="">领投部分</span>
								   	</c:when>
								   	<c:when test="${tcprojectInvest.pitypeId==3}">
									   	<span class="">跟投</span>
								   	</c:when>
							    </c:choose> </td>
						</tr>
						<tr>
							<th>估值（万元）:</th>	
							<td><fmt:formatNumber value="${tcprojectInvest.pivaluation/10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber></td>
							<th>认投金额（万元）:</th>	
							<td><fmt:formatNumber value="${tcprojectInvest.piinvest/10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber></td>
						</tr>
						<tr>
							<th>认投时间 :</th>	
							<td><fmt:formatDate value="${tcprojectInvest.piinvestTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
							<th>投资理由:</th>	
							<td>${tcprojectInvest.pireasons}</td>
						</tr>
						<tr>
							<th>投资人是否付款:  </th>	
							<td><c:choose>
									<c:when test="${tcprojectInvest.piisPay==1}">
										<span class="">是</span>
									</c:when>
								   	<c:when test="${tcprojectInvest.piisPay==0}">
									   	<span class="">否</span>
								   	</c:when>
							    </c:choose> </td>
							<th>投资人付款时间:</th>	
							<td><fmt:formatDate value="${tcprojectInvest.pipayTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
						</tr>
						<tr>
							<th>平台是否放款:  </th>	
							<td><c:choose>
									<c:when test="${tcprojectInvest.piisLoans==1}">
										<span class="">是</span>
									</c:when>
								   	<c:when test="${tcprojectInvest.piisLoans==0}">
									   	<span class="">否</span>
								   	</c:when>
							    </c:choose> </td>
							<th>平台放款时间:</th>	
							<td><fmt:formatDate value="${tcprojectInvest.piLoansTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
						</tr>
						<tr>
							<th>是否询价:  </th>	
							<td><c:choose>
									<c:when test="${tcprojectInvest.piisAskPrice==1}">
										<span class="">是</span>
									</c:when>
								   	<c:when test="${tcprojectInvest.piisAskPrice==0}">
									   	<span class="">否</span>
								   	</c:when>
							    </c:choose> </td>
							<th>已放款金额:</th>	
							<td><fmt:formatNumber value="${tcprojectInvest.pihavedPay}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber></td>
						</tr>
						<tr>
							<th>是否通过审核: </th>	
							<td><c:choose>
									<c:when test="${tcprojectInvest.piisCheck==1}">
										<span class="">通过</span>
									</c:when>
								   	<c:when test="${tcprojectInvest.piisCheck==2}">
									   	<span class="">不通过</span>
								   	</c:when>
								   	<c:when test="${tcprojectInvest.piisCheck==0}">
									   	<span class="">未处理</span>
								   	</c:when>
							    </c:choose> </td>
							<th>审核人:</th>	
							<td>${tcprojectInvest.pichecker}</td>
						</tr>
						<tr>
							<th>审核时间:</th>	
							<td><fmt:formatDate value="${tcprojectInvest.picheckTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
							<th>拒绝理由:</th>	
							<td>${tcprojectInvest.pidenyReason}</td>
						</tr>
						<tr>
							<th width="19%">我能为创业都提供非资金的帮助:</th>	
							<td width="31%">${tcprojectInvest.pimyHelp}</td>
							<th width="19%">是否愿意担任有限合伙企业普通合伙人:</th>	
							<td width="31%"><c:choose>
									<c:when test="${tcprojectInvest.piisGeneralPartner==1}">
										<span class="">是</span>
									</c:when>
								   	<c:when test="${tcprojectInvest.piisGeneralPartner==0}">
									   	<span class="">否</span>
								   	</c:when>
							    </c:choose> </td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>