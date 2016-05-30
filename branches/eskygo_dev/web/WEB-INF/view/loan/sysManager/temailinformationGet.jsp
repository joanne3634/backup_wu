
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">明细</span>
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
							<th>通知类型（1=网站、2=系统、3=APP）:</th>	
							<td>${temailinformation.serviceType}</td>
							<th>EMAIL通知邮件地址:</th>	
							<td>${temailinformation.emailAddr}</td>
						</tr>
						<tr>
							<th>消息标题:</th>	
							<td>${temailinformation.header}</td>
							<th>短信内容:</th>	
							<td>${temailinformation.messasge}</td>
						</tr>
						<tr>
							<th>通知状态：0=成功，1=失败:</th>	
							<td>${temailinformation.status}</td>
							<th>创建人ID:</th>	
							<td>${temailinformation.creator}</td>
						</tr>
						<tr>
							<th>创建时间:</th>	
							<td>${temailinformation.createTime}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>