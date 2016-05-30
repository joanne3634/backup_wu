<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>帮助中心</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>
	<body>
		<div class="top">
		<div class="fintop"></div>
		</div>

		<div class="tagname text-white background7">平台原理<div class="triangle"></div></div>
        <div class="Investmentdetails text-gray">
        	<p>P2P贷作为P2P网络借贷平台，为有资金需求和理财需求的用户提供了一个快速、高效、公平、透明的网络借贷信息服务平台。用户可以在P2P贷上发布借款请求；也可以把自己的闲余资金通过P2P贷出借给信用良好有资金需求的用户，在获得良好的资金回报率的同时帮助了他人。专业担保公司对于投资者本金全程担保，大大降低投资者的借出风险。 </p>
        	<p class="text-center"><img src="${ctx}/styles/dlweixin/image/helpicont.png"> </p>
        </div>
		<div class="tagname text-white background7">我们的服务<div class="triangle"></div></div>
		<div class="Investmentdetails text-gray">
			<h3>10%—24%高收益</h3>
			<p>成为P2P贷投资人，借款标的形式多样、资金周转时间灵活。在家足不出户，轻松投资理财就可获得10%-24%的年化收益。</p>
			<h3>24小时充值、提现的优质服务</h3>
			<p>P2P贷是中国首家实现24小时充值、提现的平台。资金充值能随时到账。资金提现当日不设限额，快速到账。并且有客服24小时为您提供温馨的指导与服务。</p>
			<h3>理财“零”门槛</h3>
			<p>只要您是18岁以上中国公民，最低50元就可在P2P贷进行理财。</p>
		</div>
		<div class="tagname text-white background7">简单3步，开始借款<div class="triangle"></div></div>
		<ul class="helpLi text-center text-gray">
			<li><img src="${ctx}/styles/dlweixin/image/help1.png"><div>填写注册资料</div></li>
			<li><img src="${ctx}/styles/dlweixin/image/help2.png"><div>各项认证</div></li>
			<li><img src="${ctx}/styles/dlweixin/image/help3.png"><div>发布借款</div></li>
		</ul>

	</body>
</html>