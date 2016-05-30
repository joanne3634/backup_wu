<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
 <%@ include file="/crowdfunding/cssorjs.jsp"%>
 <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   </head>
<body>
	<form id="pageForm" name="pageForm" action="">
		<table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
			<tr>
				<th width="50">序号</th>
				<th width="420">充值金额（元）</th>
				<th width="280">充值时间</th>
				<th width="280">操作状态</th>
				<th width="95">审核状态</th>
			</tr>
			<c:forEach items="${listvo }" var="vo" varStatus="i">
				<tr>
					<td>${i.count }</td>
					<td><fmt:formatNumber value="${vo.moneyInOut }" pattern="###,###.##"  minFractionDigits="2"  /></td>
					<td>${vo.createTimeS }</td>
					<td><c:if test="${vo.resultId == 1}">充值成功</c:if><c:if test="${vo.resultId == 2}">充值失败</c:if><c:if test="${vo.resultId == 0}">未知</c:if></td>
					<td><f:description nodeKey="SHZT" itemValue="${vo.audit }"></f:description></td>
				</tr>
			</c:forEach>
		</table>
		<pageTag:paging form="pageForm"/>
	</form>
</body>
</html>