<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>过滤器管理</title>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript">
	function share(conf){
		var url=__ctx +"/platform/bus/busQueryShare/edit.ht?filterId=" + conf.filterId ;
		var winArgs="dialogWidth:650px;dialogHeight:390px;help:0;status:0;scroll:1;center:1;resizable:1";
		url=url.getNewUrl();
	 	var rtn=window.showModalDialog(url,"",winArgs);
	}
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title" style=" display: block;">
				<span class="tbar-label">过滤器管理列表</span>
			</div>
		<div class="panel-body">
			<table  cellpadding="1" class="table-grid table-list" cellspacing="1">
				<tr>
					<th width="50%">我的过滤器</th>
					<th width="10%">共享</th>
					<th width="10%">创建时间</th>
					<th>管理</th>
				</tr>
				<c:choose>
					<c:when test="${!empty myFilterList && fn:length(myFilterList) >0 }">
						<c:forEach items="${myFilterList}" var="busQueryFilterItem">
							<tr>
								<td><a href="${url}${busQueryFilterItem.id}"><c:if test="${busQueryFilterItem.isShare ==1}">【共享】</c:if>${busQueryFilterItem.filterName}</a>
									</br>&nbsp;&nbsp;&nbsp;&nbsp;${busQueryFilterItem.filterDesc}</td>
								<td><c:choose>
										<c:when test="${busQueryFilterItem.isShare==0}">个人</c:when>
										<c:otherwise>全局</c:otherwise>
									</c:choose>
								</td>
								<td><fmt:formatDate value="${busQueryFilterItem.createtime}" pattern="yyyy-MM-dd"/></td>
								<td>
									<a href="${url}${busQueryFilterItem.id}" class="link detail">查看</a>
									<a href="del.ht?id=${busQueryFilterItem.id}" class="link del">删除</a>
									<a href="#" class="link edit">编辑</a>
									<a href="#" onclick="share({filterId:'${busQueryFilterItem.id}'})" class="link edit">共享</a>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">你没有保存过的过滤器.</td>
						<tr>
					</c:otherwise>
				</c:choose>
			</table>
			<table  cellpadding="1" class="table-grid table-list" cellspacing="1">
				<tr>
					<th width="50%">可用的过滤器</th>
					<th width="10%">共享</th>
					<th width="10%">创建时间</th>
					<th>共享人</th>
				</tr>
				<c:choose>
					<c:when test="${!empty shareFilterList && fn:length(shareFilterList) >0 }">
						<c:forEach items="${shareFilterList}" var="busQueryFilterItem">
							<tr>
								<td><a href="${url}${busQueryFilterItem.id}">【共享】${busQueryFilterItem.filterName}</a>
									</br>&nbsp;&nbsp;&nbsp;&nbsp;${busQueryFilterItem.filterDesc}</td>
								<td>${busQueryFilterItem.isShare}</td>
								<td><fmt:formatDate value="${busQueryFilterItem.createtime}" pattern="yyyy-MM-dd"/></td>
								<td align="center"><f:userName userId="${busQueryFilterItem.createBy}"/></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">当前没有共享的过滤器</td>
						<tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
</body>
</html>


