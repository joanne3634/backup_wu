<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>创业者--投后管理</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/tcprojectAfterCrList.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin;
	</script>
</head>
<body class="iframe">
<div id="tcprojectAfterCR" class="all-100 push-center">
		<div class="title">
			<h3><i class="fa fa-th-list"></i> 投后管理 </h3>
		</div>
		<form action=""   name="pageForm" id="pageForm" method="post">
			<div class="project_search">
				<span>
					项目：<input type="text" id="projectName" name="projectName" value="${projectName }" />
					标题：<input type="text" id="paTitle" name="paTitle" value="${paTitle }" />
				</span>
			</div>
			<div class="AfIndiv">
				<button onclick="submitForm()" class="ink-button blue"><i class="fa fa-search"></i> 查询</button>
				<button onclick="clearForm()" class="ink-button blue" ><i class="fa fa-repeat"></i> 清空</button>
				<button onclick="addEventAndAttach()" class="ink-button blue"><i class="fa fa-plus"></i> 添加事件</button>
				<button onclick="delChecks()" class="ink-button blue"><i class="fa fa-trash-o"></i> 批量删除</button>
			</div>


			<table class="PrDyBackTable ink-table bordered">
				<thead>
				<tr>
				<th><input type="checkbox" name="InvertSelection"/></th>
				<th>序号</th>
				<th>项目</th>
				<th>标题</th>
				<th>创建时间</th>
				<th>操作</th>
				</tr>
				</thead>
				<tbody>
					<c:if test="${empty tcprojectAfterList }">
						<tr><td colspan="6"><div style="text-align:center;">暂无数据！</div></td></tr>
					</c:if>
					<c:forEach items="${tcprojectAfterList }" var="pa" varStatus="s">
						<tr>
							<td><input type="checkbox" name="checkbox" value="${pa.afterId }" ></td>
							<td>${s.index+1 }</td>
							<td>${pa.projectName }</td>
							<td>${pa.paTitle }</td>
							<td><fmt:formatDate value="${pa.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
							<td>
								<i class="fa fa-search-plus" title="查看" role="td-btn" data-type="view" data-after-id="${pa.afterId }"></i>
								<i class="fa fa-pencil" title="编辑" role="td-btn" data-type="edit" data-after-id="${pa.afterId }"></i>
								<i class="fa fa-trash-o" title="删除" role="td-btn" data-type="delete" data-after-id="${pa.afterId }"></i>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
				<pageTag:pagination form="pageForm"/>
		</form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/tcprojectAfterCrList.js" />"></script>
</body>
</html>