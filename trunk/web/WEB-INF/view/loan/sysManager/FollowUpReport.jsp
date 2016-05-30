<%--
	time:2011-11-28 10:17:09
	desc:edit the 用户表
--%>
<%@page import="com.deelon.core.util.ContextUtil"%>
<%@page import="com.deelon.platform.model.system.SysUser"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>

<html>
<head>
<title>联系举报用户</title>
<%@include file="/commons/include/form.jsp"%>
<f:link href="Aqua/css/ligerui-all.css"></f:link>
<script type="text/javascript"
	src="${ctx}/servlet/ValidJs?form=tpro_invitation"></script>
<f:link href="tree/zTreeStyle.css"></f:link>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js"></script>
<script type="text/javascript"
	src="${ctx}/js/deelon/platform/system/SysDialog.js"></script>
<script type="text/javascript"
	src="${ctx}/js/deelon/platform/system/FlexUploadDialog.js"></script>
<script type="text/javascript">
	
</script>
<style type="text/css">
html {
	height: 100%
}

body {
	overflow: auto;
}

div.panel-body {
	margin: 0px;
}
</style>
<script type="text/javascript">
	 function Reportsubmit() {   
			var suburl = $("#subctx").val()+"/loan/sysManager/usersToReport/FollowUpReportsave.ht";
			var pam=$('#tuserMessageForm').serialize(); 
			$.ajax({
						type:'POST',
						data:pam ,
						dataType:'json',
						url:suburl ,
						success:function(pam) {
							$.ligerDialog.confirm("提交成功,是否继续处理其他投诉","提示信息",function(rtn){
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
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"> 联系举报用户 </span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link save" id="dataFormSave" href=" javascript:;" onclick="Reportsubmit();"><span></span>保存</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link back" href="list.ht"><span></span>返回</a>
						<input type="hidden" name="subctx" id="subctx" value="${ctx }">
					</div>
					<div class="l-bar-separator"></div>
				</div>
			</div>
		</div>
		<form id="tuserMessageForm" method="post"  > 
			<table class="table-detail" cellpadding="0" cellspacing="0"
				border="0">
	            <tr >
					<th>联系方式:</th>
					<td  style="width: 25%;">		
					<f:select nodeKey="HFFS" id="linkWay" name="linkWay"></f:select> 					 
					 </td> 
					 	<th>处理状态:</th>
					<td  >		
					<f:select nodeKey="TSZT" id="stateId" name="stateId" defaultValue="${stateId }"></f:select> 					 
					 </td>   
						 <jsp:useBeanid="nowDate" class="java.util.Date"/>						 
						 <input type="hidden" style="width: 150px"  name="createTime" value='<fmt:formatDate value="${cmsSiteMenuContent.contentCreateDate==null?nowDate:cmsSiteMenuContent.contentCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>' size="25" class="inputText datetime" />
				 </tr>
				<tr height="100" >
					<th  >跟进记录:</th>
					<td  ><textarea rows="6" cols="20" name="notes" id="notes"></textarea>
					<%SysUser sysUser=ContextUtil.getCurrentUser(); %>
					<input type="hidden" name="creator" id="creator" value="<%=sysUser.getUserId()%>">
					<input type="hidden" name="reportId" id="reportId" value="${userId }">
					
					</td> 
				</tr>
			</table>
		</form>
		<div style="height: 10px;"></div>
		<div><h2>历史记录</h2></div>
		 <display:table name="tuserReportFollowup" id="tr"  sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
					         <display:column property="notes" title="处理记录"  style="text-align:left"/>    
							<display:column  title="处理方式"  sortName="linkWay" style="text-align:left">
								<f:description itemValue="${tr.linkWay}" nodeKey="HFFS3" />
							</display:column> 
							<display:column  title="处理状态"  sortName="stateId" style="text-align:left">
								<f:description itemValue="${tr.stateId}" nodeKey="TSZT" />
							</display:column> 
							   <display:column  title="创建时间" sortable="true" sortName="createTime">
						       <fmt:formatDate value="${tr.createTime}" pattern="yyyy-MM-dd HH:mm"/>
					        </display:column>
		  </display:table>
		  
	</div>
</body>
</html>
