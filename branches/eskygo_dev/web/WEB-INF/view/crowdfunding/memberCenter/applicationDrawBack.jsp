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
	<title>申请提现</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
   <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
		<div class="personalData f_l">
		<h3><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">申请提现</h3>
			<div class="PerDataTop">
			<div class="DrawBackNO"><span>账户余额&nbsp;&nbsp;<em>${TUserFunds.balance }元</em></span><span>冻结金额&nbsp;&nbsp;${TUserFunds.freeze }元</span><span>可用金额&nbsp;&nbsp;${TUserFunds.available }元</span></div>
			 <input type="hidden" name="payMark" id="payMark" value="${TUserFunds.payMark}"/>
			<div class="DrawBackhint">
				<p><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">采用手工充值时，您可以将您的充值资金，以银行柜台或网上银行的形式转账到投付宝官方托管账户。</p>
				<p><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">转账时的开户名必须与您在大家投注册的真实姓名一致；</p>
				<p><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">多次转账必须用同一张卡，以便于提现时保障您资金的安全。</p>
			</div>
			</div>
			<div class="Recharge">
			<div class="patternPaymentNav">
				<ul>
					<li class="PaPaNavChecked">填写提现信息</li>
					<li class="mytixianjilu" style="display: none">我的提现记录</li>
				</ul>
			</div>
			<div class="RechargeFlow TagContentList">
				<div class="hint hintP"><p>温馨提示：</p><p>① 提现资金，只能退还到您为充值时所使用的账户；</p><!-- <p>② 提现申请提交成功后，申请的提现金额将会被暂时冻结，不能用于投资；</p><p>③申请提交完成后，我们会在两个工作日内为您审核，审核结果将会以手机短信的形式向您告知，请耐心等待。如有疑问，欢迎拨打客服电话：0755-83177764，进行咨询！</p> --></div>
				<div class="clear DrawbackContent">
					<c:if test="${not empty listBkc }">
					<ul>
						<li><label>申请提现金额：</label><input type="text" id="backMoney_id" /><em id="warring_i"></em></li>
						<li>
						
							
							<label>请选择银行卡：</label>
								<select id="select_b_c" onchange="changeCard(this)" style="height: 30px;">
									<c:forEach items="${listBkc }" var="vo" varStatus="i">
										<option id="${vo.bankCardId}" value="${vo.bankCardId}"
										<c:if test="${i.count eq '0' }">selected="selected"</c:if> >
										${vo.cardId }</option>
									</c:forEach>
								</select>
							
						</li>
							<li><label>款项所退入银行：</label><span id="bankname_id">${listBkc[0].bankName }</span></li>
							<li><label>开户名：</label><span id="realname_id">${listBkc[0].realName }</span></li>
							<li><label>账号：</label><span id="cardid_id">${listBkc[0].cardId }</span></li>
					</ul>
						
						<span class="RechargeButton" onclick="drawbacksm()">确定</span>
					</c:if>
				</div>
				<!-- 尚未绑定银行卡号start -->
				<c:if test="${empty listBkc }">
				<div class="clear DrawbackContent">
					<ul>
						<li><label>申请提现金额：</label><input type="text" /><em>所申请提现金额不能超过您账户可用余额</em></li>
						<li><label>款项所退入银行：</label></li>
						<li><label>开户名：</label></li>
						<li><label>账号：</label></li>
					</ul>
					<span  class="Drawbackspan">尚未绑定提现所需的银行卡号信息,暂时无法提现</span>
				</div>
				</c:if>
				<!-- 尚未绑定银行卡号end -->
			</div>
			<div class="TagContentList">
				<iframe src="${ctx }/crowdfunding/memberCenter/todrawBackRecords.ht?projectId=${tcproject.projectId}" style="min-height: 500px;" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height="100%" id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
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
		$(".patternPaymentNav li").eq(1).click(function(){
			  $(this).addClass('PaPaNavChecked').siblings().removeClass('PaPaNavChecked');
			  var _index= $(this).index();
			  $(".Recharge .TagContentList").css("display","none");
			  $(".Recharge .TagContentList").eq(_index).css("display","block");
			  //调用点击事件调用的函数
			  
		});
		
		 $("input[id^='backMoney_id']").keydown(function () {  
			    var e = $(this).event || window.event;  
			    var code = parseInt(e.keyCode);  
			    if (code >= 96 &&code <= 105 || code >= 48 && code <= 57 || code == 8||code == 110||code == 190) {  
			        return true;  
			    } else {  
			        return false;  
			    }  
			}); 
		 $("#backMoney_id").change(function () {
			 if(isNaN($("#backMoney_id").val())){
				 $("#warring_i").html("输入了无效数值!");
			 }
			 if(eval(${TUserFunds.available })<eval($("#backMoney_id").val())){
				 $("#warring_i").html("所申请提现金额不能超过您账户可用余额");
			 }
			 if($("#backMoney_id").val()==''){
				 $("#warring_i").html("输入不能为空!");
			 }
			 
		 });
	});
	/**
	*查询提现资金明细列表
	*/
	function toFindZjDetailList(){
		$("#iframepage").attr("src",'${ctx }/crowdfunding/memberCenter/todrawBackRecords.ht');
	}
	/**
	*切换银行卡号，自动显示相应银行到信息
	*/
	function changeCard(_this){
		var selcarid = $("#"+_this.id).val();
		if(selcarid){
			$.ajax({
				url : "${ctx}/crowdfunding/memberCenter/getDrawBack.ht",
				type : 'post',
				async:false,
				data:'bankCardId='+selcarid,
				dataType : 'json',
				success : function(data, status) {
					if(data){
						if(data.listBkc){
							$("#realname_id").html(data.listBkc.realName);
							$("#cardid_id").html(data.listBkc.cardId);
						}
						if(data.tbank){
							$("#bankname_id").html(data.tbank.bankName);
						}
					}
				}
			});
		}
	}
	
	function drawbacksm(){
		
		 var payMark = $("#payMark").val(); 
	  		
	  		if(payMark==''){
	  			window.parent.openDialog("请先做支付绑定,再进行充值或提现操作!",'','','2',function(){});
	  			return;
	  		}
		
		 if(isNaN($("#backMoney_id").val())){
			 $("#warring_i").html("<span style=\"color: red\">输入了无效数值!</span>");
			 return;
		 }
		if(eval(${TUserFunds.available })<eval($("#backMoney_id").val())){
			 $("#warring_i").html("<span style=\"color: red\">所申请提现金额不能超过您账户可用余额</span>");
			 return;
		 }
		 if($("#backMoney_id").val()==''){
			 $("#warring_i").html("<span style=\"color: red\">输入不能为空!</span>");
			 return;
		 }
		 
		
		var backMoney=$("#backMoney_id").val();
	    var cardid=$("#select_b_c").val();
	    $.ajax({
			url : "${ctx}/crowdfunding/memberCenter/drawBackMoney.ht",
			type : 'post',
			data : 'backMoney=' + backMoney + '&cardid=' + cardid
			,
			dataType : 'html',
			success : function(data, status) {
				if(eval(data)==eval('0')){
					window.location = "${ctx }/loginWeb.jsp";
				}else {
					//openDialog("提现申请中!");  
					$.dialog({
						content:"<span style='font-size:20px;'>提现申请中!</span>",
						lock: true,
						background: 'black',// 背景色#600
						opacity: 0.80,	// 透明度
						height: '150px',
						width: '400px',
						drag: false,
						fixed: true,
						cancel: false,	
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
					var url="${ctx}/crowdfunding/memberCenter/withdraws.ht?flowCode="+eval(data);
					window.open(url);
					
				}
			},
			error : function(xhr, textStatus, errorThrown) {
				openDialog("操作异常!");
			}
		});
	}
	/**
  	*跳转到资金记录列表界面
  	*/
  	function toForwordZijl(){
		var _parent = window.parent;
		if(!_parent){
			_parent =  window.parent.parent;
		}
		if(!_parent){
			_parent =  window.parent.parent.parent;
		}
		_parent.loadPages("${ctx}/crowdfunding/memberCenter/toinvestList.ht");
		_parent.selZijlinit();
		
  	}
	function iFrameHeight() {
			
		    var ifm= document.getElementById("iframepage");
	
		    var subWeb = document.frames ? document.frames["iframepage"].document :
	
				ifm.contentDocument;
	
		        if(ifm != null && subWeb != null) {
	
		        ifm.height = subWeb.body.scrollHeight;
	
		        }
	
		}
	</script>
</body>
</html>
