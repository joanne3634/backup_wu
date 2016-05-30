<%@page import="com.deelon.core.util.ContextUtil"%>
<%@page import="com.deelon.platform.model.system.SysUser"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@page import="com.deelon.core.util.AppUtil"%>
<html>
<head>
	<title> 回复</title>
	<%@include file="/commons/include/form.jsp" %> 	
	<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=TUserMessage"></script>
	<script type="text/javascript"  src="${ctx }/js/deelon/platform/system/SysDialog.js"></script>
	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
	<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.attach.js" ></script>
	 <script type="text/javascript">
	 function Messagesubmit() {  
			var suburl = $("#subctx").val()+"/loan/aboutus/Replysave.ht";
			var pam=$('#tuserMessageForm').serialize(); 
			$.ajax({
						type:'POST',
						data:pam ,
						dataType:'json',
						url:suburl ,
						success:function(pam) {
							$.ligerDialog.confirm("回复成功,是否继续回复其他留言","提示信息",function(rtn){
								if(!rtn){
									location.href="list.ht";
								}
								else{
									location.href="list.ht";
								}
							}); 
						},
						error:function(XMLHttpRequest, textStatus, errorThrown) {
							 alert(XMLHttpRequest.statusText); 
						}
					});
		} 
	</script>
</head>
<body  >
<div class="panel">
		<div class="panel-top"> 
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href=" javascript:;"  onclick="Messagesubmit()"><span></span>确认回复</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tuserMessageForm" method="post" action="Replysave.ht"> 
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0"> 
				     	<input type="hidden" name="subctx" id="subctx" value="${ctx }">
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
						 
							<tr>
							<th >回复方式: </th>
							<td colspan="3">
							<f:select nodeKey="HFFS" id="messageReplyWay" name="messageReplyWay" defaultValue="${TUserMessage.messageReplyWay }"></f:select> 
							</td> 
							</tr> 
						<%-- 	<tr> 
								<td colspan="4">
									<textarea class="ckeditor"  name="messageReplyAbout" id="messageReplyAbout" >${TUserMessage.messageReplyAbout }</textarea> 
								</td>
							</tr>  --%>
					 <tr height="100" >
					<th  >回复内容:</th>
					<td  ><textarea  name="messageReplyAbout" id="messageReplyAbout" style="width: 98%;height: 100%;">${TUserMessage.messageReplyAbout }</textarea> 
					
					</td> 
					</table>
					    <input type="hidden" id="messageContent" name="messageContent" value="${TUserMessage.messageContent}" />
					    <input type="hidden" id="messageIsReply" name="messageIsReply" value="${TUserMessage.messageIsReply}" />
					    <input type="hidden" id="messageTitle" name="messageTitle" value="${TUserMessage.messageTitle}" />
					    <input type="hidden" id="messageType" name="messageType" value="${TUserMessage.messageType}" />
					    <input type="hidden" id="messageId" name="messageId" value="${TUserMessage.messageId}" />
		                <input type="hidden" id="userId" name="userId" value="${TUserMessage.userId}" />
					   	<input type="hidden" name="messageRemark" id="messageRemark" value="${TUserMessage.messageRemark}" />
						<input type="hidden" name="messageState" id="messageState" value="${TUserMessage.messageState}" /> 
						<input type="hidden" name="messageMobile" id="messageMobile" value="${TUserMessage.messageMobile}" />
						<input type="hidden" name="messageEmail" id="messageEmail" value="${TUserMessage.messageEmail}" />
						<%SysUser sysUser=ContextUtil.getCurrentUser(); %>
						<input type="hidden" name="creator" id="creator" value="<%=sysUser.getUserId()%>">
				</form>
		</div>
</div>
</body>
</html>