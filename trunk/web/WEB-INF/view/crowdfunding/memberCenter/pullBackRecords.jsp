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
	<title>认投资格</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
      <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  	<script type="text/javascript" src="${ctx }/crowdfunding/js/ckeditor/ckeditor.js"></script>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
	<form id="pageForm" name="pageForm" action="">	
					<div class="InPrlistTable">
						<table border="0" cellspacing="1" cellpadding="0">
							<tr>
								<th width="140">项目名称 </th>
								<th width="140">认筹时间 </th>
								<th width="140">认筹金额</th>
								<th width="140">接受项目估值 </th>
								<th width="140">项目最终估值</th>
								<th width="140">反悔时间</th>
							</tr>
							<c:forEach items="${listv }" var="vo">
								<tr class="InPrlistTr">
									<td>${vo.pname }</td>
									<td>${vo.piinvestTimeS }</td>
									<td>${vo.piinvest }</td>
									<td>${vo.pivaluation }</td>
									<td>${vo.pvaluationFinal }</td>
									<td><fmt:formatDate value="${vo.piCancelTime }" pattern="yyyy-MM-dd HH:mm"/></td>
								</tr>
							</c:forEach>
							
						</table>
					</div>
					
					<pageTag:paging form="pageForm"/>
			
</form>
</body>
</html>
