<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>账户充值</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<script type="text/javascript" src="${ctx}/js/p2p/moneyFormat.js"></script>
  	<script type="text/javascript" src="${ctx}/js/p2p/jquery.formatCurrency-1.4.0.js"></script>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
		<div class="personalData f_l">
		<h3><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">账户充值</h3>
			<div class="PerDataTop">
				<div class="PerDataTopName">
					<p>${TUserFunds.loginName }</p>
					安全等级
					<div class="progressBar" ><div style="width: ${TUserFunds.safebar}"></div></div>
				</div>
				<div class="PerDataTopMoney">
					<div>账户余额 <span>${TUserFunds.balance }元</span></div>
					<span>冻结金额 ${TUserFunds.freeze }元</span><span>可用金额 ${TUserFunds.available }元</span>
				</div>
				<div class="PerDataTopButton">
					<!-- <span class="PerDataTopButton1">充&nbsp;&nbsp;值</span> -->
					<span class="PerDataTopButton2" onclick="drawmoneyAction('${ctx}/crowdfunding/memberCenter/todrawBack.ht');">提&nbsp;&nbsp;现</span>
				</div>
			</div>
			<div class="Recharge">
			<div class="patternPaymentNav">
				<ul>
					<li class="PaPaNavChecked">账户充值</li>
					<li>我的充值记录</li>
				</ul>
			</div>
			<div class="RechargeFlow TagContentList">
				<div class="RechargeFlowList">
					<ul>
						<li class="FlowLi"><span class="FlowSpan1"></span>
							<div>网银或柜台转账到投付宝</div>
							<em>1</em>
						</li>
						<li><span class="FlowSpan2"></span>
							<div>提交充值申请</div>
							<em>2</em>
						</li>
						<li><span class="FlowSpan3"></span>
							<div>平台审核</div>
							<em>3</em>
						</li>
					</ul>
				</div>
				<div class="clear"></div>
				<div class="RechargeNo1">
				<div class="bankFlow">
					<div class="bankImg f_l"><img src="${ctx }/crowdfunding/Skin/Default/images/xinye.png"></div>
					<div class="bankList f_l">
						<ul>
							<li>投付宝官方账号信息：</li>
							<li>开户银行：兴业银行深圳南头支行（广东省深圳市）</li>
							<li>账号：<span>6020&nbsp;3205&nbsp;6503&nbsp;5620&nbsp;368</span></li>
							<li>开户名：深圳市创国网络科技有限公司</li>
						</ul>
					</div>
				</div>
				<div class="RechargePrompt">
					<div>温馨提示：</div>
					<p><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">您可以通过银行柜台或网上银行的形式转账到上面所示的我们在兴业银行托管的投付宝官方账户；</p>
					<p><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">转账时的开户名必须与您在无忧筹众筹平台注册的真实姓名一致；</p>
					<p><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">多次转账必须用同一张卡，以便于退款时保障您资金的安全；</p>
					<p><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">投付宝账户不接收询价认筹诚意金付款，如果您需要获取询价认筹资格，请点击这里。</p>
				</div>
				<div class="RechargeInput"><input type="checkbox" />我已转账到投付宝账户</div>
				<span class="RechargeButton" id="next">下一步</span>
				</div>
				<div class="clear RechargeNo">
					<h4>填写充值金额</h4>
					<div class="RechargeNoLi">
						<ul>
							<li><label>账户余额：</label><span>${TUserFunds.balance }</span>元</li>
							<li><label>充值金额：</label><input type="text" id="rechargeMoney_id" >元</li>
							<li><label>充值费用：</label><span id="chargeMoney_id" >0.00</span>元
							<input type="hidden" name="chargeMoney" id="chargeMoney" value=""/>
              				<input type="hidden" name="token" id="token_id" value="${token }"/></li>
							
							<li><label>实际支付金额：</label><span id="actualPayMent_id">0.00</span>元</li>
						</ul>
					</div>
					<span class="RechargeButton" onclick="rechargeMo();">充&nbsp;&nbsp;值</span>
				</div>
				<div class="clear RechargeHint">
					<div class="hint">请耐心等候平台审核!</div>
				</div>
			</div>
			<div class="TagContentList">
			<iframe src="${ctx }/crowdfunding/memberCenter/toRechargeRecords.ht?projectId=${tcproject.projectId}" style="min-height: 500px;" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height="100%" id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
			</div>
			</div>
		</div>
	<script type="text/javascript">
	$(function(){
		$(".Recharge .TagContentList").eq(0).css("display","block");
		$(".patternPaymentNav li").click(function(){
			  $(this).addClass('PaPaNavChecked').siblings().removeClass('PaPaNavChecked');
			  var _index= $(this).index();
			  $(".Recharge .TagContentList").css("display","none");
			  $(".Recharge .TagContentList").eq(_index).css("display","block");
		});
		$("#next").click(function(){
			$(this).parent().css("display","none");
			$(".RechargeNo").css("display","block");
			$('.RechargeFlowList li').eq(1).addClass("FlowLi");
		});
		
		$("#rechargeMoney_id").bind("change",function(){
  	  	  $('#rechargeMoney_id').formatCurrency();
  	  	$('#rechargeMoney_id').toNumber();
  	  		var rechargeMoney_id=$("#rechargeMoney_id").val();
  	  		var chargeMoney= moneyFormatMUL(rechargeMoney_id,"${TUserFunds.chargeMoneyProportion/100}");
  	  		$("#chargeMoney_id").text(chargeMoney);
  	  		$("#chargeMoney").val(chargeMoney);//手续费
  	  		var actualPayMent=moneySum(rechargeMoney_id,chargeMoney);
  	  		
  	  		$("#actualPayMent_id").text(actualPayMent);
  	});
  	
  	   $("input[id^='rechargeMoney_id']").keydown(function () {  
			    var e = $(this).event || window.event;  
			    var code = parseInt(e.keyCode);  
			    if (code >= 96 &&code <= 105 || code >= 48 && code <= 57 || code == 8||code == 110||code == 190) {  
			        return true;  
			    } else {  
			        return false;  
			    }  
			}); 
		
	});
	
		function rechargeMo(){
	  		//先判断用户有无绑定银行卡
	  		/* var rep=$.ajax({
	  			type:'POST',
	  			url:'${ctx}/loan/myAccount/vali_callBankFunc_save.ht',
	  			data:{rechargeMoey:$("#rechargeMoney_id").val()}
	  		});
	  		rep.done(function(data){
	  			$.ligerDialog.success(data);
	  		});
	  		rep:fail(function(jqXHR, textStatus){
	  			alert(textStatus);
	  			$.ligerDialog.warn(textStatus);
	  		}); */
	  		var rechargeMoney= $("#rechargeMoney_id").val();
	  		if(rechargeMoney==''){
	  			art.dialog("金额不能为空!");
	  			return;
	  		}
	  		
	  		$.ajax({
	  			url:'${ctx}/loan/myAccount/vali_callBankFunc_save.ht?token_id='+$("#token_id").val(),
	  			type : 'post',
	  			data :{rechargeMoey:$("#rechargeMoney_id").val(),chargeMoney_id:$("#chargeMoney_id").text()},
	  			dataType : 'json',
	  			success : function(data,textStatus) {
	  				//console.log(data);
	  					if(data=='请先绑定银行卡!'){
	  						var dialog = art.dialog({
	  						    title: '请先绑定银行卡',
	  						    //width:'300px',top:'100px',height:'200px',
	  							content: "您暂时没有通过审核的绑定银行卡或者您还未绑定银行卡,是否现在就去绑定?",
	  							icon: 'succeed',
	  						    follow: document.getElementById('btn2'),
	  						    ok: function(){
	  						    	location.href='${ctx}/loan/myAccount/toBindBCPage.ht';
	  						    }
	  						}); 
	  					}else{
	  						 art.dialog(data);
	  						$(".RechargeNo").css("display","none");
	  						$(".RechargeHint").css("display","block");
	  						$('.RechargeFlowList li').eq(2).addClass("FlowLi");
	  					}
	  				
	  			},
	  			error : function(jqXHR, textStatus) {
	  				art.dialog(XMLHttpRequest.statusText);
	  			}
	  		});
	  		
	  	}
		
	function iFrameHeight() {
		
	    var ifm= document.getElementById("iframepage");

	    var subWeb = document.frames ? document.frames["iframepage"].document :

			ifm.contentDocument;

	        if(ifm != null && subWeb != null) {

	        ifm.height = subWeb.body.scrollHeight;

	        }

	}
	
	function drawmoneyAction(url){
		window.location = url;
	}
	</script>
</body>
</html>