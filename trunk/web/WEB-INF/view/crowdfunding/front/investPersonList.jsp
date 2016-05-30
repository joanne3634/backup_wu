<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">'
	<title>跟投记录</title>
	<meta name="renderer" content="webkit"/>
   	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
   <script type="text/javascript" src="${ctx }/crowdfunding/js/artdialog/jquery.artDialog.js?skin=default"></script>
   <script type="text/javascript" src="${ctx }/crowdfunding/js/artdialog/iframeTools.js"></script>
</head>
<body>
	<!-- <div style="height:191px;overflow: hidden;">
	</div> -->
	<%@ include file="/crowdfunding/head.jsp"%>
	<div class="window">
		<div class="InPrcontentleft f_l">
			<p class="TopPath">所在位置：首页 > <a href="${ctx }/crowdfunding/front/tofinancingPro.ht">创业项目</a> > <a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${tcproject.projectId }">项目详情</a> > 跟投记录</p>
			<div class="InPrcontentleft_top" style="border:0px;">
				<h3>${tcproject.pname }<span><f:description nodeKey="xmzt" itemValue="${tcproject.pstateId }"/></span></h3>
				<div>发布时间：<span><fmt:formatDate value="${tcproject.popenDate}" pattern="yyyy-MM-dd HH:mm"/></span></div>
			</div>
			 
			<form id="pageForm" name="pageForm" action="">
			<c:if test="${not empty listInV}">
			<h4 class="titlebottom"><span>项目跟投人</span></h4>
			<div class="AndRecordPerson">
				<ul>
				<c:forEach items="${listInV }" var="vo" varStatus="status">
					<li>
						<div class="singlePerson">
							<div class="InPruserimg">
								<c:choose>
						<c:when test="${empty vo.fileId}">
								<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait.png">
							</c:when>
							<c:otherwise>
								<img src="${ctx}/platform/system/sysFile/getFileById.ht?fileId=${vo.fileId}" width="104" height="107" alt="">
							</c:otherwise>
						</c:choose>
							<input type="hidden" id="creator_${status.count }_${status.count }" name="creator" value="${vo.userId}">
							<input type="hidden" id="creatorName_${status.count }_${status.count }" name="creatorName" value="${vo.loginName }">
							<div>+发私信</div>
							</div>
							<div class="abstract">
								<div>${vo.loginName }</div>
								<p>认投时间：${vo.piinvestTimeS }</p>
								<p>投资理由：${vo.pireasons }</p>
							</div>
							<div class="singlemoney">
								<h6>跟投金额</h6>
								<span>${vo.piinvest }万</span>
							</div>
							<div class="clear"></div>
						</div>
					</li>
					</c:forEach>
					
				</ul>
			</div>
			</c:if>
			<input type="hidden" name="projectId" value="${tcproject.projectId }"/>
				<pageTag:paging form="pageForm"/>
			</form>
		</div>
		<div class="InPrcontentright f_l">
		 <h3><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">创业者</h3>
		<div class="InPruser">
			<c:choose>
				<c:when test="${empty tcproject.myPhoto}">
				
				
				
					<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait.png">
				</c:when>
				<c:otherwise>
					<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${tcproject.myPhoto}" width="104" height="107" alt="">
				</c:otherwise>
			</c:choose>
			<div>
				<input type="hidden" id="creator_1" name="creator" value="${tcproject.creator}">
				<input type="hidden" id="creatorName_1" name="creatorName" value="${tcproject.realName }">
			<p>${tcproject.realName }</p>
			<span>+发私信</span>
			</div>
		</div>
		<div class="clear plan">
		<h3><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">融资金额及进度</h3>
			<div class="plantext">
				<h5>融资金额</h5>
				<span>${tcproject.pfinancingAmount }万</span>
			</div>
			<div class="plantext">
				<h5>出让股份</h5>
				<span>
				
				<c:choose>
					<c:when test="${tcproject.psharesPercent eq '0.00'}">
						议价中
					</c:when>
					<c:otherwise>
						${tcproject.psharesPercent } >
					</c:otherwise>
				</c:choose>
				</span>
			</div>
			<div class="clear plantext2">
				<h5>款项拨付方式</h5>
				<span><f:description nodeKey="TZKPT" itemValue="${tcproject.ppayWay }"/></span>
			</div>
			<div class="planUl">
			<ul>
				<li>
					<img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont6.png">
					<div>认投金额</div>
					<span><fmt:formatNumber value="${tcproject.pinvestAmount }" pattern="###,###.##"   minFractionDigits="2" />万</span>
				</li>
				<li>
					<img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont7.png">
					<div>跟投人数</div>
					<a href="${ctx}/crowdfunding/front/toInvestPersonList.ht?projectId=${tcproject.projectId }" 
					style="text-decoration:;"><span>${tcproject.pinvestCount }人</span></a>
				</li>
				<!--<li>
					<img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont8.png">
					<div>询价人数</div>
					<span>${tcproject.paskPriceCount }人</span>
				</li>-->
			</ul>
			</div>
			<div class="clear planNum">
				<div>认投完成率：<span>${tcproject.pcomplete }%</span></div>
			</div>
			<div class="planImg"><div style="width:${tcproject.pcomplete }%;"></div></div>

			<div class="planButton">
				<ul>
					<li class="InIfgoto" onclick="applyLeader11('${isleader}','${isaskPrice}','${tcproject.pleaderId }','${listInvest }');"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont2.png">我要领投</li>
					<li class="yuetan" onclick="aboutEntrepre('${collectProjectInfo.creator}','${collectProjectInfo.projectId}');"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont3.png">约谈创业者</li>
					<li class="gentou" onclick="applyLeader12('${isaskPrice}','${tcproject.pisFull }','${listInvest }','${alreadyLingtou }');"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont4.png">我要跟投</li>
					<li class="collection" onclick="favorite(${tcproject.projectId},${tcproject.creator})">
						<img  src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont5.png">
						收藏该项目
					</li>
				</ul>
			</div>
		</div>
		<input type="hidden" id="projectId" name="projectId" value="${tcproject.projectId}"/>
		</div>
	</div>
	<div class="clear" style="height:130px;overflow: hidden;">
	<%@ include file="/crowdfunding/foot.jsp"%>
	</div>
<script type="text/javascript">
	$(function(){
		$(".InPrtag li").click(function(){
			  $(this).addClass('InPrtagLichecked').siblings().removeClass('InPrtagLichecked');
		});
	})
	$(function(){ 
		$(".abstract a").click(function(){ 
			var _val=$("#creator_0").val();
			$.dialog.open('${ctx}/crowdfunding/tcuserInvestor/tcuserInvestorPageDetails.ht?userId='+_val, {
    			title: '详细资料',lock:true});
		}); 
		$(".InPruser span,.InPruserimg div").click(function(){ 
			var _val=$(this).parent().find("input[name='creator']").val();
			var _id=$(this).parent().find("input[name='creator']").attr("id");
			var projectId=$("#projectId").val();
			var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+_val+'&projectId='+projectId;
			$.dialog.open(url, {
    			title: '发私信',lock:true});
		}); 
	});
	
	$('.collection').click(function(){ 
		$(this).css('background','#b1b1b1');
	}); 
	$(function(){ 
		$(".InPruserlist a").click(function(){ 
			
		//	var _val=$(this).parent().find("input[name='creator']").val();
			
			var _val=$("#creator_2").val();
			$.dialog.open('${ctx}/crowdfunding/tcuserInvestor/tcuserInvestorPageDetails.ht?userId='+_val, {
    			title: '详细资料',lock:true});
		}); 
		$(".InPruser span,.InPruserimg div").click(function(){ 
			valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
			<c:if test="${ not empty TUser }">
			var _val=$(this).parent().find("input[name='creator']").val();
			var _id=$(this).parent().find("input[name='creator']").attr("id");
		//	var _var_name=$(this).parent().find("input[name='creatorName']").val();
			var projectId=$("#projectId").val();
			var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+_val+'&projectId='+projectId+'&type_id=1';
			$.dialog.open(url, {
    			title: '发私信',lock:true});
			</c:if>
		}); 
		
		$(".clear a").click(function(){ 
			
			window.location = "${ctx }/loginWeb.jsp";
		}); 
	});
	
	$(function(){ 
	/* 	$(".InIfgoto").click(function(){
						$.dialog.open('./InquiryIframe.html', {
    			title: '询价认筹',lock:true});
					}); */
					
					
					
		$(".yuetan").click(function(){
			valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
			//1：创业者 2：投资者
		    <c:if test="${TUser.groupId eq 1 }">
				   openDialog("<div class=\"_warning\">对不起， 创业者不能向别的项目发起约谈!</div>",'40%','25%','3');
				return;
			</c:if>
			<c:if test="${ not empty TUser }">
			var _val=$("#creator_1").val();
			var projectId=$("#projectId").val();
			var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+_val+'&projectId='+projectId+'&type_id=2';
			$.dialog.open(url, {
    			title: '约谈创业者',lock:true});
			</c:if>
			/* $.dialog.open('./SendPrivateMessages.html', {
    			title: '',lock:true}); */
		}); 
		
		/* $(".gentou").click(function(){
			$.dialog.open('./InquiryIframe.html', {
	title: '询价认筹',lock:true});
		}); */
		
		/* $('.collection').click(function(){ //收藏
			$(this).css('background','#b1b1b1');
		});  */
	});
	
// 关闭窗口（关闭所有弹出窗口）
	function closediv(){
		$("#faqbg").css("display","none"); 
		$("#faqdiv").css("display","none"); 
		$("#faqdiv2").css("display","none");
		
		$("#content_id").val("");
		$("#valiCode_").val("");
	}
	
	function favorite(proId,creator){
		//1：创业者 2：投资者
	    <c:if test="${TUser.groupId eq 1 }">
			   openDialog("<div class=\"_warning\">对不起，只有投资人才能收藏项目!</div>",'40%','25%','3');
			return;
		</c:if>
		<c:if test="${TUser.groupId eq 1 }">
			openDialog("亲，您不是投资用户，收藏了也没有用哦，请先申请投资用户账号!",'40%','25%','3');
			return;
		</c:if>
	    $.ajax({
			url : "${ctx}/crowdfunding/front/favorite.ht",
			type : 'post',
			data : 'projectId=' + proId + '&Creator=' + creator
			,
			dataType : 'html',
			success : function(data, status) {
				if(eval(data)==eval('0')){
					window.location = "${ctx }/loginWeb.jsp";
				}else if(eval(data)==eval('1')){
					openDialog("收藏成功!",'40%','25%','3');
					send_message_submit();
				}else if(eval(data)==eval('2')){
					openDialog("你已经收藏过该项目了!",'40%','25%','3');
				}
			},
			error : function(xhr, textStatus, errorThrown) {
			}
		});
	}

	function send_message_submit(){
		$.ajax({
			url : "${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht",
			type : 'post',
			data : $('#sendForm').serialize(),
			dataType : 'json',
			success : function(data,textStatus) {
				//alert("信息发送成功:"+data);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				//art.dialog("信息发送失败");
			}
		});
	}
	function sendTalkmsg(proId){
		var commentConten_id=$("#commentConten_id").val();
		if(commentConten_id==''){
			$("#_pinglunjinggao").show();
			return;
		}
		
		
		  $.ajax({
				url : "${ctx}/crowdfunding/front/sendTalkmsg.ht",
				type : 'post',
				data : 'projectId=' + proId + '&commentConten=' + commentConten_id
				,
				dataType : 'html',
				success : function(data, status) {
					if(eval(data)==eval('0')){
						window.location = "${ctx }/loginWeb.jsp";
					}else if(eval(data)==eval('1')){
						openDialog("发表成功!");
						
						 var url="${ctx }/crowdfunding/front/toProComment.ht?projectId="+proId;
						  $("#iframepage").attr("src", url);
						 // window.parent.document.getElementById('iframepage')
						//  $('#iframepage', window.parent.document).attr("src", url);
					}else {
						openDialog("操作异常!");
					}
				},
				error : function(xhr, textStatus, errorThrown) {
				}
			});
	}
	
	function successFun(proId){
		openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">回复成功!</div>",'40%','25%','2');
		var url="${ctx }/crowdfunding/front/toProComment.ht?projectId="+proId;
		  $("#iframepage").attr("src", url);
	}
	
	function applyLeader11(isleader,isaskPrice,leaderId,isgentou){//我要领投
		
		//先判断用户是否登录
		valiLoginTimeout('iframe');
		<c:if test="${ not empty TUser }">
		//判断项目是否已经有领投人了
		if(leaderId!='0'||leaderId!=0){
			openDialog("<div class=\"_warning\">该项目已经有领投人了,一个项目只能有一个领投人!</div>",'40%','25%','3');
			return;
		}
		//1：创业者 2：投资者
	    <c:if test="${TUser.groupId eq 1 }">
			   openDialog("<div class=\"_warning\">只有投资人才能进行领投!</div>",'40%','25%','3');
			return;
		</c:if>
		//先判断用户有无领投资格.
		if(eval(isleader)==0){
			var message_info = "";
			<c:if test="${TUser.groupId eq  2}">
					message_info = "</div><li class=\"_libtn\" onclick=\"toApplyLeaderPage()\">申请领投资格</li>";
			</c:if>
			//无,发起领投人申请
			openDialog("<div class=\"_warning\">只有领投人才能进行领投!"+message_info,'40%','25%','4');
		}else{
			
			//判断用户是否有询价认投资格
			if(eval(isaskPrice)==0){
				window.parent.location='${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht';
			}
			//判断用户是否已经对该项目跟投
			if(isgentou=='1'||isgentou==1){//已经跟投过项目,到追加项目资金
				//openDialog("<div class=\"_warning\">您已经跟投该项目了,不能对该项目领投!</div>",'40%','25%','3');
				applyLeader12('${isaskPrice}','${tcproject.pisFull }','${listInvest }','${alreadyLingtou }');//return;
			}
			else{
				
				 var url='${ctx }/crowdfunding/front/openinquiryIframe.ht?piisLeader=1&projectId='+$("#projectId").val();
				//有,发起项目领投申请,
				$.dialog.open(url, {
	    			title: '询价认筹',lock:true});
			}
			
		}
		</c:if>
	}
	
	function applyLeader12(isaskPrice,pisFull,isgentou,alreadyLingtou){
		//先判断用户是否登录
		valiLoginTimeout('iframe');
		<c:if test="${ not empty TUser }">
		//判断项目是否已经满标 满标就不能再跟投了
		if(eval(pisFull)==1||pisFull=='1'){
			openDialog("<div class=\"_warning\">该项目已融资完成，不能再接受投资了！</div>",'40%','25%','3');
			return;
		}
		//1：创业者 2：投资者
	    <c:if test="${TUser.groupId eq 1 }">
			   openDialog("<div class=\"_warning\">只有投资人才能进行跟投!</div>",'40%','25%','3');
			return;
		</c:if>
		//判断用户是否有询价认投资格
		if(eval(isaskPrice)==0){//没有询价认投资格
			window.parent.location='${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht';
		}else{
			//判断用户是否已经做了该项目的领投人
			/* if(alreadyLingtou=='1'||alreadyLingtou==1){
				openDialog("<div class=\"_warning\">你已经领投该项目了,</div>",'40%','25%','3');
				return;
			} */
			
			//判断用户是否已经跟投过一次(未被创业者拒绝),如果有,则第二次跟投 只能是在第一次跟投基础上,追加 跟投资金
			if(isgentou=='1'||isgentou==1){//已经跟投过项目,到追加项目资金
				var url='${ctx }/crowdfunding/front/addtoInvestMoney.ht?projectId='+$("#projectId").val();
				//有,发起项目跟投申请,
				$.dialog.open(url, {
	    			title: '询价认筹   追加跟投资金',lock:true});
			}else{
				 var url='${ctx }/crowdfunding/front/openinquiryIframe.ht?piisLeader=0&projectId='+$("#projectId").val();
				//有,发起项目跟投申请,
				$.dialog.open(url, {
	    			title: '询价认筹',lock:true});
			}
		}
		</c:if>
	}
	
	function toApplyLeaderPage(){
		window.parent.location='${ctx}/loan/myAccount/myaccountPage.ht?forwordUrl=applyLeader';
	}
	</script>
</body>
</html>
