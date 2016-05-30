<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"  %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>申请项目认筹资格</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<%-- <link rel="stylesheet" href="${ctx }/crowdfunding/public.css"> --%>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   <%-- <script type="text/javascript" src="${ctx }/crowdfunding/js/jquery-1.8.3.js"></script> --%>
   <script type="text/javascript" src="${ctx }/crowdfunding/js/artdialog/jquery.artDialog.js?skin=default"></script>
   <script type="text/javascript" src="${ctx }/crowdfunding/js/artdialog/iframeTools.js"></script>
</head>
<body>
<%@ include file="/crowdfunding/head.jsp"%>
	<div class="PrDyBack " style="margin-left:250px;">
    <h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">申请项目认筹资格</h2>
		<div class="applyEnquiryList">
		    <input type="hidden" id="balance" name="balance" value="${userfund.balance}"/>
		    
			<div class="ApEnList">缴纳项目认筹诚意金：<em>${askPrice }元</em></div>
			<%-- <p class="ApEnListP">为回馈投资人对帝隆众筹平台的支持，截止2014年10月31日之前，平台投资人只需要缴纳100元即可获得询价认筹资格； 2014年11月1日起，询价认筹诚意金价格将恢复为原价格：${askPrice }元。</p> --%>
			<div class="ApEnListdiv">
				<h5>温馨提示：</h5><p>缴纳认筹诚意金${askPrice }元后，您可以获得在本平台认筹项目的机会，只要您不反悔，取得的项目认筹资格永久有效！</p><div>出现下面任一情况，均属于投资人反悔：</div><p>① 投资人认筹成功后，又要求取消认投的；</p><p>② 项目达到付款阶段，接到<%=application.getAttribute("PLATFORM_NAME")%>付款通知超过5个工作日仍不付款的；</p>
			</div>
		</div>
		<div class="applyEnquiryList">
		<div>
		
		  <table width="80%" border="0" cellspacing="0" cellpadding="0" id="bank1" style="display:">
                          ${htmlStr }
                        </table> 
			</div>
		</div>
		<div class="patternPayment">
			<div class="PaPacontentList clear">
			
				<span onclick="payAskPriceMoney()">去付款</span>
				
				<input type="button" id="tradeRecordDet" onclick="doTradeRecord()" style="height: 35px;width: 125px;display: none;" value="查看交易明细">
			</div>
		
		</div>
		<form id="rongpaysubmit" name="rongpaysubmit" method="post" action="${ctx }/crowdfunding/front/tcprojectinvest/toPayment2.ht">
			<input type="hidden" id="defaultbank" name="defaultbank" value=""/> 
			<input type="hidden" id="pinvestAmount" name="pinvestAmount" value="${askPrice}"/>
		</form>
	</div>
	
<script type="text/javascript">
		$(function(){
			$(".PaPacontentList").eq(0).css("display","block");
			$(".patternPaymentNav li").click(function(){
				  $(this).addClass('PaPaNavChecked').siblings().removeClass('PaPaNavChecked');
				  var _index= $(this).index();
				  $(".PaPacontentList").css("display","none");
				  $(".PaPacontentList").eq(_index).css("display","block");
			});
		});
	function tomoreBanks(){
		window.open('https://payment.chinapay.com/pay/GateSel.jsp', '支付页面', '', '');
	}
	/**
	*是否已经支付询价诚意金
	*/
	function ispayAskPriceMoney(){
		$.ajax({
			url : "${ctx}/crowdfunding/onlinePayment/ispayAskPriceMoney.ht",
			type : 'post',
			async:false,
			dataType : 'json',
			success : function(data, status) {
				if(data == '1'){
					
				}
			}
		});
	}
	/**
	*获取最新用户资金余额和系统设置的诚意金
	*/
	function getNewBalace(){
		$.ajax({
			url : "${ctx}/crowdfunding/onlinePayment/getNewBalace.ht",
			type : 'post',
			async:false,
			dataType : 'json',
			success : function(data, status) {
				if(data){
					var askprice = data.askPrice;
					var balance = data.userfund.balance;
					if(askprice !='' && askprice != null && typeof(askprice) !='undefined' )
						$("#askPrice").val(askprice);
					if(balance !='' && balance != null && typeof(balance) !='undefined' )
						$("#balance").val(balance);
				}
			}
		});
	}
	
	function doTradeRecord(){
		setTimeout(closeThisWin, 2000);
		window.parent.target="_blank";
		window.parent.location = "${ctx }/loan/myAccount/myaccountPage.ht?forwordUrl=investRecord";
		
	}
	function closeThisWin(){
		$.dialog.close();
	}
	
	function showbtn(){
		$("#tradeRecordDet").show();
	}
	function setvalueFun(n){
		var defaultbank=$("#defaultbank"+n).val();
		$("#defaultbank").val(defaultbank);
		
	}
	/**
	*支付询价诚意金
	*/
	function payAskPriceMoney(){
		
		var defaultbank=$("#defaultbank").val();
		if(defaultbank==''){
			alert("请选择支付银行!");
		}else{
			
			document.rongpaysubmit.submit();
		}
		
		/* var projectId="";
		var investId="";
		var pinvestAmount=$("#askPrice").val();
		var url="${ctx }/crowdfunding/front/tcprojectinvest/toAutoSubmitjsp.ht?pinvestAmount="+pinvestAmount+"&investId="+investId+"&projectId="+projectId;
		setTimeout(showbtn, 2000);
		$.dialog.open(url,
				{title:"请选择支付银行",lock:true}); */
				
				
		
		
		//获取最新用户资金余额和系统设置的诚意金
		/* getNewBalace();
		var balance=$("#balance").val();
		var pinvestAmount=$("#askPrice").val();
		if(balance != '' && pinvestAmount != ''){
			if(parseFloat(balance) - parseFloat(pinvestAmount) <= 0){
				art.dialog.confirm("您目前账户余额不足，确定请充值后再付款吗?",function(){
					//跳转到充值界面
					goToRechargePage();
				});
				return;
			}
		}else{
			openDialog("认投金额或用户账户余额为空",'','','2',function(){});
		}
		art.dialog.confirm("你确定要付款吗?",function(){
			$.ajax({
				url : "${ctx}/crowdfunding/onlinePayment/payAskPriceMoney.ht",
				type : 'post',
				async:false,
				dataType : 'json',
				success : function(data, status) {
					
					$.dialog({
						content:"<span style='font-size:20px;'>诚意金缴纳中!</span>",
						lock: true,
						background: 'black',// 背景色#600
						opacity: 0.80,	// 透明度
						height: '150px',
						width: '400px',
						drag: false,
						fixed: true,
						cancel: true,	
						esc:true,  
						 button: [
						          {
						              name: '查看交易记录',
						              callback: function() {
						            	  window.location="${ctx}/crowdfunding/memberCenter/toinvestList.ht";
						              }
						          }
						      ],
					    close:function(){
					    	window.location="${ctx}/crowdfunding/memberCenter/toinvestList.ht";
					    }
					});
					var url="${ctx}/crowdfunding/onlinePayment/payAskPriceMoneys.ht?flowCode="+eval(data);
					window.open(url);
				},
				error : function(xhr, textStatus, errorThrown) {
					openDialog("诚意金缴纳失败!",'35%','25%','2');
				}
			});
		}); */
		
	}
   function goToRechargePage(){
	  $.dialog.open('${ctx}/crowdfunding/memberCenter/toRechargePage.ht?flag=1', {
			title: '账号充值',lock:true,width:'950px',height:'700px',close:function(){
			}
		});
		// window.parent.location = "${ctx}/crowdfunding/memberCenter/toRechargePage.ht";
	}
	function choosePayBank(n){
		$("#bankCode_").val(n);
	}
	function goPay(){
		var bank=$("#bankCode_").val();
		if(bank==''){
			openDialog("<span style=\"font-size: 16px;color: #666;text-align:left\">请选择付款银行!</span>",'35%','25%','2');
			return;
		}
		//alert(bank);
	 	switch(eval(bank)){
	 		case 0:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 1:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 2:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 3:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 4:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 5:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 6:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 7:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 8:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 9:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 10:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 11:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 12:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 13:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 14:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 15:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			case 16:openDialog("<span style=\"font-size: 16px;color: red;text-align:left\">银行支付页面!</span>",'35%','25%','2');break;
			
		} 
	 	
	 	 $.ajax({
				url : "${ctx}/crowdfunding/memberCenter/askpriceForUser.ht",
				type : 'post',
			//	data : 'projectId=' + proId + '&commentConten=' + commentConten_id
			//	,
				dataType : 'html',
				success : function(data, status) {
					if(eval(data)==eval('0')){
						window.location = "${ctx }/loginWeb.jsp";
					}else if(eval(data)==eval('1')){
						openDialog("操作成功，请等待系统审核通过!",'35%','25%','2');
					}else if(eval(data)==eval('2')){
						openDialog("诚意金缴纳成功，请等待系统审核!",'35%','25%','2');
					}else {
						openDialog("操作异常!");
					}
				},
				error : function(xhr, textStatus, errorThrown) {
				}
			});
	}
	function closediv(){
		window.parent.location.reload(true)
		var list = window.parent.art.dialog.list;
		for (var i in list) {
		    list[i].close();
		};
	}
	</script>
	<%@ include file="/crowdfunding/foot.jsp"%>
</body>
</html>
