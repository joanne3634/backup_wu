<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%@ include file="/commons/includeFront/javascripts.jsp"%>
	<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/transferback.css">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 债权竞拍</title>
</head>
 
<body>

 	<%@ include file="/commons/includeFront/head.jsp"%>
	<div class="window text-gray">
		<h2 class="text-orange">债权竞拍</h2>
		<div class="auctionLeft">
			<img src="${ctx }/images/auction.png">
		</div>
		<div class="auctionRight">
			<div class="auctionList">
				<div>您的帐户总额：<span>${total}</span> 元  <div class="recharge">充值</div></div>
				<div>您的可用余额：<span>${canUse}</span> 元  </div>
				<div class="auctionList1">债权总额：<span id="price">${loanTotal}</span> 元  </div>
				<div>拍卖底价：<span id="priceLow">${priceLow}</span> 元  </div>
				<div>已出最高价：<label id="highestPrice" >${highestPrice}</label><c:if test="${type == 2}">暗拍价格不显示 </c:if></div>
			</div>
			<div class="auctionNo">请填写并确认下面竞拍金额</div>
			<div class="auctioninput">
				<ul>
					<li><div>竞拍金额：</div>
					<input type="text" id="offerPrice" onblur="checkTransfer()" onkeyup="num(this)"/>元
					</li>
					<li><div>交易密码：</div>
						<input type="password" id="transferpwd" /> <span><a href="${ctx }/safe/wangjimimapage.ht">忘记密码？</a></span>
					</li>
					<li><div>验证码：</div>
					<input type="text" id="validCode" name="validCode" onkeydown="login_form_submit_Enterevent(event)"><img
							 src="${ctx}/servlet/ValidCode" id="validImg" alt="" onclick="reload()" style="cursor: pointer;"/><a class="font-color"   onclick="reload()" style="cursor: pointer;">看不清，换一个</a>
						<br><div id="codeErrMsg" style="color:red;font-size:12px;"></div>
					</li>
				</ul>
			</div>
			<div class="text-gray2">注意：点击按钮表示您将确认投竞拍金额并同意支付。</div>
			<input type="hidden" id="transferId" value="${transferId}">
			<input type="hidden" id="type" value="${type}">
		</div>
		<div class="clear"></div>
		<div class="submit2" onclick="sumbmitAction()">确定购买</div>
	</div>
	 <%@ include file="/commons/includeFront/footer.jsp"%>
	 <script type="text/javascript">
	 function num(th){
		  var reg = /^[0-9]{0}([0-9]|[.])+$/;
	      if(reg.test(th.value)!=true){th.value="";}
	  }
	 	function checkTransfer(){
	 		if("${type}"=="2"){
	 			$.ajax({
					type: "post",
					url: "${ctx}/myAccount/checkTransferAction.ht",
					data:{transferId:$("#transferId").val(),type:$("#type").val()},
					dataType:"json",
					success: function(json){
						 if(json.result){
							 alert(json.result);
						 }
					}
				});
	 		}else{
	 			if(parseFloat($("#offerPrice").val())<parseFloat("${highestPrice}")){
	 				alert("明标的目前最高价为${highestPrice}，竞标请超过最高价才能提交成功。");
	 			} 
	 		}
	 		
	 	}
	 	
	 	function sumbmitAction(){
	 		if("${sessionScope.user.groupID}"=='1'){
	    		alert("对不起，您的账户类型没有理财的权限，请阅读理财条例重新注册理财类型账号，或者联系管理员开通理财权限。");
	    		return ;
	    	}
	 		if(new Date("${closeDate}").getTime()<new Date().getTime()){
	 			alert("对不起，此次竞标已经结束，欢迎下次竞标。亲，下手要快哦！");
	    		return ;
	 		}
	 		if(!$("#offerPrice").val()){
	 			alert("竞标价格不可以为空。");
 				return ;
	 		}
	 		if($("#type").val()=='1'&&parseFloat($("#offerPrice").val())<=parseFloat("${highestPrice}")){
 				alert("明标的目前最高价为${highestPrice}，竞标请超过最高价才能提交成功。");
 				return ;
 			}
	 		if(parseFloat("${canUse}")<parseFloat($("#offerPrice").val())){
 				alert("您目前的可用余额小于您竞标出价，请先通过我的账户资金管理的充值功能进行充值之后再进行竞标操作。");
 				return ;
 			}
	 		$.ajax({
				type: "post",
				url: "${ctx}/myAccount/addTransferAction.ht?ModelName=4&ActionName=5",
				data:{transferId:$("#transferId").val(), transferpwd:$("#transferpwd").val(),type:$("#type").val(),
					validCode:$("#validCode").val(),offerPrice:$("#offerPrice").val()},
				dataType:"json",
				success: function(json){
					if(json.result){
						 alert(json.result);
						 if("验证码输入有误"==json.result){
							 reload();
						 }
					}else{
							window.location.href="${ctx}/loginWeb.ht";
					}
				}
			});
		 }
	 	function reload(){
			var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
			document.getElementById("validImg").src=url;
		}
	 </script>
</body>
</html>
       