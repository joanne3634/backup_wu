<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=CmsSiteMenuContent.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=CmsSiteMenuContent.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_cmsSiteMenuContent" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_cmsSiteMenuContent" css="link add" href="edit.ht?siteMenuId=${siteMenuId }"><span></span>添加</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_cmsSiteMenuContent" css="link update" action="edit.ht?siteMenuId=${siteMenuId }"><span></span>修改</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_cmsSiteMenuContent" css="link update" action="publish.ht"><span></span>发布</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_cmsSiteMenuContent" css="link del" action="del.ht"><span></span>删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<input type="hidden" name="siteMenuId" value="${siteMenuId }"  />
									<span class="label" style="text-align:right;">标题:</span><input type="text" name="Q_contentTitle_S" value="${param['Q_contentTitle_S']}" maxlength="500" class="inputText" />
									<span class="label" style="text-align:right;">来源:</span><input type="text" name="Q_contentAuthor_S" value="${param['Q_contentAuthor_S']}" maxlength="500" class="inputText" />
									<span class="label" style="text-align:right;">创建时间:</span><input type="text" name="Q_contentCreateDateBegin_DL" value="${param['Q_contentCreateDateBegin_DL']}" class="inputText date"/>
									<span class="label" style="text-align:center;width:40px;">至</span><input type="text" name="Q_contentCreateDateEnd_DG" value="${param['Q_contentCreateDateEnd_DG']}" class="inputText date"/>
							</div>
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="cmsSiteMenuContentList" id="cmsSiteMenuContentItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="siteMenuContentId" id="siteMenuContentId" value="${cmsSiteMenuContentItem.siteMenuContentId}"}>
							</display:column>
							<display:column property="contentTitle" title="标题" sortable="false" sortName="content_title" style="text-align:center;width:27%;"/>							
							<display:column property="contentAuthor" title="来源" sortable="false" sortName="content_author" style="text-align:center;width:10%;"/>
							<display:column property="contentSort" title="排序号" sortable="false" sortName="content_sort" style="text-align:center;width:10%;"/> 				
							<display:column  title="发布状态" sortable="false" sortName="content_if_publish" style="text-align:center;width:10%;">
							<%-- <f:description itemValue="${cmsSiteMenuContentItem.contentIfPublish}" nodeKey="fbzt" /> --%>
							<c:choose>
							<c:when test="${cmsSiteMenuContentItem.contentIfPublish==0}">
								<span class="green">未发布</span>
						   	</c:when>
						   	<c:when test="${cmsSiteMenuContentItem.contentIfPublish==1}">
						   	<span class="red">已发布</span>
						   	</c:when>
							</c:choose>
							</display:column>
							<display:column property="contentCreateDate" title="创建时间" sortable="false" sortName="content_create_date" format="{0,date,yyy-MM-dd HH:mm}" style="text-align:center;width:15%;"/> 
							<display:column title="操作" media="html" style="text-align:center;">
								<a href='edit.ht?siteMenuId=${cmsSiteMenuContentItem.siteMenuId }&siteMenuContentId=${cmsSiteMenuContentItem.siteMenuContentId}' class="link edit">编辑</a>	
								<a href='del.ht?siteMenuId=${cmsSiteMenuContentItem.siteMenuId }&siteMenuContentId=${cmsSiteMenuContentItem.siteMenuContentId}'  class='link del'>删除</a>
								<a href='get.ht?siteMenuId=${cmsSiteMenuContentItem.siteMenuId }&siteMenuContentId=${cmsSiteMenuContentItem.siteMenuContentId}'  class="link detail">明细</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="cmsSiteMenuContentItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
