<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 会员中心</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/MyAccountCenter.css" />" type="text/css">
	<script type="text/javascript">
		if (top != this) {
			//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
			top.location = '${ctx}/index-web.jsp';
		}
	</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="MyAccountCenter" class="ink-grid push-center all-90">
	<div class="column-group horizontal-gutters">
		<div class="all-20">
			<div id="account-center-menu">
				<section class="avatar align-center">
					<c:if test="${empty user.myPhoto }">
						<a href="${ctx}/crowdfunding/upload/uploadHeadPage.ht" target="iframepage"><img src="${ctx}/crowdfunding/resources/img/head_blank.png"></a>
					</c:if>
					<c:if test="${not empty user.myPhoto }">
						<a href="${ctx}/crowdfunding/upload/uploadHeadPage.ht" target="iframepage"><img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${user.myPhoto}"></a>
					</c:if>
					<h4>${user.loginName}</h4>
				</section>
				<dl>
					<c:if test="${user.groupId eq 1 }"><!-- 创业人 -->
					<dt>项目管理：</dt>
					<dd>
						<a class="active" href="${ctx}/crowdfunding/tcuserPersonalData/myAccount.ht" target="iframepage"><i class="fa fa-list"></i> 创业项目管理</a>
						<a href="${ctx}/crowdfunding/projectApply/tprojectApplyList.ht" target="iframepage"><i class="fa fa-cog"></i> 投资人管理</a>
						<%--<a href="${ctx}/crowdfunding/tuser/investorProjectList.ht" target="iframepage"><i class="fa fa-info-circle"></i> 投资人信息</a>--%>
						<a href="${ctx}/crowdfunding/tcprojectAfter/tcprojectAfterCrList.ht" target="iframepage"><i class="fa fa-list-ul"></i> 投后管理</a>
						<a href="${ctx}/tcproject/ProjectComments/ProjectCommentsicList.ht" target="iframepage"><i class="fa fa-comment-o"></i> 项目评论</a>
						<a href="${ctx}/tcproject/ProjectDynamic/ProjectDynamicBackList.ht" target="iframepage"><i class="fa fa-tasks"></i> 项目动态</a>
					</dd>
					</c:if>
					<c:if test="${user.groupId eq 2 }"><!-- 投资人 -->
					<dt>我的项目：</dt>
					<dd>
						<a class="active" href="${ctx}/crowdfunding/front/tcprojectinvest/getProjectLeadAndVote.ht" target="iframepage"><i class="fa fa-list-ol"></i> 项目管理</a>
						<a href="${ctx}/crowdfunding/tcprojectAfter/tcprojectAfterInvestorList.ht" target="iframepage"><i class="fa fa-list-ul"></i> 投后管理</a>
					</dd>
					</c:if>
					<c:if test="${user.groupId eq 2}"><!-- 投资人 -->
					<dt>账户资金管理：</dt>
					<dd>
						<%--<c:choose>
							<c:when test="${empty tuserFunds.payMark }">
								<h5 onclick="window.open('${ctx}/crowdfunding/memberCenter/toPayRegisterPage.ht')"><span class="userIcont11"></span>支付绑定</h5>
							</c:when>
							<c:otherwise>
								<h5 onclick="loadPages('${ctx}/crowdfunding/memberCenter/toPayRegisterPage.ht')"><span class="userIcont11"></span>支付绑定</h5>
							</c:otherwise>
							</c:choose>
							<c:if test="${user.groupId eq 2 || user.groupId eq 1 }"><!-- 投资人 -->
							<h5 onclick="loadPages('${ctx}/crowdfunding/memberCenter/toRechargePage.ht')"><span class="userIcont11"></span>充值</h5>
							<h5 onclick="loadPages('${ctx}/crowdfunding/memberCenter/todrawBack.ht')"><span class="userIcont13"></span>提现</h5>
							</c:if> --%>
						<c:if test="${user.groupId eq 2  }"><!-- 投资人 -->
						<a href="${ctx}/crowdfunding/memberCenter/getUserInverstList.ht" target="iframepage"><i class="fa fa-list-alt"></i> 账户概览</a>
						<%--<a href="${ctx}/loan/myAccount/toBindBCPage.ht"><i class="fa fa-credit-card"></i> 绑定/修改银行卡</a>--%>
						</c:if>
						<a href="${ctx}/crowdfunding/memberCenter/toinvestList.ht" target="iframepage"><i class="fa fa-money"></i> 资金记录</a>
					</dd>
					</c:if>
					<dt>个人资料：</dt>
					<dd>
						<!-- 						<h5 onclick="loadPages('${ctx}/loan/myAccount/toBindBCPage.ht')"><span class="userIcont18"></span>绑定/修改银行卡</h5>
						<h5 onclick="loadPages('${ctx}/safe/bindPhone.ht')"><span class="userIcont19"></span>绑定/修改手机</h5>
						<h5 onclick="loadPages('${ctx}/safe/bindEmail.ht')"><span class="userIcont17"></span>绑定/修改邮箱</h5>
						<h5 onclick="loadPages('${ctx}/safe/safeQuestionInit.ht')"><span class="userIcont20"></span>安全问题</h5>
						<h5 onclick="loadPages('${ctx }/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht')"><span class="userIcont6"></span>修改密码</h5> -->
						<a href="${ctx }/crowdfunding/tcuserPersonalData/myAccount.ht?personal=1" target="iframepage"><i class="fa fa-edit"></i> 修改我的资料</a>
						<c:if test="${user.groupId eq 1 }">
							<a href="${ctx}/user/uploadInfo.ht" target="iframepage"><i class="fa fa-cloud-upload"></i> 上传资料</a>
						</c:if>
						<c:if test="${user.groupId eq 2 }">  <!-- 投资人 -->
							<a href="${ctx}/crowdfunding/memberCenter/toinquiryRecogniz.ht" target="iframepage"><i class="fa fa-star-o"></i> 认投资格</a>
							<a href="${ctx}/user/applyLeaderInit.ht?type=1" target="iframepage"><i class="fa fa-check-circle-o"></i> 申请领投资格</a>
						</c:if>
						<a href="${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht" target="iframepage"><i class="fa fa-shield"></i> 安全中心</a>
					</dd>
					<dt>消息中心：</dt>
					<dd>
						<a href="${ctx}/loan/tuserMsgRemind/sendMessage.ht" target="iframepage"><i class="fa fa-comment"></i> 发送新消息</a>
						<a href="${ctx}/loan/tuserMsgRemind/myInbox.ht?groupId=${user.groupId}" target="iframepage"><i class="fa fa-folder-open"></i> 收件箱</a>
						<a href="${ctx}/loan/tuserMsgRemind/getOutBoxData.ht" target="iframepage"><i class="fa fa-send"></i> 发件箱</a>
					</dd>
				</dl>
			</div>
		</div>
		<div class="all-80">
			<div id="account-center-content">
				<c:choose>
					<c:when test="${forwordUrl eq 'fromProDetail'}">
						<iframe src="${ctx}/loan/myAccount/toBindBCPage.ht" id="iframepage" name="iframepage" width="100%" frameborder="0" scrolling="no" onLoad="iFrameHeight()"></iframe>
					</c:when>
					<c:when test="${forwordUrl eq 'ProManger'}">
						<c:if test="${user.groupId eq 1}">
							<iframe src="${ctx }/crowdfunding/tcuserPersonalData/myAccount.ht" id="iframepage" name="iframepage" width="100%" frameborder="0" scrolling="no" onLoad="iFrameHeight()"></iframe>
						</c:if>
						<c:if test="${user.groupId eq 2}">
							<iframe src="${ctx}/crowdfunding/front/tcprojectinvest/getProjectLeadAndVote.ht" id="iframepage" name="iframepage" width="100%" frameborder="0" scrolling="no" onLoad="iFrameHeight()"></iframe>
						</c:if>
					</c:when>
					<%--资金记录--%>
					<c:when test="${forwordUrl eq 'investRecord'}">
						<iframe src="${ctx}/crowdfunding/memberCenter/toinvestList.ht" id="iframepage" name="iframepage" width="100%" frameborder="0" scrolling="no" onLoad="iFrameHeight()"></iframe>
					</c:when>
					<c:when test="${not empty flag}">
						<iframe src="${ctx}/loan/tuserMsgRemind/myInbox.ht?groupId=${user.groupId}" id="iframepage" name="iframepage" width="100%" frameborder="0" scrolling="no" onLoad="iFrameHeight()"></iframe>
					</c:when>
					<c:when test="${forwordUrl eq 'applyLeader'}">
						<iframe src="${ctx}/user/applyLeaderInit.ht?type=1" id="iframepage" name="iframepage" width="100%" frameborder="0" scrolling="no" onLoad="iFrameHeight()"></iframe>
					</c:when>
					<c:otherwise>
						<iframe src="${ctx }/crowdfunding/tcuserPersonalData/myAccount.ht" id="iframepage" name="iframepage" width="100%" frameborder="0" scrolling="no" onLoad="iFrameHeight()"></iframe>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/MyAccountCenter.js" />"></script>
<%--<script type="text/javascript">--%>
	<%--$(function(){--%>
		<%--var url = '${flag}';--%>
		<%--var groupid = '${user.groupId}';--%>
		<%--if(url){--%>
			<%--url = url.replace('tenderToProject','');--%>
			<%--$("#iframepage").attr("src", "${ctx}/loan/tuserMsgRemind/myInbox.ht?groupId="+groupid);--%>
			<%--$('.Usermenu .userInforTag').css('display','none');--%>
			<%--$('#userInforTag4').parent().find('.userInforTag').css('display','block');--%>
			<%--$('.Usermenu h5').removeClass('userInhover');--%>
			<%--$('#userIcont16').addClass('userInhover');--%>
		<%--}--%>

		<%--var forwordUrl='${forwordUrl}';--%>

		<%--if(forwordUrl!=''&&forwordUrl=='fromProDetail'){--%>
			<%--$(".userIcont3").click();--%>
		<%--}else if(forwordUrl!=''&&forwordUrl=='ProManger'){--%>
			<%--$(".userInhover").click();--%>
		<%--}else if(forwordUrl!=''&&forwordUrl=='investRecord'){--%>

			<%--selZijlinit();--%>
			<%--$(".userIcont12").click();--%>
		<%--}--%>
	<%--});--%>

	<%--var tixianFlag;--%>
	<%--$(function(){--%>
		<%--$('.Usermenu h4').css("cursor","pointer");--%>
		<%--$('.Usermenu h4').click(function(){--%>
			<%--$('.Usermenu .userInforTag').css('display','none');--%>
			<%--$(this).parent().find('.userInforTag').css('display','block');--%>
		<%--});--%>
		<%--$('.Usermenu h5').click(function(){--%>
			<%--$('.Usermenu h5').removeClass('userInhover');--%>
			<%--$(this).addClass('userInhover');--%>
		<%--});--%>
		<%--if(tixianFlag != null && tixianFlag !="" && typeof(tixianFlag) != "undefined")--%>
			<%--selZijlinit();--%>
	<%--})--%>

	<%--/**--%>
	 <%--*提现成功后跳转到资金列表默认选中状态样式设置--%>
	 <%--*/--%>
	<%--function selZijlinit(){--%>
		<%--tixianFlag = 1;--%>
		<%--$('.Usermenu .userInforTag').css('display','none');--%>
		<%--$('.Usermenu h4').parent().find('.userInforTag').eq(1).css('display','block');--%>
		<%--$('.Usermenu h5').removeClass('userInhover');--%>
		<%--$('#userIcont12').addClass('userInhover');--%>
	<%--}--%>
<%--</script>--%>
</body>
</html>