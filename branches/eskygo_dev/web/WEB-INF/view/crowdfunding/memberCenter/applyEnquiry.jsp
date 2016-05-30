<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags/helpers"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 缴纳诚意金</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/applyEnquiry.css" />" type="text/css">
	<script type="text/javascript">
		if (top != this) {
			//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
			top.location = '${ctx}/index-web.jsp';
		}
	</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="applyEnquiry" class="ink-grid push-center all-70">
	<div class="column-group horizontal-gutters">
		<form action="${ctx }/crowdfunding/front/tcprojectinvest/toPayment2.ht" method="post" id="sendForm" class="ink-form">
			<fieldset>
				<div class="upDiv all-100">
					<div class="title">
						<h3><i class="fa fa-credit-card"></i> 申请项目认投资格 </h3>
					</div>
					<div class="upContent">
						<div class="applyMoney">
							缴纳项目认投诚意金：<span>${askPrice }</span> 元</div>
						<div class="noticeInfo">
							<p class="tips">温馨提示：</p>
							<p>缴纳认投诚意金${askPrice }元后，您可以获得在平台的认投项目机会，只要您不反悔，您的项目认投资格永久有效！</p>
							<p>出现下面任一情况，属于投资人反悔：</p>
							<p>① 投资人认投成功后，又要求取消认投的；</p>
							<p>② 众筹期满，投资人仍未完成投资款实缴的。</p>
						</div>
					</div>
				</div>
				<div class="downDiv all-100">
					<div class="ink-tabs top">
						<ul class="tabs-nav">
							<li class="active" id="onLinePay"><a class="tabs-tab" href="javascript:;">网银在线支付</a></li>
							<li id="offLinePay"><a class="tabs-tab" href="javascript:;">线下付款方式</a></li>
						</ul>
						<div class="tabs-content onLinePay">
							<c:if test="${not empty list }">
								<div class="control-group required" data-rules="atLeastOne">
									<div class="column-group horizontal-gutters" id="RadioList">
										<c:forEach items="${list }" var="vo" varStatus="i">
											<div class="xlarge-20 large-25 medium-33 small-50 tiny-100">
												<div class="control voRadio ">
													<label>
														<input type="radio" name="defaultbank" checked value="${vo.bankCode}${iscompany}">
														<img src="${contentUrl}/wuyouchou/system/sysFile/getFileById.ht?fileId=${vo.filesIds}">
													</label>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
								<div class="control-group gutters button_submit">
									<label class="all-25 align-right">&nbsp;</label>
									<div class="control all-50 aligin-center">
										<input id="submitBtn" class="ink-button blue-dark" type="submit" value="去 付 款">
									</div>
								</div>
							</c:if>
							<c:if test="${empty list }">
								<div>暂无内容!</div>
							</c:if>
						</div>
						<div class="tabs-content offLinePay" style="display:none;">
							<div class="ApEnListdiv">
								<p>① 您可以通过银行网银或者柜台转账的方式把钱汇入下面账号，汇款时请务必备注说明你在无忧筹注册的登录名；</p>
								<p>② 我们收到您的汇款后，将会在两个工作日内赋予您认筹资格；</p>
								<p>③ 下面民生银行账户为无忧筹认筹诚意金账户，如有疑问，请致电客服电话：4008885568。</p>
							</div>
							<div class="newNotice">
								<p>开户银行：中国民生银行深圳红岭支行</p>
								<p>开户账号：608028262</p>
								<p>开户名：深圳市无忧筹科技服务有限公司</p>
							</div>
						</div>
					</div>
				</div>
			</fieldset>

			<input type="hidden" id="balance" name="balance" value="${userfund.balance}"/>
			<input type="hidden" id="defaultbank" name="defaultbank" value=""/>
			<input type="hidden" id="pinvestAmount" name="pinvestAmount" value="${askPrice}"/>
		</form>
	</div>
</div>

<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/payment.js" />"></script>
</body>
</html>