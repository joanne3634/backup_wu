<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>

	<title><%=application.getAttribute("PLATFORM_NAME")%> - 会员中心</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
  	  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>


	<script type="text/javascript"> 
	
	 $(function(){ 
		  var url = '${flag}';
		  var groupid = '${user.groupId}';
		  if(url){
				  url = url.replace('tenderToProject','');
				  $("#iframepage").attr("src", "${ctx}/loan/tuserMsgRemind/myInbox.ht?groupId="+groupid);
					$('.Usermenu .userInforTag').css('display','none');
					$('#userInforTag4').parent().find('.userInforTag').css('display','block');
					$('.Usermenu h5').removeClass('userInhover');
					$('#userIcont16').addClass('userInhover');
		  }
		  
		  var forwordUrl='${forwordUrl}';
		  
		  if(forwordUrl!=''&&forwordUrl=='fromProDetail'){
			  $(".userIcont3").click();
		  }else if(forwordUrl!=''&&forwordUrl=='ProManger'){
			  $(".userInhover").click();
		  }else if(forwordUrl!=''&&forwordUrl=='investRecord'){
			  selZijlinit();
			  $(".userIcont12").click();
		  }
		  
		  
		  
	  });
	 
	var tixianFlag;
	$(function(){
		$('.Usermenu h4').css("cursor","pointer");
		$('.Usermenu h4').click(function(){
			$('.Usermenu .userInforTag').css('display','none');
			$(this).parent().find('.userInforTag').css('display','block');
		});
		$('.Usermenu h5').click(function(){
			$('.Usermenu h5').removeClass('userInhover');
			$(this).addClass('userInhover');
		});
		if(tixianFlag != null && tixianFlag !="" && typeof(tixianFlag) != "undefined")
			selZijlinit();
	})
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
		/**
		*提现成功后跳转到资金列表默认选中状态样式设置
		*/
		function selZijlinit(){
			tixianFlag = 1;
			$('.Usermenu .userInforTag').css('display','none');
			$('.Usermenu h4').parent().find('.userInforTag').eq(1).css('display','block');
			$('.Usermenu h5').removeClass('userInhover');
			$('#userIcont12').addClass('userInhover');
		}
		function clickMenu(id){
			if(id=='userIcont12'){
				
			selZijlinit();
			  $("."+id).click();
			}else{
			  $("."+id).click();
			}
		}
	</script>
<body >
	<!-- <div style="height:191px;overflow: hidden;">
	</div> -->
	<%@ include file="/crowdfunding/head.jsp"%>
	<div class="window">
		<div class="Usermenu f_l">
			<ul>
			
			
				<li>
				<div class="Usermessage" >
					<c:if test="${empty user.myPhoto }">
						<img onclick="loadPages('${ctx }/crowdfunding/upload/uploadHeadPage.ht')" src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">
					</c:if>
					<c:if test="${not empty user.myPhoto }">
						<img onclick="loadPages('${ctx }/crowdfunding/upload/uploadHeadPage.ht')" src="${ctx }/crowdfunding/upload/getFileById.ht?path=${user.myPhoto}" width="94" height="94">
					</c:if>
					<p>${user.loginName }</p>
					<span style="cursor: pointer;" class="userIcont1" title="绑定手机" onclick="loadPages('${ctx}/safe/bindPhone.ht')"></span>
					<span style="cursor: pointer;" class="userIcont2" title="绑定邮箱" onclick="loadPages('${ctx}/safe/bindEmail.ht')"></span>
					<span style="cursor: pointer;" class="userIcont3" title="绑定银行卡" onclick="loadPages('${ctx}/loan/myAccount/toBindBCPage.ht')"></span>
					</div>
				</li>
				<c:if test="${user.groupId eq 1 }"><!-- 创业人 -->
					<li>
					<h4>项目管理</h4>
					<div  class="userInforTag" style="display:block;">
						<h5 onclick="loadPages('${ctx }/crowdfunding/tcuserPersonalData/myAccount.ht')" class="userInhover"><span class="userIcont9"></span>创业项目管理</h5>
						<h5 onclick="loadPages('${ctx }/crowdfunding/projectApply/tprojectApplyList.ht')"><span class="userIcont21"></span>项目设置</h5>
						<h5 onclick="loadPages('${ctx }/crowdfunding/tuser/investorProjectList.ht')"><span class="userIcont7"></span>投资人信息</h5>
						<h5 onclick="loadPages('${ctx }/crowdfunding/tcprojectAfter/tcprojectAfterCrList.ht')"><span class="userIcont10"></span>投后管理</h5>
						<h5 onclick="loadPages('${ctx }/tcproject/ProjectComments/ProjectCommentsicList.ht')"><span class="userIcont22"></span>项目评论</h5>
						<h5 onclick="loadPages('${ctx}/tcproject/ProjectDynamic/ProjectDynamicBackList.ht')"><span class="userIcont23"></span>项目动态</h5>								
					</div>	
					</li>
					</c:if>
				<c:if test="${user.groupId eq 2 }"><!-- 投资人 -->
					<li>
					<h4>我的项目</h4>
					<div  class="userInforTag" style="display:block;">
						<h5 onclick="loadPages('${ctx}/crowdfunding/front/tcprojectinvest/getProjectLeadAndVote.ht')" class="userInhover"><span class="userIcont9"></span>项目管理</h5>
						<h5 onclick="loadPages('${ctx }/crowdfunding/tcprojectAfter/tcprojectAfterInvestorList.ht')"><span class="userIcont7"></span>投后管理</h5>
					</div>
					</li>
				</c:if>
				<c:if test="${user.groupId eq 2 || user.groupId eq 1}"><!-- 投资人 -->
					<li>
					<h4 >账户资金管理</h4>
					<div  class="userInforTag"  style="display: none;">
						<%-- <c:choose>
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
						<h5 onclick="loadPages('${ctx}/crowdfunding/memberCenter/getUserInverstList.ht')"><span class="userIcont11"></span>账户概览</h5>
						<h5 onclick="loadPages('${ctx}/loan/myAccount/toBindBCPage.ht')"><span class="userIcont18"></span>绑定/修改银行卡</h5>
						</c:if>
						<c:if test="${user.groupId eq 1  }"><!-- 创业者 -->
						
						</c:if>
					    <h5 onclick="loadPages('${ctx}/crowdfunding/memberCenter/toinvestList.ht')" id="userIcont12"><span class="userIcont12"></span>资金记录</h5>
					</div>
					</li>
				</c:if>
				<li>
					<h4>个人资料</h4>
					<div  class="userInforTag" style="display: none;">
						<h5 onclick="loadPages('${ctx }/crowdfunding/tcuserPersonalData/myAccount.ht?personal=1')"><span class="userIcont4"></span>修改我的资料</h5>
						<h5 onclick="loadPages('${ctx}/user/uploadInfo.ht')"><span class="userIcont5"></span>上传资料</h5>
						<c:if test="${user.groupId eq 2 }">  <!-- 投资人 -->
							<h5 onclick="loadPages('${ctx}/crowdfunding/memberCenter/toinquiryRecogniz.ht')"><span class="userIcont14"></span>认筹资格</h5>
							<h5 onclick="loadPages('${ctx}/user/applyLeaderInit.ht')"><span class="userIcont7"></span>申请领投资格</h5>				
						</c:if>
						<h5 onclick="loadPages('${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht')"><span class="userIcont20"></span>安全中心</h5>
						
						
<!-- 						<h5 onclick="loadPages('${ctx}/loan/myAccount/toBindBCPage.ht')"><span class="userIcont18"></span>绑定/修改银行卡</h5>
						<h5 onclick="loadPages('${ctx}/safe/bindPhone.ht')"><span class="userIcont19"></span>绑定/修改手机</h5>
						<h5 onclick="loadPages('${ctx}/safe/bindEmail.ht')"><span class="userIcont17"></span>绑定/修改邮箱</h5>
						<h5 onclick="loadPages('${ctx}/safe/safeQuestionInit.ht')"><span class="userIcont20"></span>安全问题</h5>
						<h5 onclick="loadPages('${ctx }/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht')"><span class="userIcont6"></span>修改密码</h5> -->
					</div>
				</li>
				<li>
					<h4>消息中心</h4>
					<div  class="userInforTag" id="userInforTag4" style="display: none;">
						<h5 onclick="loadPages('${ctx}/loan/tuserMsgRemind/sendMessage.ht')"><span class="userIcont15"></span>发送新消息</h5>
						
						<c:if test="${user.groupId eq 2 }"><!-- 投资人 -->
							<h5 onclick="loadPages('${ctx}/loan/tuserMsgRemind/myInbox.ht?groupId=2')" id="userIcont16"><span class="userIcont16"></span>收件箱</h5>
						</c:if>
						<c:if test="${user.groupId eq 1 }"><!-- 创业人 -->
							<h5 onclick="loadPages('${ctx}/loan/tuserMsgRemind/myInbox.ht?groupId=1')" id="userIcont16"><span class="userIcont16"></span>收件箱</h5>
						</c:if>
						<h5 onclick="loadPages('${ctx}/loan/tuserMsgRemind/getOutBoxData.ht')"><span class="userIcont17"></span>发件箱</h5>
					</div>
						

				</li>									
			</ul>
		</div>
		<div class="iframediv f_l">
			<c:choose>
				<c:when test="${forwordUrl eq 'applyLeader'}">
					<iframe src="${ctx}/user/applyLeaderInit.ht" id="iframepage" name="iframepage" width="100%" frameborder="0" scrolling="no" onLoad="iFrameHeight()"></iframe>
				</c:when>
				<c:otherwise>
					<iframe src="${ctx }/crowdfunding/tcuserPersonalData/myAccount.ht" id="iframepage" name="iframepage" width="100%" frameborder="0" scrolling="no" onLoad="iFrameHeight()"></iframe>		
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="clear" style="height:130px;overflow: hidden;">
		<%@ include file="/crowdfunding/foot.jsp"%>
	</div>

	<script type="text/javascript">
	  $(function(){
		  //window.location ="${ctx}/crowdfunding/front/tcprojectinvest/getProjectLeadAndVote.ht";
	  })
	</script>
</body>
</html>
