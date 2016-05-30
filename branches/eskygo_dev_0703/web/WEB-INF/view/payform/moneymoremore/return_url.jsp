<%
/* *
 功能：付完款后跳转的页面（页面跳转同步通知页面）
 版本：1.0
 日期：2012-05-01
 说明：
 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 该代码仅供学习和研究融宝支付接口使用，只是提供一个参考。

 //***********页面功能说明***********
 该页面可在本机电脑测试
 该页面称作“页面跳转同步通知页面”，是由融宝支付服务器同步调用，可当作是支付完成后的提示信息页，如“您的某某某订单，多少金额已支付成功”。
 可放入HTML等美化页面的代码和订单交易完成后的数据库更新程序代码
 TRADE_FINISHED(表示买家已经确认收货，这笔交易完成);
 
  *************注意******************
 

 即时到帐的交易状态变化顺序是：等待买家付款→交易完成
 
 每当收到融宝支付发来通知中，就可以获取到这笔交易的交易状态，并且商户需要利用商户订单号查询商户网站的订单数据，
 得到这笔订单在商户网站中的状态是什么，把商户网站中的订单状态与从融宝支付通知中获取到的状态来做对比。
 
 **********************************
 
 //********************************
 * */
%>
<%-- <%@ page language="java" contentType="text/html;charset=GBK" pageEncoding="GBK"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<html>
  <head>
   <%@ include file="/crowdfunding/cssorjs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
		<title>支付成功客户端返回</title>
<style type="text/css">
.font_content{
    font-family:"宋体";
    font-size:14px;
    color:#FF6600;
}
.font_title{
    font-family:"宋体";
    font-size:16px;
    color:#FF0000;
    font-weight:bold;
}
table{
    border: 1px solid #CCCCCC;
}
</style>
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
										<c:when test="${ResultCode==1 }">
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
