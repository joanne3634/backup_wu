<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/commons/include/form.jsp"%>
<meta charset="UTF-8">
<title>安全中心</title>
  <%@ include file="/commons/includeFront/javascripts.jsp"%> 
</head>
<body>
				<div class="tit-box element-box bd-color-main bg-color-s"><span class="tit-xxl color-main">安全中心</span></div>
				<div class="con-box  bd-b-color-main bd-l-color-main bd-r-color-main">
					<div class="con-tips bd-color-main bg-color-s color-main">>>建议您启动全部安全设置，以保障账户和资金安全。</div>
					<ul class="securitycenter-con">
						<li class="bg-color-xs">
							<div class="anquan-ite-bg"></div> <span class="anquan-ite-tit">登录密码</span>
							<span>定期更换密码让您的账户更安全。</span> <a class="color-main" href="${ctx}/loan/front/changePwdPage.ht">修改</a>
						</li>
						<c:if test="${not empty userSafe.q1}">
							<li class="bg-color-xs">
								<div class="anquan-ite-bg" style="background-position: 0 -144px;"></div>
								<span class="anquan-ite-tit">安全问题</span> <span>作为基础安全工具，验证账户信息，保障账户安全。</span>
								<a class="color-main" href="${ctx}/safe/safeQuestionInit.ht">修改</a>
							</li>
						</c:if>
						<c:if test="${empty userSafe.q1}">
							<li class="bg-color-xs">
								<div class="anquan-ite-bg" style="background-position: -33px -144px;"></div>
								<span class="anquan-ite-tit">安全问题</span> <span>作为基础安全工具，验证账户信息，保障账户安全。</span>
								<a class="color-main" href="${ctx}/safe/safeQuestionInit.ht">立即设置</a>
							</li>
						</c:if>
						
						<c:if test="${userSafe.bindMobile == 1 }">
							<li class="bg-color-xs">
								<div class="anquan-ite-bg" style="background-position: 0 -72px;"></div>
								<span class="anquan-ite-tit">手机绑定</span> <span>用于实时了解账户变动，享受拍拍贷手机服务。</span>
								<a class="color-main" href="${ctx}/safe/bindPhone.ht">修改</a>
							</li>
						</c:if>
						
						<c:if test="${userSafe.bindMobile == 0 }">
							<li class="bg-color-xs">
								<div class="anquan-ite-bg" style="background-position: -33px -72px;"></div>
								<span class="anquan-ite-tit">手机绑定</span> <span>用于实时了解账户变动，享受拍拍贷手机服务。</span>
								<a class="color-main" href="${ctx}/safe/bindPhone.ht">立即绑定</a>
							</li>
						</c:if>
						<c:if test="${userSafe.bindEmail == 1 }">
							<li class="bg-color-xs">
								<div class="anquan-ite-bg" style="background-position: 0 -108px;"></div>
								<span class="anquan-ite-tit">邮箱绑定</span> <span>享受拍拍贷邮箱服务，接收账单信息，保障账号安全。</span>
								<a class="color-main" href="${ctx}/safe/bindEmail.ht">修改</a>
							</li>
						</c:if>
						<c:if test="${userSafe.bindEmail == 0 }">
							<li class="bg-color-xs">
								<div class="anquan-ite-bg" style="background-position: -33px -108px;"></div>
								<span class="anquan-ite-tit">邮箱绑定</span> <span>享受拍拍贷邮箱服务，接收账单信息，保障账号安全。</span>
								<a class="color-main" href="${ctx}/safe/bindEmail.ht">立即绑定</a>
							</li>
						</c:if>
						<c:if test="${userSafe.bindIdNo == 1 }">
							<li class="bg-color-xs">
								<div class="anquan-ite-bg" style="background-position: 0 -36px;"></div>
								<span class="anquan-ite-tit">身份认证</span> <span>用于提升安全性和信用分。认证后不能修改。</span>
								<span style="float: right; color: #555;">通过认证</span>
							</li>
						</c:if>
						<c:if test="${userSafe.bindIdNo == 0 }">
							<li class="bg-color-xs">
								<div class="anquan-ite-bg"
									style="background-position: -33px -36px;"></div> <span
								class="anquan-ite-tit">身份认证</span> <span>用于提升安全性和信用分。认证后不能修改。</span>
								<a class="color-main" href="${ctx }/loan/myAccount/toBindBCPage.ht">立即认证</a>
							</li>
						</c:if>

					</ul>
				</div>
	
	<script>
		$(function() {
			$("#sidebar>ul>li:not(:first)>a").hover(
					function() {
						$(this).css("background-color", "#fd8f59");
						var background_position_y = $(this).children("div")
								.css("background-position").split(" ")[1];
						$(this).children("div").css("background-position",
								"-20px " + background_position_y);
					},
					function() {
						var background_position_y = $(this).children("div")
								.css("background-position").split(" ")[1];
						$(this).css("background-color", "#fff9d9");
						$(this).children("div").css("background-position",
								"0px " + background_position_y);
					}).bind("click", function() {
				$(".subsidebar").hide();
				if ($(this).next().css("display") == "none") {
					$(this).next().show();
				} else {
					$(this).next().hide();
				}
				;
			});
		})
	</script>
</body>
</body>
</html>