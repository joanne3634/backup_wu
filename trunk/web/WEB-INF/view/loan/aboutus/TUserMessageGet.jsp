<%@page import="com.deelon.loan.model.aboutus.TUserMessage"%>
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
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				    <div class="group"><a href='edit.ht?messageId=${TUserMessage.messageId }' class="link edit"><span></span>回复</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th>用户名:</th>	
							<td class="form_input"  >${user.loginName}</td>
							<th>标题:</th>	
							<td class="form_input" style="width: 35%">${TUserMessage.messageTitle}</td>
						</tr>
						<tr>
							<th>留言类型:</th>	
							<td class="form_input"><f:description itemValue="${TUserMessage.messageType}" nodeKey="LYLX" />
							</td> 
								<th>回复状态:</th>	
							<td class="form_input"><f:description itemValue="${TUserMessage.messageIsReply}" nodeKey="HFZT" /> 
							</td>  
						</tr>
						<tr>
							<th>内容:</th>	
							<td class="form_input" style="height: 80px;width: 40%"><textarea  style="height: 100%;width: 98%; border: 0px;" readonly>${TUserMessage.messageContent}</textarea></td> 
						</tr>
					</table>
				</form>
		</div>
</div>
</body>
</html>