
<%--
	time:2013-12-14 14:37:08
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>sys_org_bank明细</title>
<%@include file="/commons/include/get.jsp"%>
<script type="text/javascript">
	//放置脚本
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">sys_org_bank详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link back" href="list.ht"><span></span>返回</a>
					</div>
				</div>
			</div>
		</div>
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th width="20%">bank_register:</th>
				<td>${sysOrgBank.bankRegister}</td>
			</tr>
			<tr>
				<th width="20%">bank_account:</th>
				<td>${sysOrgBank.bankAccount}</td>
			</tr>
			<tr>
				<th width="20%">bank_name:</th>
				<td>${sysOrgBank.bankName}</td>
			</tr>
			<tr>
				<th width="20%">orgid:</th>
				<td>${sysOrgBank.orgid}</td>
			</tr>
			<tr>
				<th width="20%">bank_remark:</th>
				<td>${sysOrgBank.bankRemark}</td>
			</tr>
		</table>
		</div>
	</div>
</body>
</html>

