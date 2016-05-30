<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/commons/include/get.jsp" %>
<title>P2P 收益汇总</title>
</head>
<body>
		<table>
			<tbody>
				<c:if test="${empty benifits}">系统无收入记录。</c:if>
				<c:if test="${not empty benifits}">点击汇总金额查询详情记录。</c:if>
				<c:forEach var="benifit" items="${benifits}">
					<tr>
						<td><c:choose>
									<c:when test="${benifit.typeId==10}">
										<span class="green">平台利率差收入</span>
								   	</c:when>
								   	<c:when test="${benifit.typeId==7}">
						   				<span class="green">平台手续费</span>
						   			</c:when>
						   			<c:when test="${benifit.typeId==6}">
						   				<span class="green">担保手续费</span>
						   			</c:when>
								</c:choose> ：</td>
						<td><input type="text" value="${benifit.moneyInOut}" readonly="readonly" onclick="seeDetail('${benifit.typeId}')"></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	<script type="text/javascript">
		function seeDetail(val){
			window.location.href="${ctx}/loan/front/tmoneymove/list.ht?Q_typeId_S="+val;
		}
	</script>	
		
</body>
</html>