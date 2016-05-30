<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteConfig"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=CmsSiteConfig.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=cmsSiteConfig&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse);
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${cmsSiteConfig.siteConfigId!=null}">
			            <span class="tbar-label">编辑<%=CmsSiteConfig.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=CmsSiteConfig.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div> 
		<div class="panel-body" style="margin-top: 1px">
		<form id="cmsSiteConfigForm" method="post" action="save.ht">
				
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">公司分类:</th>	
								<td colspan="3">			
									 <input class="entityComBo" entityCode="sys_org" entityFiledId="orgId" entityFiledName="orgName" 
									 entityQuery="Q_orgSupId_S=1"   pIdKeyName="orgSupId" valueField="siteOrgId" valueFieldVal="${cmsSiteConfig.siteOrgId }" width="250" />
								</td>
							</tr>
							<tr>
								<th width="25%">站点名称<font color='red'>*</font>:</th>	
								<td>										 
									<input type="text" id="siteName" name="siteName" value="${cmsSiteConfig.siteName}" class="inputText"  style="width: 150px;"/>
								</td>
							</tr> 
							<tr>
							<th width="25%">站点代码<font color='red'>*</font>:</th>	
								<td>										 
									<input type="text"  id="siteCode" name="siteCode" value="${cmsSiteConfig.siteCode}" class="inputText" style="width: 150px;" />
								</td>
							</tr>
							<tr> 
								<th width="25%">站点所有者:</th>	
								<td>										 
									<input type="text" id="siteOwner" name="siteOwner" value="${cmsSiteConfig.siteOwner}" class="inputText" style="width: 150px;"/>
								</td>							
							</tr>
							<tr>
							<th width="25%">主页链接:</th>	
								<td>										 
									<input type="text" id="siteHomeUrl" name="siteHomeUrl" value="${cmsSiteConfig.siteHomeUrl}" class="inputText" style="width: 150px;"/>
								</td>
							</tr>
							<tr>  
							<tr>
								<th width="25%">备注描述:</th>	
								<td colspan="3">	
									<textarea rows="5" cols="80" id="siteMetaInfo" name="siteMetaInfo"  class="inputText">${cmsSiteConfig.siteMetaInfo}</textarea>	 
								</td>
								
							</tr>
							
					</table>
					
					<input type="hidden" name="siteConfigId" value="${cmsSiteConfig.siteConfigId}" />
				</form>
		</div>
</div>
</body>
</html>