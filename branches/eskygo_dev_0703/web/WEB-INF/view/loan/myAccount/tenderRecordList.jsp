<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!DOCTYPE html >
<html lang="en">
<head>

<meta charset="UTF-8">
<title>投标记录</title>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
  <script type="text/javascript" src="${ctx }/js/lg/plugins/ligerDialog.js"></script>
</head>
<body>
<form id="toubiaojilu_id" name="toubiaojilu_id" action="${ctx}/project/investList.ht">
					<table class="toubiaojilu-table">
					<c:choose>
						<c:when test="${not empty ListPro }">
							<tr>
							<th style="text-align: center;">投资人</th>
							<th style="text-align: center;">投资金额</th>
							<th style="text-align: center;">投资时间</th>
							<th style="text-align: center;">状态</th>
						</tr>
						<c:forEach items="${ListPro }" var="pro">
							<tr>
								<td>${pro.realName }</td>
								<td><span>￥${pro.piAmount }</span></td>
								<td>${pro.piBidTimeStr }</td>
								<td>等待支付</td>
							</tr>
						</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td>无投资记录!</td>
							</tr>
						</c:otherwise>
					</c:choose>
						
				
					</table>
					<input type="hidden" name="projectId" value="${projectId }"/>
						<!-- <a href="javascript:;">首页</a> <a href="javascript:;">上一页</a> <a
							class="page-num" href="javascript:;">1</a> <a class="page-num"
							href="javascript:;">2</a> <a class="page-num" href="javascript:;">3</a>
						<a class="page-num" href="javascript:;">4</a> <a class="page-num"
							href="javascript:;">5</a> <a class="page-num" href="javascript:;">6</a>
						--- <a href="javascript:;">下一页</a> <a href="javascript:;">尾页</a> -->
						 <pageTag:paging form="toubiaojilu_id"/> 
					
</form></body>