<%@page import="com.deelon.cmsform.model.site.CmsSiteConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=CmsSiteConfig.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=CmsSiteConfig.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group">							
							<f:a alias="search_cmsSiteConfig" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<%-- <div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_cmsSiteConfig" css="link add" href="edit.ht"><span></span>添加</f:a></div> --%>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_cmsSiteConfig" css="link update" action="edit.ht"><span></span>修改</f:a></div>
							<%-- <div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_cmsSiteConfig" css="link del" action="del.ht"><span></span>删除</f:a></div> --%>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">站点名称:</span><input type="text" name="Q_siteName_S" value="${param['Q_siteName_S']}" maxlength="200" class="inputText" />
									<span class="label">站点所有者:</span><input type="text" name="Q_siteOwner_S" value="${param['Q_siteOwner_S']}" maxlength="200" class="inputText" />
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="cmsSiteConfigList" id="cmsSiteConfigItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:3%;text-align:center;">
								  <input type="checkbox" class="pk" name="siteConfigId" id="siteConfigId" value="${cmsSiteConfigItem.siteConfigId}"}>
							</display:column>
							<display:column property="siteName" title="站点名称"   style="text-align:center;width:16%;"/> 
							<display:column property="siteCode" title="站点代码"  style="text-align:center;width:16%;"/>   
							<display:column property="siteOwner" title="站点所有者"  style="text-align:center;width:16%;"/> 
							<display:column property="siteHomeUrl" title="主页链接"  style="text-align:center;width:16%;"/>   
							<display:column title="公司分类"  style="text-align:center;width:16%;">
								<f:entityComBo valueFieldVal="${cmsSiteConfigItem.siteOrgId}" entityFiledId="orgId" entityFiledName="orgName" entityCode="sys_org" />
							</display:column> 
							<display:column title="操作" media="html" style="text-align:center;">
								<a href='edit.ht?siteConfigId=${cmsSiteConfigItem.siteConfigId}' class="link edit">编辑</a>	
								<%-- <a href='del.ht?siteConfigId=${cmsSiteConfigItem.siteConfigId}'  class='link del'>删除</a>	 --%>													
							</display:column>
						</display:table>
						<%-- <deelon:paging tableId="cmsSiteConfigItem"/> --%>
					</div>
				</div>			
	</div>
</body>
</html>
