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
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="180px;">项目名称:</th>	
							<td  width="370px;"><f:description modelCode="t_c_project"  modelPropertyName="pname" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tcprojectInvest.projectId}"/></td>
<!-- 							<th  width="180px;">询价ID:</th>	
							<td width="370px;">${tcprojectInvest.askPriceId}</td> -->
<!-- 							<th  width="180px;">领投申请ID:</th>	
							<td width="370px;">${tcprojectInvest.applyLeaderId}</td> -->
							<th  width="180px;">投资人:</th>	
							<td width="370px;"><f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tcprojectInvest.userId}"/></td>
						</tr>
						<tr>
							<th width="180px;">认投类型<!-- ：1领投全部  2领投部分 3跟投 -->:</th>	
							<td width="370px;"><f:description nodeKey="RTLX"  itemValue="${tcprojectInvest.pitypeId}"></f:description></td>
							<th width="180px;">认投金额（万元）:</th>	
							<td width="370px;"><span style="color: red;">${tcprojectInvest.piinvest}</span></td>
						</tr>
						<tr>
							<th  width="180px;">认投时间 :</th>	
							<td width="370px;"><fmt:formatDate value="${tcprojectInvest.piinvestTime}" pattern="yyyy-MM-dd HH:mm"/></td>
							<th  width="180px;">是否是领投人:</th>	
							<td width="370px;">
								<c:choose>
									<c:when test="${tcprojectInvest.piisLeader == 1}">是</c:when>
									<c:when test="${tcprojectInvest.piisLeader == 0}">否</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th  width="180px;">是否拒绝认投:</th>	
							<td width="370px;">
								<c:choose>
									<c:when test="${tcprojectInvest.piisDeny == 1}">是</c:when>
									<c:when test="${tcprojectInvest.piisDeny == 0}">否</c:when>
								</c:choose>
							</td>
							<th  width="180px;">是否愿意担任有限合伙企业普通合伙人:</th>	
							<td width="370px;">
								<c:choose>
									<c:when test="${tcprojectInvest.piisGeneralPartner == 1}">是</c:when>
									<c:when test="${tcprojectInvest.piisGeneralPartner == 0}">否</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th  width="180px;">是否认投<!-- （反悔） -->:</th>	
							<td width="370px;">
								<c:choose>
									<c:when test="${tcprojectInvest.piisCancel == 1}">已认投</c:when>
									<c:when test="${tcprojectInvest.piisCancel == 0}">未认投</c:when>
								</c:choose>
							</td>
							<th  width="180px;">是否放款:</th>	
							<td width="370px;">
								<c:choose>
									<c:when test="${tcprojectInvest.piisPay == 1 }">已放款</c:when>
									<c:when test="${tcprojectInvest.piisPay == 0 }">未放款</c:when>
								</c:choose>
                            </td>
						</tr>
						<tr>
							<th  width="180px;">放款时间:</th>	
							<td width="370px;"><fmt:formatDate value="${tcprojectInvest.pipayTime}" pattern="yyyy-MM-dd HH:mm"/></td>
							<th  width="180px;">是否询价:</th>	
							<td width="370px;">
								<c:choose>
									<c:when test="${tcprojectInvest.piisAskPrice == 1}">已询价</c:when>
									<c:when test="${tcprojectInvest.piisAskPrice == 0}">未询价</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th  width="180px;">投资理由:</th>	
							<td colspan="3" width="370px;">${tcprojectInvest.pireasons}</td>

						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>