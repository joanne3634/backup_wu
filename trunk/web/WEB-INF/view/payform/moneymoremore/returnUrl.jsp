<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

	<title>会员支付信息</title>
		<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>

<script type="text/javascript">

$(function(){
	setTimeout(doclosewin, 3000);
});


function doclosewin(){
	window.close();
}



</script>



<body>
		<div class="personalData f_l">
			<h3><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">支付信息</h3>
			<form id="basicdata_form" >
			<div class="clear personalDataform">				
				<ul>	<c:choose>
							<c:when test="${returnType=='1' }">		
									<c:choose>
										<c:when test="${ResultCode==88||ResultCode==16|| not empty tuserFunds.payMark }">
											<li><label>支付号：</label>${tuserFunds.payMark }&nbsp;&nbsp;</li>
											<li><label></label><dfn class="PerDataTopButton2" >绑&nbsp;定&nbsp;成&nbsp;功</dfn></li>
										</c:when>
										<c:otherwise>
												<li><label>绑定错误：</label>${Message }&nbsp;&nbsp;</li>
										</c:otherwise>
									</c:choose>
							</c:when>
							<c:when test="${returnType=='2' }">
									<c:choose>
										<c:when test="${ResultCode==88 }">
											<li><label></label><dfn class="PerDataTopButton2" onclick="doclosewin()">充&nbsp;值&nbsp;成&nbsp;功</dfn></li>
										</c:when>
										<c:otherwise>
												<li><label>充值错误：</label>${Message }&nbsp;&nbsp;</li>
										</c:otherwise>
									</c:choose>
							</c:when>
							<c:when test="${returnType=='3' }">
									<c:choose>
										<c:when test="${ResultCode==88 }">
											<li><label></label><dfn class="PerDataTopButton2" >提&nbsp;现&nbsp;成&nbsp;功</dfn></li>
										</c:when>
										<c:otherwise>
												<li><label>提现错误：</label>${Message }&nbsp;&nbsp;</li>
										</c:otherwise>
									</c:choose>
							</c:when>
							<c:when test="${returnType=='4' }">
									<c:choose>
										<c:when test="${ResultCode==88 }">
											<li><label></label><dfn class="PerDataTopButton2" >支&nbsp;付&nbsp;成&nbsp;功</dfn></li>
										</c:when>
										<c:otherwise>
												<li><label>支付错误：</label>${Message }&nbsp;&nbsp;</li>
										</c:otherwise>
									</c:choose>
							</c:when>
						</c:choose>
						
					
				</ul>
			</div>
			</form>
			
		</div>
	
</body>
</html>
