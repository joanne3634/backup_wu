<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<body>
  <script type="text/javascript" src="${ctx}/js/p2p/moneyFormat.js"></script>
  <script type="text/javascript" src="${ctx}/js/p2p/jquery.formatCurrency-1.4.0.js"></script>
  <script type="text/javascript">
  	
  
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
  			$.ligerDialog.warn("金额不能为空!");
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
  						$.ligerDialog.confirm("您还未绑定银行卡,是否现在就去绑定?","提示信息",function(rtn){
							
						if(rtn){//yes
							location.href='${ctx}/loan/myAccount/toBindBCPage.ht';
						}
						/* else{//no
							
						}  */
					});
  					}else{
  						
	  					$.ligerDialog.success(data);
  					}
  				
  			},
  			error : function(jqXHR, textStatus) {
  				alert(XMLHttpRequest.statusText);
  			}
  		});
  		
  	}
  	
  	
  
  </script>

        <div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">充值</span></div>
        <div class="con-box bd-l-color-main bd-b-color-main bd-r-color-main chongzhi-box">
        <dl>
          <dt>充值银行</dt>
          <dd class="qudao"><input id="gongshangyinhang-bank" type="radio" name="bank" value="gongshangyinhang"><label for="gongshangyinhang-bank"><img src="${ctx}/images/gongshangyinhang.png" alt="gongshangyinhang"></label><input id="nongye-bank" type="radio" name="bank" value="nongye"><label for="nongye-bank"><img src="${ctx}/images/nongye.png" alt="nongye"></label><input id="zhaoshang-bank" type="radio" name="bank" value="zhaoshang"><label for="zhaoshang-bank"><img src="${ctx}/images/zhaoshang.png" alt=""></label><input id="jiaotong-bank" type="radio" name="bank" value="jiaotong"><label for="jiaotong-bank"><img src="${ctx}/images/jiaotong.png" alt=""></label><input id="youzheng-bank" type="radio" name="bank" value="youzheng"><label for="youzheng-bank"><img src="${ctx}/images/youzheng.png" alt=""></label><input id="guangfa-bank" type="radio" name="bank" value="guangfa"><label for="guangfa-bank"><img src="${ctx}/images/guangfa.png" alt=""></label><input id="xingye-bank" type="radio" name="bank" value="xingye"><label for="xingye-bank"><img src="${ctx}/images/xingye.png" alt=""></label><input id="jianshe-bank" type="radio" name="bank" value="jianshe"><label for="jianshe-bank"><img src="${ctx}/images/jianshe.png" alt=""></label><input id="zhongguo-bank" type="radio" name="bank" value="zhongguo"><label for="zhongguo-bank"><img src="${ctx}/images/zhongguo.png" alt=""></label><input id="pufa-bank" type="radio" name="bank" value="pufa"><label for="pufa-bank"><img src="${ctx}/images/pufa.png" alt=""></label><input id="minsheng-bank" type="radio" name="bank" value="minsheng"><label for="minsheng-bank"><img src="${ctx}/images/minsheng.png" alt=""></label><input id="guangda-bank" type="radio" name="bank" value="guangda"><label for="guangda-bank"><img src="${ctx}/images/guangda.png" alt=""></label><input id="zhongxin-bank" type="radio" name="bank" value="zhongxin"><label for="zhongxin-bank"><img src="${ctx}/images/zhongxin.png" alt=""></label><input id="pingan-bank" type="radio" name="bank" value="pingan"><label for="pingan-bank"><img src="${ctx}/images/pingan.png" alt=""></label><input id="huaxia-bank" type="radio" name="bank" value="huaxia"><label for="huaxia-bank"><img src="${ctx}/images/huaxia.png" alt=""></label></dd>
          <dt>充值渠道</dt>
          <dd class="qudao"><input id="kuaiqian-bank" type="radio" name="bank" value="kuaiqian"><label for="kuaiqian-bank"><img src="${ctx}/images/kuaiqian.png" alt=""></label><input id="caifutong-bank" type="radio" name="bank" value="caifutong"><label for="caifutong-bank"><img src="${ctx}/images/caifutong.png" alt=""></label><input id="yibao-bank" type="radio" name="bank" value="yibao"><label for="yibao-bank"><img src="${ctx}/images/yibao.png" alt=""></label><input id="huifutianxia-bank" type="radio" name="bank" value="huifutianxia"><label for="huifutianxia-bank"><img src="${ctx}/images/huifutianxia.png" alt=""></label></dd>
          <dt>填写充值金额</dt>
          <dd>
            <div class="chongzhijine">
              <div class="dt">账户余额：</div>
              <div class="dd"><span>${TUserFunds.balanceS}</span>元</div>
              <div class="dt"><span class="color-red">*</span>充值金额：</div>
              <div class="dd"><input type="text" id="rechargeMoney_id" >元</div>
             
              <div class="dt">充值费用：</div>
              <div class="dd">
              <span id="chargeMoney_id">0.00</span>元
              	<input type="hidden" name="chargeMoney" id="chargeMoney" value=""/>
              	<input type="hidden" name="token" id="token_id" value="${token }"/>
              </div>
              
              <div class="dt"><span class="color-red">*</span>实际支付金额：</div>
              <div class="dd"><span id="actualPayMent_id">0.00</span>元</div>
              
            </div>
          </dd>
        </dl>
        <a class="bg-color-l" href="javascript:void(0)" onclick="rechargeMo();">充 值</a>
        <div>
          <span>温馨提示：</span><br>
            1．为了您的账户安全，请在充值前进行身份认证、手机绑定以及提现密码设置。<br>
            2．您的账户资金将通过第三方平台进行充值。<br>
            3．请注意您的银行卡充值限制，以免造成不便。<br>
            4．禁止洗钱，信用卡套现，虚假交易等行为，一经发现并确认，将终止该用户的使用。<br>
            5．如果充值金额没有及时到账，请联系客服，400-888-8888。
        </div>
        </div>
      </div>
 
  
  <script>
  $(function(){
	  
    	$("#rechargeMoney_id").bind("change",function(){
    	  	  $('#rechargeMoney_id').formatCurrency();
    	  	$('#rechargeMoney_id').toNumber();
    	  		var rechargeMoney_id=$("#rechargeMoney_id").val();
    	  		var chargeMoney= moneyFormatMUL(rechargeMoney_id,${TUserFunds.chargeMoneyProportion}/100);
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
  </script>
</body>
</html>