<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>借款项目详情</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>
	<body>
		<div class="top">
		<div class="fintop"></div>
		</div>

		<div class="tagname text-white background7">${product.pName}<div class="triangle"></div></div>
        <div class="Investmentdetails text-gray">
        	<p>额度: ${product.pAmountMin}元~${product.pAmountMax}元 </p>
        	<p>贷款利率:${product.pRateMin}%~${product.pRateMax}%(即月利率：${product.pRateMin/12}%~${product.pRateMax/12}%) </p>
        	<p>贷款期限:${product.pDeadlineMin}~${product.pDeadlineMax}个月</p>
        	<p>投标时间:${product.pVotingDaysMin}~${product.pVotingDaysMax}天 </p>
        	<p>审核时间:满标后${product.pAuditDaysMin}~${product.pAuditDaysMax}个工作日</p>
        	<p>还款方式:<c:choose>
						<c:when test="${product.pRepayWay==1}">
							<span class="green">一次性还本付息</span>
						</c:when>
					   	<c:when test="${product.pRepayWay==2}">
						   	<span class="green">按月付息,到期还本</span>
					   	</c:when>
					   	<c:when test="${product.pRepayWay==3}">
						   	<span class="green">等额本息,每月还款</span>
					   	</c:when>
					   	<c:when test="${product.pRepayWay==4}">
						   	<span class="green">等额本金,每月还款</span>
					   	</c:when>
				       	<c:otherwise>
				       		<span class="red">自定义</span>
					   	</c:otherwise>
				  </c:choose> </p>
        	<p>手续费:${product.pFee}</p>

        	<h3 class="text-black2">申请指南</h3>
        	<c:forEach var="appGuide" items="${product.appGuides}">
          	<p>${appGuide.agDesc}</p>
        	</c:forEach>

        	<h3 class="text-black2">准备资料</h3>
        	<c:forEach var="preDatas" items="${product.prepareDatas}">
            <p>${preDatas.pdDesc}</p>
        	</c:forEach>
        </div>
		
	</body>
</html>