<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>投资流程</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	  	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>

	<body>
		<div class="top">
		<div class="fintop"></div>
		</div>
		<div class="advertisement">
		<img src="${ctx}/styles/dlweixin/image/advertisement.png" width="100%">
		</div>
		<div class="flowcontent text-center text-gray">
		<h3 class="text-orange2 text-left">注册绑定流程</h3>
			<ul>
				<li>
					<img src="${ctx}/styles/dlweixin/image/flowicont1.png">
					<div><span>1</span>用户注册</div>
				</li>
				<div class="point text-gray2">...</div>
				<li>
					<img src="${ctx}/styles/dlweixin/image/investFlowicon1.png">
					<div><span>2</span>激活用户</div>
				</li>
				<div class="point text-gray2">...</div>
				<li>
					<img src="${ctx}/styles/dlweixin/image/investFlowicon2.png">
					<div><span>3</span>绑定手机/邮箱</div>
				</li>
				<li>
					<img src="${ctx}/styles/dlweixin/image/investFlowicon3.png">
					<div><span>4</span>绑定银行卡</div>
				</li>
				<div class="point text-gray2">...</div>
				<li>
					<img src="${ctx}/styles/dlweixin/image/investFlowicon4.png">
					<div><span>5</span>完善用户信息</div>
				</li>
				
			</ul>
		</div>

		<div class="clear"></div>
		<div class="textdiv background1 text-white text-center lbutton" onclick="registerPage();">立即注册</div>

		<div class="flowcontent text-center text-gray">
		<h3 class="text-orange2 text-left">投资流程</h3>
			<ul>
				<li>
					<img src="${ctx}/styles/dlweixin/image/flowicont1.png">
					<div><span>1</span>投标支付</div>
				</li>
				<div class="point text-gray2">...</div>
				<li>
					<img src="${ctx}/styles/dlweixin/image/investFlowicon4.png">
					<div><span>2</span>借款成立</div>
				</li>
				<div class="point text-gray2">...</div>
				<li>
					<img src="${ctx}/styles/dlweixin/image/flowicont6.png">
					<div><span>3</span>平台放款</div>
				</li>
				<li>
					<img src="${ctx}/styles/dlweixin/image/flowicont7.png">
					<div><span>4</span>收回本息</div>
				</li>
				<div class="point text-gray2">...</div>
				<li>
					<img src="${ctx}/styles/dlweixin/image/flowicont8.png">
					<div><span>5</span>投资结束</div>
				</li>
				
			</ul>
		</div>
		<div class="clear"></div>
		<div class="textdiv background1 text-white text-center lbutton" onclick="investFun();">立即投资</div>
	</body>
	<script type="text/javascript">
		function investFun(){
			window.location.href = "${ctx}/weixin/wxfinancing/wxfinancingPage.ht";
		}
		function registerPage(){
			window.location.href = "${ctx}/weixin/wxuser/registerInit.ht";
		}
	</script>
</html>