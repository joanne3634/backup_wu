<%@page import="com.deelon.crowdfunding.model.backstage.TcprojectNews"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=TcprojectNews.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=TcprojectNews.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tprojectNews" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
<!-- 							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tprojectNews" css="link add" href="edit.ht"><span></span>添加</f:a></div> -->
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tprojectNews" css="link update" action="edit.ht"><span></span>修改</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tprojectNews" css="link del" action="delShow.ht"><span></span>删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">项目名称:</span>
									<%--
									<select id="Q_projectId_S" name="Q_projectId_S">
										<option value="">请选择</option>
											<c:forEach items="${tcProjectList }" var="list">
												<option value="${list.projectId }" <c:if test="${param['Q_projectId_S'] == list.projectId }">selected</c:if>>${list.pname }</option>
											</c:forEach>
									</select>
									--%>
									<input type="text" name="Q_projectName_S" value="${param['Q_projectName_S']}" class="inputText" />
									
									<span class="label">标题:</span><input type="text" name="Q_pntitle_S" value="${param['Q_pntitle_S']}" maxlength="150" class="inputText" style="width: 150px;"/>
									
									
									
<!-- 									<span class="label">类型:1项目动态 2项目信息披露:</span><input type="text" name="Q_pntypeId_S" value="${tprojectNews.pntypeId}" maxlength="3" class="inputText" />
									<span class="label">内容:</span><input type="text" name="Q_pncontent_S" value="${tprojectNews.pncontent}" maxlength="2000" class="inputText" /> -->
							</div>
<!-- 							<div class="row">
									<span class="label">创建人:</span><input type="text" name="Q_creator_S" value="${tprojectNews.creator}" maxlength="19" class="inputText" />
									<span class="label">创建时间:</span><input type="text" name="Q_begincreateTime_DL" value="<fmt:formatDate value='${tprojectNews.begincreateTime}'/>" class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endcreateTime_DG" value="<fmt:formatDate value='${tprojectNews.endcreateTime}'/>" class="inputText date" style="width:9%"/>
							</div> -->
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tprojectNewsList" id="tprojectNewsItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="newsId" id="newsId" value="${tprojectNewsItem.newsId}"}>
							</display:column>
							<display:column  title="项目名称" sortable="false" sortName="projectId" style="text-align:leftwidth:80px;">
								<f:description modelCode="t_c_project"  modelPropertyName="pname" modelPropertyValue="projectId" nodeKey="MODEL_DATA"  itemValue="${tprojectNewsItem.projectId }"/>
							</display:column> 
							<!--类型:1项目动态 2项目信息 -->	
							<display:column property="pntitle" title="标题" sortable="false" sortName="pntitle" style="text-align:left"/> 

							<display:column title="创建人" sortable="false" sortName="creator" style="text-align:left;width:80px;">
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tprojectNewsItem.creator }"/>
							</display:column> 
							<display:column property="createTime" title="创建时间" sortable="false" format="{0,date,yyy-MM-dd HH:mm}" sortName="createTime" style="text-align:left;width:110px;"/>
							<display:column title="操作" media="html" style="text-align:left;width:50px;">
								<a href='edit.ht?newsId=${tprojectNewsItem.newsId}' class="link edit">编辑</a>	
								<!-- <a href='del.ht?newsId=${tprojectNewsItem.newsId}'  class='link del'>删除</a>		 -->												
							</display:column>
						</display:table>
						<deelon:paging tableId="tprojectNewsItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
