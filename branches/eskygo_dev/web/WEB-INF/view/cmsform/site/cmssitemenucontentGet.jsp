<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=CmsSiteMenuContent.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=CmsSiteMenuContent.TABLE_ALIAS%>明细</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="list.ht?siteMenuId=${cmsSiteMenuContent.siteMenuId}">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th>站点栏目外键:</th>	
							<td class="form_input">${cmsSiteMenuContent.siteMenuId}</td>
							<th>标题:</th>	
							<td class="form_input">${cmsSiteMenuContent.contentTitle}</td>
						</tr>
						<tr>
							<th>是否是外部链接:</th>	
							<td class="form_input">${cmsSiteMenuContent.contentIsurl}</td>
							<th>外部连接URL:</th>	
							<td class="form_input">${cmsSiteMenuContent.contentUrl}</td>
						</tr>
						<tr>
							<th>简短标题:</th>	
							<td class="form_input">${cmsSiteMenuContent.contentMinTitle}</td>
							<th>Tag标签:</th>	
							<td class="form_input">${cmsSiteMenuContent.contentTag}</td>
						</tr>
						<tr>
							<th>摘要:</th>	
							<td class="form_input">${cmsSiteMenuContent.contentSummary}</td>
							<th>来源:</th>
							<td class="form_input">${cmsSiteMenuContent.contentAuthor}</td>
						</tr>
						<tr>
							<th>排序号:</th>	
							<td class="form_input">${cmsSiteMenuContent.contentSort}</td>
							<th>发布时间:</th>
							<td class="form_input"><fmt:formatDate value="${cmsSiteMenuContent.contentCreateDate}"  pattern="yyyy-MM-dd HH:mm"/></td>
						</tr>
						<tr>
							<th>更新时间:</th>
							<td class="form_input"><fmt:formatDate value="${cmsSiteMenuContent.contentUpdateDate}"  pattern="yyyy-MM-dd HH:mm"/></td>
							<th>指定模板:</th>	
							<td class="form_input">${cmsSiteMenuContent.contentTemplet}</td>
						</tr>
						<tr>
							<th>是否发布:</th>	
							<td  colspan="3" class="form_input"><f:description itemValue="${cmsSiteMenuContent.contentIfPublish}" nodeKey="sf" /></td>
						</tr>
					</table>
				</form>
		</div>
</div>
</body>
</html>