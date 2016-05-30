<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.deelon.core.util.AppUtil" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>投资详情</title>
  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
</head>

<body>
	<div class="top">
	<div class="fintop"></div>
	</div>

	<div class="content">
		<div class="contentList">
			<p class="pname2  text-black">${pdv.pName}</p>
			<div class="details text-center">
			<ul class="text-gray">
				<li class="boderright">
					<div >借款金额</div>
					<div class="text-orange2">${pdv.loan}元</div>
				</li>
				<li class="boderright">
					<div >年化收益率</div>
					<div class="text-green">${pdv.rateOut}%</div>
				</li>
				<li>
					<div >借款时间</div>
					<div class="text-black2">${pdv.deadline}个月</div>
				</li>
				<li class="boderright">
					<div >还款方式</div>
					<div class="text-black2">
						<c:choose>
							<c:when test="${pdv.repayWay eq 1}">一次性还本付息</c:when>
							<c:when test="${pdv.repayWay eq 2}">按月付息,到期还本</c:when>
							<c:when test="${pdv.repayWay eq 3}">等额本息,每月还款</c:when>
							<c:otherwise>等额本金,每月还款</c:otherwise>
						</c:choose>
					</div>
				</li>
				<li class="boderright">
					<div >完成<span class="text-green">${pdv.complete}%</span></div>
					<div class="text-black2">${pdv.loanReal}元</div>
				</li>
				<li>
					<div >剩余时间</div>
					<div class="text-black2">6天20小时</div>
				</li>
			</ul>
			
			</div>
			<div class="clear"></div>
		</div>
		<div class="detailsform">
			<div class="deformname text-green">我要投资</div>
			<div class="deformNo text-orange2 text-right">可用金额：<span id="currenMo_id">${pdv.canUseLoan}</span>元</div>
		<div class="clear"></div>
			<input type="text" id="input_id" class="deforminout text-black bodersolid background2" onblur="changeRepay();" placeholder="输入投资金额，还需${pdv.payLoan}元"/>
		<div class="text-green">还款完成后，可收益：<span id="repayWay"></span>元</div>
		<input type="hidden" name="token" id="token_id" value="${token }"/>
		<div class="textdiv background1 text-white text-center lbutton" onclick="submit_Inverst('${pdv.projectId}','${pdv.pminInvest }');">确认投资</div>
		</div>

		<div class="detailsbutton text-center">
			<div class="text-white background1" id="detailsbutton1">借款信息</div>
			<div class="text-gray background3" id="detailsbutton2">投标记录</div>
		</div>
		<div class="clear"></div>
		<div class="information">
			<div class="text-green">借款人认证</div>
			<div class="text-center text-orange2">
				<ul>
					<li>
						<div class="informationimg"><img src="${ctx}/styles/dlweixin/image/detailsIcont1.png"></div>
						<div>身份证</div>
						<img src="${ctx}/styles/dlweixin/image/okicont.png">
					</li>
					<li>
						<div class="informationimg"><img src="${ctx}/styles/dlweixin/image/detailsIcont2.png"></div>
						<div>手机</div>
						<img src="${ctx}/styles/dlweixin/image/okicont.png">
					</li>
					<li>
						<div class="informationimg"><img src="${ctx}/styles/dlweixin/image/detailsIcont3.png"></div>
						<div>收入</div>
						<img src="${ctx}/styles/dlweixin/image/okicont.png">
					</li>
					<li>
						<div class="informationimg"><img src="${ctx}/styles/dlweixin/image/detailsIcont4.png"></div>
						<div>车产</div>
						<img src="${ctx}/styles/dlweixin/image/okicont.png">
					</li>
					<li>
						<div class="informationimg"><img src="${ctx}/styles/dlweixin/image/detailsIcont5.png"></div>
						<div>房产</div>
						<img src="${ctx}/styles/dlweixin/image/okicont.png">
					</li>
					<li>
						<div class="informationimg"><img src="${ctx}/styles/dlweixin/image/detailsIcont6.png"></div>
						<div>工作</div>
						<img src="${ctx}/styles/dlweixin/image/okicont.png">
					</li>
				</ul>
			</div>
			<div class="text-green">借款人信息</div>
			<div class="information2 text-gray">
				<div>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：<span class="text-black2">男</span></div>
				<div>年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄：<span class="text-black2">
					<c:if test="${ empty pdv.age }">--</c:if>
					<c:if test="${ not empty pdv.age }">${pdv.age }岁</c:if>
				</span></div>
				<div>学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历:<span class="text-black2">
					<c:if test="${ empty pdv.edu }">--</c:if>
					<c:if test="${ not empty pdv.edu }">${pdv.edu }</c:if>
				</span></div>
				<div>工作时间:<span class="text-black2">
					<c:if test="${ empty pdv.workTime }">--</c:if>
					<c:if test="${ not empty pdv.workTime }">${pdv.workTime }年</c:if>
				</span></div>
				<div>工作城市:<span class="text-black2">
					<c:if test="${ empty pdv.workCity }">--</c:if>
					<c:if test="${ not empty pdv.workCity }">${pdv.workCity }</c:if>
				</span></div>
				<div>是否结婚:<span class="text-black2">
					<c:if test="${ empty pdv.marriage }">--</c:if>
					<c:if test="${ not empty pdv.marriage }">${pdv.marriage }</c:if>
				</span></div>
			</div>
			<div class="text-green">借款描述</div>
			<div class="describe text-gray">
				${pdv.proDesc }
			</div>
		</div>


		<div class="bidRecords text-gray">
		<div class="bidRecordsname text-center">
			<div>投资人</div>
			<div>投资金额</div>
			<div>投资时间</div>
		</div>
		<div class="clear"></div>
			<div class="bidRecordslist text-center">
				<ul>
				<c:forEach items="${ListPro }" var="pro">
					<li class="borderdashed">
						<div><img src="${ctx}/styles/dlweixin/image/detailsIcont7.png">${pro.realName }</div>
						<div><img src="${ctx}/styles/dlweixin/image/rmbicont.png">${pro.piAmount }元</div>
						<div>${pro.piBidTimeStr }</div>
						<div class="clear"></div>
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
</body>

<script type="text/javascript">
	$(function(){
		 $('.detailsbutton').on('click','div',function(){
		 	var index=$(this).index();
		 	if(index==0){
		 		$("#detailsbutton1").removeClass("text-gray background3").addClass("text-white background1");
		 		$("#detailsbutton2").removeClass("text-white background1").addClass("text-gray background3");
		 		$(".information").css("display","block");
		 		$(".bidRecords").css("display","none");
		 	}else{
		 		$("#detailsbutton2").removeClass("text-gray background3").addClass("text-white background1");
		 		$("#detailsbutton1").removeClass("text-white background1").addClass("text-gray background3");
		 		$(".information").css("display","none");
		 		$(".bidRecords").css("display","block");
		 	}
		 });
	});
	
	//输入投资金额时，算出利息
	function changeRepay(){
		var ploanT =$("#input_id").val();
		var prateInT ="${pdv.rateOut}";
		var pdeadlineT ="${pdv.deadline}";
		if(ploanT==""||prateInT==""||pdeadlineT==""){
		  return;
		}
		var repayType = "${pdv.repayWay}";//alert(repayType);
		//alert(ploanT + "--" + prateInT + "--" + pdeadlineT + "--" + repayType);
		if(1==repayType){
			//$("#repayWay").html(1);
			$("#repayWay").html((parseFloat(ploanT)*parseFloat(prateInT)*parseInt(pdeadlineT)/1200).toFixed(2));
		}else if(2==repayType){
			//$("#repayWay").html(2);
			$("#repayWay").html((parseFloat(ploanT)*parseFloat(prateInT)*parseInt(pdeadlineT)/1200).toFixed(2));
		}else if(3==repayType){
			//$("#repayWay").html(3);
			$("#repayWay").html((parseInt(pdeadlineT)*parseFloat(ploanT)*parseFloat(prateInT)/1200*(Math.pow(parseFloat(prateInT)/1200+1,parseInt(pdeadlineT)))/(Math.pow(parseFloat(prateInT)/1200+1,parseInt(pdeadlineT))-1)-parseFloat(ploanT)).toFixed(2));
		}else{
			//$("#repayWay").html(4);
			$("#repayWay").html(((parseFloat(ploanT)*parseFloat(prateInT)/1200+parseFloat(ploanT)/parseInt(pdeadlineT)*parseFloat(prateInT)/1200)*parseInt(pdeadlineT)/2).toFixed(2));
		}
	}

	//确认投资保存方法
	function submit_Inverst(proId, pminInvest) {

		var inputEl = $("#input_id"), defVal = inputEl.val();

	    if (eval(defVal) < pminInvest) {
			alert('每次投标至少' + pminInvest + '元');
			return;
		}
		if (eval(defVal) == 0 || "" == defVal || null == defVal) {
			alert("不可输入0元，不能为空！");
			return;
		}
		var currenMo_id = $("#currenMo_id").html();

		if (eval(defVal) > eval(currenMo_id)) {
			alert("输入金额大于你的可用金额！");
			return;
		}
		var payLoan_id = "${pdv.payLoan}";
		if (eval(defVal) > eval(payLoan_id)) {
			alert("您最多能投资" + payLoan_id + "元!");
			inputEl.val('每次投标至少' + pminInvest + '元');
			return;
		}

		$.ajax({
			url : "${ctx}/weixin/wxfinancing/bidProject.ht",
			type : 'post',
			data : 'loan=' + defVal + '&projectId=' + proId+'&token_id='+$("#token_id").val(),//+'&currenMo_id='+currenMo_id+"&payLoan_id="+payLoan_id,
			dataType : 'html',
			success : function(data, status) {
				if (status == "success") {
					alert('投标成功');
					location.href = "${ctx }/weixin/wxfinancing/wxfinancingPage.ht";
				}
			},
			error : function(xhr, textStatus, errorThrown) {
			}
		});
	}
</script>
</html>