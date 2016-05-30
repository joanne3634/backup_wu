<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title><%=application.getAttribute("PLATFORM_NAME")%> - 个人主页</title>
<%@ include file="/commons/includeFront/javascripts.jsp"%>

</head>
<body>

	<%@ include file="/commons/includeFront/head.jsp"%>
	<div class="container">
		<div class="weizhi-lianjie">
			<a href="${ctx }/index-web.jsp">首页</a> > 
			<a href="javascript:void(0)"
									onclick="loadPages('${ctx }/loan/myAccount/toMyaccount.ht')"> 我的账户</a> > <span>会员后台</span>
		</div>

		<div class="hyht-body">
			<div id="hyht-bodyleft">
				<div id="sidebar">
					<ul>
						<li class="bg-color-l"><a style="color: #fff; font-size: 18px;" href="javascript:void(0)"
							onclick="loadPages('${ctx }/loan/myAccount/toMyaccount.ht')"><div
									style="top: 3px; background-position: -20px 0; background-position: -20px 0;"
									class="bariocn"></div>我的账户</a></li>
									<c:if test="${TUser.groupID eq 1 || TUser.groupID eq 3}">
						<li class="bg-color-s"><a><div style="background-position: 0 -20px;"
									class="bariocn"></div>借款管理</a>
							<ul class="subsidebar">
								<li><a href="javascript:void(0)"
									onclick="loadPages('${ctx}/project/myallinprojects.ht')">我的借款</a></li>
								<li><a href="javascript:void(0)"
									onclick="loadPages('${ctx}/project/myinprojects.ht')">还款管理</a></li>
								<li><a href="javascript:void(0)"
									onclick="loadPages('${ctx}/project/myapprojects.ht')">借款申请查询</a></li>
								<li><a href="javascript:void(0)"
									onclick="loadPages('${ctx}/project/myloanstatistics.ht')">贷款统计</a></li>
							</ul></li>
							</c:if>
							<c:if test="${TUser.groupID eq 2 || TUser.groupID eq 3 }">
						<li class="bg-color-s"><a><div style="background-position: 0 -40px;"
									class="bariocn"></div>理财管理</a>
							<ul class="subsidebar">
								<li><a href="javascript:void(0)"
									onclick="loadPages('${ctx }/loan/myAccount/toMyTender.ht')">我的投标</a></li>
								<li><a href="javascript:void(0)"
									onclick="loadPages('${ctx }/loan/myAccount/toIFocusBorrow.ht')">我关注的借款</a></li>
								<li><a href="javascript:void(0)"
									onclick="loadPages('${ctx }/loan/myAccount/toManagerMoneyCount.ht')">理财统计</a></li>
								<li><a href="javascript:void(0)"
									onclick="loadPages('${ctx }/loan/myAccount/toAutoBidding.ht')">自动投标</a></li>
							</ul></li>
								<li class="bg-color-s"><a><div style="background-position: 0 -120px;"
									class="bariocn"></div>债权转让</a>
							<ul class="subsidebar">
								<li><a href="javascript:void(0)" onclick="loadPages('${ctx }/myAccount/transferback.ht')" >债权转让</a></li>
								<li><a href="javascript:void(0)" onclick="loadPages('${ctx }/myAccount/auctionback.ht')" >债权竞标</a></li> 
							</ul></li>
							</c:if>
						<li class="bg-color-s"><a><div style="background-position: 0 -60px;"
									class="bariocn"></div>资金管理</a>
							<ul class="subsidebar">
								<li><a href="javascript:void(0)" onclick="loadPages('${ctx }/loan/myAccount/rechargePage.ht')">充值</a></li>
								<li><a href="javascript:void(0)" onclick="loadPages('${ctx }/loan/myAccount/toDrawMnPage.ht')">提现</a></li>
								<li><a href="javascript:void(0)" onclick="loadPages('${ctx }/loan/myAccount/moneyRecord.ht')">资金记录</a></li>
							</ul></li>
						<li class="bg-color-s"><a><div style="background-position: 0 -80px;"
									class="bariocn"></div>基本设置</a>
							<ul class="subsidebar">
								<li><a href="javascript:;" onclick="loadPages('${ctx}/user/editUserInfoInit.ht')">编辑个人资料</a></li>
								<li><a href="javascript:;" onclick="loadPages('${ctx}/user/xyhrzziliaoInfo.ht')">新用户认证资料</a></li>
                				<li><a href="javascript:;" onclick="loadPages('${ctx}/user/uploadInfo.ht')">上传资料</a></li>
								<li><a href="javascript:;" onclick="loadPages('${ctx}/myAccount/securityCenter.ht')">安全中心</a></li>
								<li><a href="javascript:;" onclick="loadPages('${ctx}/loan/myAccount/toBindBCPage.ht')">绑定银行卡</a></li>
								<li><a href="javascript:;" onclick="loadPages('${ctx}/safe/bindPhone.ht')">绑定/修改手机</a></li>
								<li><a href="javascript:;" onclick="loadPages('${ctx}/safe/bindEmail.ht')">绑定/修改邮箱</a></li>
								<li><a href="javascript:;" onclick="loadPages('${ctx}/safe/safeQuestionInit.ht')">安全问题</a></li>
								<li><a href="javascript:;" onclick="loadPages('${ctx}/loan/front/changePwdPage.ht')">修改密码</a></li>
							</ul></li>
							<li class="bg-color-s"><a><div style="background-position: 0 -100px;"
									class="bariocn"></div>服务与通知</a> 
									<%
										TUser user =	(TUser)session.getAttribute("user");
									 %>
							<ul class="subsidebar">
								<li><a href="javascript:;"  onclick="loadPages('${ctx}/loan/tuserMsgRemind/MsgReminds.ht?ReceiverId=<%=user.getUserId()%>')">我的通知</a></li>
								 <li><a href="javascript:;"  onclick="loadPages('${ctx}/loan/aboutus/CheckTheRecords.ht?userid=<%=user.getUserId()%>')">我的留言</a></li>
                				<li><a href="javascript:;"  onclick="loadPages('${ctx}/loan/sysManager/usersToReport/MyComplaint.ht?userid=<%=user.getUserId()%>')"> 我的投诉</a></li> 
							</ul></li>
					</ul>
				</div>
				<div style="height: 293px; margin-top: 10px;">
					<img src="${ctx}/images/hyht_pic.png" alt="">
				</div>
			</div>
			<div id="hyht-bodyright">
				<%-- <iframe id="iframe_id" src="${ctx }/loan/myAccount/toMyaccount.ht"
					style="border: none; overflow: hidden;" width="100%"></iframe> --%>
					
			<iframe src="${ctx }/loan/myAccount/toMyaccount.ht" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
			</div>
		</div>
	</div>
	<%@ include file="/commons/includeFront/footer.jsp"%>

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

			$(".jixuwancheng-btn").mouseover(function() {
				$(this).css("opacity", "0.7");
				$(this).children("a").css("opacity", "1");
			}).mouseout(function() {
				$(this).css("opacity", "0");
				$(this).children("a").css("opacity", "0");
			});
		});
	</script>
	<script type="text/javascript">
	
	    function iFrameHeight() {
	
	        var ifm= document.getElementById("iframepage");
	
	        var subWeb = document.frames ? document.frames["iframepage"].document :
	
				ifm.contentDocument;
	
	            if(ifm != null && subWeb != null) {
	
	            ifm.height = subWeb.body.scrollHeight;
	
	            }
	
	    }

		function loadPages(url) {
			$("#iframepage").attr("src", url);
		}
	</script>
</body>

</html>