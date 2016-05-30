<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>借款项目</title>
  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
</head>

<body>
	<div class="top">
	<div class="fintop"></div>
	</div>

	<div class="applyList  text-gray">
		<ul>
		<c:forEach var="product" items="${productsloan}">
			<li class="applyListli bodersolid3">
				<div style="background-color:${product.styleStr};"
					class="background6 text-center text-white">${product.pName}</div>
				<div class="applysname text-black2">适用${product.pRecommend}</div>
				<div class="applydiv  text-center ">
					<div class="applyleft">
						<div>额度</div>
						<div class="text-orange2">${product.pAmountMin}元~${product.pAmountMax}元</div>
					</div>
					<div class="applyright">
						<div>年利率</div>
						<div class="text-orange2">${product.pRateMin}%~${product.pRateMax}%</div>
					</div>
					<div class="clear"></div>
				</div>
				<div class="applycondition">
					<ul>
						申请条件
						<c:forEach var="appGuide" items="${product.appGuides}">
							<c:if
								test="${appGuide.agOrder==1 or appGuide.agOrder==2 or appGuide.agOrder==3}">
								<li><span>.</span>${appGuide.agDesc}</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				<div style="color:orange;text-align: center;" onclick="viewInfo(${product.productsLoanId});">查看该产品的详细说明</div>
				<div class="textdiv background1 text-white text-center lbutton" onclick="applyLink(${product.productsLoanId})">
					立即申请
				</div>
				<div class="clear"></div>
			</li>
		</c:forEach>
		</ul>
	</div>
</body>

<script type="text/javascript">
	function applyLink(productId){
		window.location.href = "${ctx}/weixin/wxproductsloan/project.ht?productId=" + productId;
	}
	
	function viewInfo(productId){
		window.location.href = "${ctx}/weixin/wxproductsloan/productDetails.ht?productId=" + productId;
	}
</script>
</html>