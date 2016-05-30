<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>申请提现</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
   <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
	
			
	<form id="pageForm" name="pageForm" action="">
	    <input type="hidden" name="maxNum" value="<c:out value="${number}"></c:out>"/>
		<table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable" style="width: 90%">
			<tr><th width="50">序号</th><th width="420">提现金额（元）</th><th width="280">申请提现时间</th><th width="95">状态</th></tr>
			
			<c:forEach items="${listvo }" var="vo" varStatus="i">
				<c:if test="${empty maxNum }">
					    <c:set var = "number" value="${i.count}"></c:set>
				</c:if>
				<c:if test="${not empty maxNum }">
				        <c:set var = "number" value="${i.count+maxNum}"></c:set>
				</c:if>
				<tr>
					<td><c:out value="${number}"></c:out></td>
					<td><fmt:formatNumber value="${vo.moneyInOut}" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber></td>
					<td><fmt:formatDate value="${vo.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
					<td><f:description nodeKey="JG" itemValue="${vo.resultId }"></f:description></td>
				</tr>
				
			</c:forEach>
		</table>
		 <pageTag:paging form="pageForm"/> 
	</form>

</body>
</html>
