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
  <style type="text/css">
  body{
    text-align: left;
     color: #333;
  }
      .con-box {
        overflow: hidden;
        padding-top: 15px;
        padding-bottom: 20px;
      }
      .con-box dl {
        margin-left: 30px;
      }
      .con-box dl dt {
        margin-bottom: 10px;
        font-size: 18px;
      }
      .con-box dl dd {
        line-height: 47px;
        font-size: 18px;
      }
      .con-box dl dd input {
        margin-left: 5px;
        margin-right: 5px;
      }
      .con-box dl select{
        padding: 8px 0px;
        width: 250px;
      }
      .con-box dl dd img {
        width: 145px;
        height: 44px;
        margin:0px 30px 0px 10px;
      }
      .con-box .tianxiejine {
        overflow: hidden;
        margin-left: -30px;
      }
      .con-box .tianxiejine dt {
        width: 50%;
        float: left;
        text-align: right;
        font-size: 14px;
        margin-bottom: 0;
        line-height: 36px;
      }
      .con-box .tianxiejine dt span {
        color: red;
      }
      .con-box .tianxiejine dd {
        width: 50%;
        float: left;
        line-height: 36px;
      }
      .con-box .tianxiejine dd span {
        float: left;
        margin-right: 5px;
        font-size: 20px;
      }
      .con-box .tianxiejine dd input {
        float: left;
        top: 5px;
        margin-left: 0;
        padding: 3px 5px;
        border: 1px solid #ccc;
        line-height: 18px;
      }
      .con-box >a {
        display: block;
        width: 140px;
        margin: 20px auto;
        height: 35px;
        line-height: 35px;
        text-align: center;
        font-size: 18px;
        color: #fff;
        background-color: #ff6c26;
        border-radius: 5px;
      }
      .con-box >a:hover {
        text-decoration: none;
        background-color: #ff5200;
      }
      .con-box>div {
        margin-left: 145px;
        margin-bottom: 10px;
        line-height: 24px;
        font-size: 13px;
        color: #555;
        background-image: url(${ctx }/crowdfunding/Skin/default/images/dengpao.png);
        background-repeat: no-repeat;
      }
      .con-box>div>span {
        display: inline-block;
        padding-left: 20px;
        margin-bottom: 10px;
        font-size: 16px;
      }
  </style>
</head>
<body>
<script>
	function reloadUrl(){
		   var flag = $("#flag").val();
			if(flag !='' && flag != null && typeof(flag) !='undefined'){
				closediv();
			}
		   window.location.reload(true);
	}

  	function rechargeMo(){
  		var password = $("#password").val();
  		var rechargeMoney= $("#rechargeMoney_id").val();
  		if(rechargeMoney==''){
  			window.parent.openDialog("金额不能为空!",'','','2',function(){
			});
  			return;
  		}
  		if(isNaN(rechargeMoney)){
  			window.parent.openDialog("输入了无效数值!",'','','2',function(){});
			 return;
		 }
  		if(parseFloat(rechargeMoney) <= 0){
  			window.parent.openDialog("金额必须大于零!",'','','2',function(){
			});
  			return;
  		}
  		if(password==''){
  			window.parent.openDialog("支付密码不能为空!",'','','2',function(){
			});
  			return;
  		} 
  		$.ajax({
  			url:'${ctx}/crowdfunding/onlinePayment/vali_callBankFunc_save.ht?token_id='+$("#token_id").val(),
  			type : 'post',
  			async:false,
  			data :{rechargeMoey:$("#actualPayMent").val(),chargeMoney_id:$("#chargeMoney").val(),pwd:password},
  			dataType : 'json',
  			success : function(data,textStatus) {
  					if(data=='请先绑定银行卡!'){
  						art.dialog.confirm("您还未绑定银行卡,是否现在就去绑定?",function(){
  							location.href='${ctx}/loan/myAccount/toBindBCPage.ht';
  						});
  					}else if(data.indexOf("金额必须大于零")!= -1 ){
  						window.parent.openDialog("金额必须大于零!",'','','2',function(){});
					}else if(data=="交易密码输入错误!"){
						window.parent.openDialog("交易密码输入错误!",'','','2',function(){});
  					}else if(data=="重复提交!"){
  						window.parent.openDialog("重复提交!",'','','2',function(){});
  					}else{ 
  						window.parent.openDialog("充值中!",'','','2',function(){});
  						var url="${ctx}/crowdfunding/onlinePayment/recharge.ht?flowCode="+data
  						window.open(url);
  					 
  						//setTimeout(reloadUrl,3000);
	  					//$.ligerDialog.success(data);
  					}
  			},
  			error : function(jqXHR, textStatus) {
  				window.parent.openDialog("充值失败!",'','','2',function(){});
  			}
  		});
  		
  	}
  	function rechargeMo1(){
  		var bankcardId = $("#bankCardId").val();
  		 var payMark = $("#payMark").val(); 
  		var rechargeMoney= $("#rechargeMoney_id1").val();
  		
  		if(payMark==''){
  			window.parent.openDialog("请先做支付绑定,再进行充值或提现操作!",'','','2',function(){});
  			return;
  		}
  		if(bankcardId=='' || typeof(bankcardId) == 'undefined' || bankcardId == null){
  			window.parent.openDialog("银行账号不能为空!",'','','2',function(){
			});
  			return;
  		}
  		if(rechargeMoney==''){
  			window.parent.openDialog("金额不能为空!",'','','2',function(){});
  			return;
  		}
  		if(isNaN(rechargeMoney)){
  			window.parent.openDialog("输入了无效数值!",'','','2',function(){});
			 return;
		 }
  		if(parseFloat(rechargeMoney) <= 0){
  			window.parent.openDialog("金额必须大于零!",'','','2',function(){});
  			return;
  		}
  		/* if(password==''){
  			window.parent.openDialog("支付密码不能为空!",'','','2',function(){
			});
  			return;
  		} */
  		$.ajax({
  			url:'${ctx}/crowdfunding/onlinePayment/vali_callBankFunc_save.ht?token_id='+$("#token_id").val(),
  			type : 'post',
  			async:false,
  			data :{bankCardId:bankcardId,rechargeMoey:$("#actualPayMent1").val(),chargeMoney_id:$("#chargeMoney1").val()},
  			dataType : 'json',
  			success : function(data,textStatus) {
  				    if(data=='请先绑定银行卡!'){
						art.dialog.confirm("您还未绑定银行卡,是否现在就去绑定?",function(){
							location.href='${ctx}/loan/myAccount/toBindBCPage.ht';
						});
					}else if(data.indexOf("金额必须大于零")!= -1 ){
						window.parent.openDialog("金额必须大于零!",'','','2',function(){});
					}else if(data.indexOf("交易密码输入错误") != -1){
						window.parent.openDialog("交易密码输入错误!",'','','2',function(){});
					}else if(data.indexOf("重复提交")!= -1 ){
						window.parent.openDialog("重复提交!",'','','2',function(){});
					}else{
						//window.parent.openDialog("充值中!",'','','2',function(){});
						$.dialog({
							content:"<span style='font-size:20px;'>充值中!</span>",
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
  						var url="${ctx}/crowdfunding/onlinePayment/recharge.ht?flowCode="+data
  						window.open(url);
  					}
  			//	  toPayment();
  			},
  			error : function(jqXHR, textStatus) {
  				window.parent.openDialog("充值失败!",'','','2',function(){});
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
	        window.parent.iFrameHeight();   
    }
  </script>
 <div class="PrDyBack f_l">
    <input type="hidden" name="token" id="token_id" value="${token }"/>
    <h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">账号充值</h2>
    <div class="PerDataTop">
                <input type="hidden" id="flag" name="flag" value="${flag}"/>
				<div class="PerDataTopName">
					<p>${TUserFunds.loginName}</p>
					安全等级
					<div class="progressBar" ><div style="width: ${TUserFunds.safebar}"></div></div>
				</div>  
				<div class="PerDataTopMoney">
					<div>账户余额 <span><fmt:formatNumber value="${TUserFunds.balance}" pattern="###,###.##" minFractionDigits="2" ></fmt:formatNumber>元</span></div>
					<span>冻结金额 ${TUserFunds.freeze }元</span><span>可用金额 ${TUserFunds.available }元</span>
				</div>
				<div class="PerDataTopButton">
				   <c:if test="${empty flag }">
					  <span class="PerDataTopButton2" onclick="drawmoneyAction('${ctx}/crowdfunding/onlinePayment/toDrawMnPage.ht');">提&nbsp;&nbsp;现</span>
				   </c:if>
				</div>
	</div>
    <div class="patternPaymentNav">
        <ul>
          <li class="PaPaNavChecked">已绑银行卡支付</li>
          <li style="display: none">其他银行卡支付</li>
        </ul>
        <span class="chognzhijilu" onclick=""  style="float:right;margin:10px 10px 0px 0px;cursor: pointer;"><img src="${ctx }/crowdfunding/Skin/Default/images/editIcont2.png">查看充值记录</span>
      </div>
        <div class="con-box">
         <dl>
         <dt><lable>已绑银行：</lable> 
	           <select id="bankCardId" name="bankCardId" class="select" onchange="sel()" >
											
			 </select>
          </dt>
          <div style="margin-top:20px;"></div>
          <dt>填写充值金额</dt>
          <dd>
	            <dl class="tianxiejine">
	              <dt>账户余额：</dt>
	              <dd><span><fmt:formatNumber value="${TUserFunds.balance}" pattern="###,###.##" minFractionDigits="2" ></fmt:formatNumber></span>元</dd>
	              <dt><span>*</span>充值金额：</dt>
	              <dd><input type="text" id="rechargeMoney_id1" name="rechargeMoney_id1" >元</dd>
	              <!-- <dt><span>*</span>支付密码：</dt>
	              <dd><input type="password" id="password1" name="password1">元</dd> -->
	              <dt>充值费用：</dt>
	              <dd>
	                <span id="chargeMoney_id1">0.00</span>元
	                <input type="hidden" name="chargeMoney1" id="chargeMoney1" value=""/>
            	    <input type="hidden" name="actualPayMent1" id="actualPayMent1" value=""/>
            	    <input type="hidden" name="payMark" id="payMark" value="${TUserFunds.payMark}"/>
	              </dd>
	              <dt><span>*</span>实际支付金额：</dt>
	              <dd><span id="actualPayMent_id1">0.00</span>元</dd>
	            </dl>
		    </dd>
          </dl>
           <a href="javascript:void(0)" onclick="rechargeMo1();">充 值</a>
        <div>
          <span>温馨提示：</span><br>
            1．为了您的账户安全，请在充值前进行身份认证、手机绑定以及提现密码设置。<br>
            2．您的账户资金将通过第三方平台进行充值。<br>
            3．请注意您的银行卡充值限制，以免造成不便。<br>
            4．禁止洗钱，信用卡套现，虚假交易等行为，一经发现并确认，将终止该用户的使用。<br>
            5．如果充值金额没有及时到账，请联系客服，400-888-8888。
        </div>
        </div>
        <div class="con-box">
        <dl>
          <dt>充值银行：</dt>
          <dd><input id="gongshangyinhang-bank" type="radio" name="bank" value="gongshangyinhang"><label for="gongshangyinhang-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/gongshangyinhang.png" alt="gongshangyinhang"></label><input id="nongye-bank" type="radio" name="bank" value="nongye"><label for="nongye-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/nongye.png" alt="nongye"></label><input id="zhaoshang-bank" type="radio" name="bank" value="zhaoshang"><label for="zhaoshang-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/zhaoshang.png" alt=""></label><input id="jiaotong-bank" type="radio" name="bank" value="jiaotong"><label for="jiaotong-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/jiaotong.png" alt=""></label><input id="youzheng-bank" type="radio" name="bank" value="youzheng"><label for="youzheng-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/youzheng.png" alt=""></label><input id="guangfa-bank" type="radio" name="bank" value="guangfa"><label for="guangfa-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/guangfa.png" alt=""></label><input id="xingye-bank" type="radio" name="bank" value="xingye"><label for="xingye-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/xingye.png" alt=""></label><input id="jianshe-bank" type="radio" name="bank" value="jianshe"><label for="jianshe-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/jianshe.png" alt=""></label><input id="zhongguo-bank" type="radio" name="bank" value="zhongguo"><label for="zhongguo-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/zhongguo.png" alt=""></label><input id="pufa-bank" type="radio" name="bank" value="pufa"><label for="pufa-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/pufa.png" alt=""></label><input id="minsheng-bank" type="radio" name="bank" value="minsheng"><label for="minsheng-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/minsheng.png" alt=""></label><input id="guangda-bank" type="radio" name="bank" value="guangda"><label for="guangda-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/guangda.png" alt=""></label><input id="zhongxin-bank" type="radio" name="bank" value="zhongxin"><label for="zhongxin-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/zhongxin.png" alt=""></label><input id="pingan-bank" type="radio" name="bank" value="pingan"><label for="pingan-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/pingan.png" alt=""></label><input id="huaxia-bank" type="radio" name="bank" value="huaxia"><label for="huaxia-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/huaxia.png" alt=""></label></dd>
          <div style="margin-top:20px;"></div>
          <dt>填写充值金额</dt>
          <dd>
            <dl class="tianxiejine">
              <dt>账户余额：</dt>
              <dd><span><fmt:formatNumber value="${TUserFunds.balance}" pattern="###,###.##" minFractionDigits="2" ></fmt:formatNumber></span>元</dd>
              <dt><span>*</span>充值金额：</dt>
              <dd><input type="text" id="rechargeMoney_id" name="rechargeMoney_id" >元</dd>
              <dt><span>*</span>支付密码：</dt>
              <dd><input type="password" id="password" name="password">元</dd>
              <dt>充值费用：</dt>
              <dd>
                <span id="chargeMoney_id">0.00</span>元
                <input type="hidden" name="chargeMoney" id="chargeMoney" value=""/>
            	<input type="hidden" name="actualPayMent" id="actualPayMent" value=""/>
              </dd>
              <dt><span>*</span>实际支付金额：</dt>
              <dd><span id="actualPayMent_id">0.00</span>元</dd>
            </dl>
          </dd>
        </dl>
        <a href="javascript:void(0)" onclick="rechargeMo();">充 值</a>
        <div>
          <span>温馨提示：</span><br>
            1．为了您的账户安全，请在充值前进行身份认证、手机绑定以及提现密码设置。<br>
            2．您的账户资金将通过第三方平台进行充值。<br>
            3．请注意您的银行卡充值限制，以免造成不便。<br>
            4．禁止洗钱，信用卡套现，虚假交易等行为，一经发现并确认，将终止该用户的使用。<br>
            5．如果充值金额没有及时到账，请联系客服，400-888-8888。 <br>
        </div>
        </div>
         <div class="TagContentList" style="display:none;">
            <iframe  src="" style="min-height: 500px;" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height="100%" id="iframepage" name="iframepage" onLoad="iFrameHeight();" ></iframe>
            <script type="text/javascript">
            </script>
         </div>
      </div>
<script>
	  $(function(){
		    $('.PrDyBack .con-box').hide();
		    $('.PrDyBack .con-box').eq(0).show(0,function(){
		    });
		    $(".patternPaymentNav li").click(function(){
		        $('.TagContentList').hide();
		        $(this).addClass('PaPaNavChecked').siblings().removeClass('PaPaNavChecked');
		        var _index= $(this).index();
		        $('.PrDyBack .con-box').hide();
		        $('.PrDyBack .con-box').eq(_index).show();
		        window.parent.iFrameHeight();   
		    });
		    $('.chognzhijilu').click(function(){
			      $('.PrDyBack .con-box').hide();
		 		  var url='${ctx }/crowdfunding/memberCenter/toRechargeRecords.ht';
		 		  $("#iframepage").attr("src", url);
			      $('.TagContentList').show();
			      window.parent.iFrameHeight();   
		    });
		    $("#rechargeMoney_id").val("");
	    	$("#rechargeMoney_id").bind("change",function(){
	    	  	  $('#rechargeMoney_id').formatCurrency();
	    	  	 $('#rechargeMoney_id').toNumber();
	    	  		var rechargeMoney_id=$("#rechargeMoney_id").val();
	    	  		var chargeMoney= moneyFormatMUL(rechargeMoney_id,${TUserFunds.chargeMoneyProportion}/100);
	    	  		$("#chargeMoney_id").text((chargeMoney.toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,'));
	    	  		$("#chargeMoney").val(chargeMoney);//手续费
	    	  		var actualPayMent=moneySub(rechargeMoney_id,chargeMoney);
	    	  		
	    	  		$("#actualPayMent_id").text((actualPayMent.toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,'));
	    	  		$("#actualPayMent").val((actualPayMent.toFixed(2)));
	    	});
   	  		bindChange();
   	  		addBankCarNo();
   	  	    keydown();
	  });
	function bindChange(){
		$("#rechargeMoney_id1").bind("change",function(){
  	  	  $('#rechargeMoney_id').formatCurrency();
  	  	$('#rechargeMoney_id').toNumber();
  	  		var rechargeMoney_id=$("#rechargeMoney_id1").val();
  	  		var chargeMoney= moneyFormatMUL(rechargeMoney_id,${TUserFunds.chargeMoneyProportion}/100);
  	  		$("#chargeMoney_id1").text((chargeMoney.toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,'));
  	  		$("#chargeMoney1").val(chargeMoney);//手续费
  	  		var actualPayMent=moneySub(rechargeMoney_id,chargeMoney);
  	  		
  	  		$("#actualPayMent_id1").text((actualPayMent.toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,'));
  	  		$("#actualPayMent1").val(actualPayMent.toFixed(2));
  	   });
	}
	function keydown(){
		$("input[id^='rechargeMoney_id']").keydown(function () {  
		    var e = $(this).event || window.event;  
		    var code = parseInt(e.keyCode);  
		    if (code >= 96 &&code <= 105 || code >= 48 && code <= 57 || code == 8||code == 110||code == 190) {  
		        return true;  
		    } else {  
		        return false;  
		    }  
		});
	}
   	function drawmoneyAction(url){
   		window.location = url;
   	}
   	function closediv(){
		var list = window.parent.art.dialog.list;
		var count = 0;
		for (var i in list) {
			if(count == 1)
		      list[i].close();
			count ++;
		};
	}
   /* 	function toPayment(){
   		var _parent = window.parent;
		if(!_parent.getNewBalace()){
			_parent = window.parent.parent;
		}else{
			_parent.getNewBalace();
		}
		if(!_parent.getNewBalace()){
			_parent = window.parent.parent.parent;
		}else{
			_parent.getNewBalace();
		}
   	} */
	
	function addBankCarNo(){
		var bankCardList = $("#bankCardId").val();
		var token = $("#token_id").val();
		if(bankCardList == null || bankCardList =='' || typeof(bankCardList) == 'undefined'){
			$.ajax({
				url : "${ctx}/crowdfunding/onlinePayment/getBankCardNo.ht",
				type : 'post',
				async:false,
				dataType : 'json',
				success : function(data, status) {
					if(token == null || token =='' || typeof(token) == 'undefined')
						$("#token_id").val(data.token);
					if(data && data.bankcardlist){
						for(var i=0;i<data.bankcardlist.length;i++){
							var bankCardId = data.bankcardlist[i]['bankCardId'];
							var cardId = data.bankcardlist[i]['cardId'];
							 $("#bankCardId").append("<option value="+bankCardId+">"+cardId+"</option>");
						}
					}
				}
			});
		}
	}
	  </script>
</body>
</html>