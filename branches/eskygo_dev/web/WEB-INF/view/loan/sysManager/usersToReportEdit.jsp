<%--
	time:2011-11-28 10:17:09
	desc:edit the 用户表
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>

<html>
<head>
	<title>联系举报用户</title>
	<%@include file="/commons/include/form.jsp" %>
	<f:link href="Aqua/css/ligerui-all.css"></f:link>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tpro_invitation"></script>
	<f:link href="tree/zTreeStyle.css"></f:link>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js" ></script>
	<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js" ></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js" ></script>
   <script type="text/javascript"  src="${ctx}/js/deelon/platform/system/SysDialog.js"></script>
   <script type="text/javascript" src="${ctx}/js/deelon/platform/system/FlexUploadDialog.js"></script>
	<script type="text/javascript">
		
	
	</script>
<style type="text/css">
	html{height:100%}
	body {overflow:auto;}
div.panel-body {
    margin: 0px;
}
</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
					联系举报用户
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
				<div class="group"><a class="link save" id="dataFormSave" href=" javascript:;"  onclick="saveDatas();"><span></span>保存</a></div>
		            <div class="l-bar-separator"></div>
						<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
					<div class="l-bar-separator"></div>
				</div>
			</div>
		</div>
	   <form id="tSetHomepageForm" method="post" action="save.ht">
						
			         
			           		<table class="table-detail"  cellpadding="0" cellspacing="0" border="0">
														
								<tr height="100">
								   <th>流标说明: </th>
								   <td >
								   	<textarea rows="6" cols="20" name="pbreakRemark" id="pbreakRemark" ></textarea>
								   </td>
								</tr>
														
							</table>
							<input type="hidden" id="projectId" name="projectId" value="${ProjectId}" />
					
	          
	  </form>
</div>
</body>
</html>
