<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>提现</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
  <script type="text/javascript" src="${ctx}/js/p2p/moneyFormat.js"></script>
  <script type="text/javascript" src="${ctx}/js/p2p/jquery.formatCurrency-1.4.0.js"></script>
    <style type="text/css">
  body{
    text-align: left;
     color: #333;
     font-size: 14px;
  }
      .con-box {
        overflow: hidden;
        padding-bottom: 20px;
      }
      .con-box dl {
        margin-left: 30px;
      }
      .con-box dl dt {
        margin-bottom: 10px;
        font-size: 0px;
      }
      .con-box dl dd {
		 font-size: 18px;
        line-height: 47px;
      }
      .con-box dl dd input {
        margin-left: 5px;
        margin-right: 5px;
      }
      .con-box dl dd img {
		width:145px;
		height:44px;
        margin:0px 30px 0px 10px;
      }
      
      .tianxiejine dl {
        overflow: hidden;
        line-height: 30px;
      }
      .tianxiejine dt {
       float: left;
       width: 30%;
       height: 30px;
       text-align: right;
      }
      .tianxiejine dd {
        height: 30px;
        margin-bottom: 30px;
        float: left;
        width: 70%;
      }
      .tianxiejine dd input {
        height: 16px;
        border: 1px solid #aaa;
        line-height: 18px;
        padding: 6px 5px;
        margin-right: 5px;
        }
      .tixian-tips {
        margin-left: 167px;
        }
      .tianxiejine .wenxintishi {
        margin-left: 222px;
        margin-bottom: 10px;
        line-height: 24px;
        font-size: 12px;
        color: #555;
        background-image: url(${ctx }/crowdfunding/Skin/Default/images/dengpao.png);
        background-repeat: no-repeat;
      }
      .tianxiejine .wenxintishi span {
        display: inline-block;
        padding-left: 20px;
        margin-bottom: 10px;
        font-size: 16px;
        }
      .tixian-btn {
      text-align: center;
      }
      .tixian-btn a {
        display: inline-block;
        height: 34px;
        line-height: 34px;
        padding-left: 50px;
        padding-right: 50px;
        color: #fff;
        font-size: 18px;
        background-color: #ff5200;
        border-radius: 5px;
        margin-bottom: 50px;
        margin-top: 30px;
        }
      </style>
</head>
<body>
 <div class="PrDyBack f_l">
    <input type="hidden" id="bankCardId" value="${bankCard.bankCardId}"/>
    <input type="hidden" id="handingCharge" value="${handingRecharge.setValue}"/>
    <input type="hidden" name="token_id" id="token_id" value="${drawtoken}"/>
    <input type="hidden" name="available" id="available" value="${userfunds.available}"/>
    <input type="hidden" name="chargeMoney" id="chargeMoney" value=""/>
    <h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">账号提现</h2>
        <div class="tixian-contain">
          <div class="xuanzeyinhangka">
            <div style="font-size:18px;margin-bottom:20px;">选择提现银行卡</div>
          <div class="con-box"><dl>
          <dd><input id="gongshangyinhang-bank" type="radio" name="bank" value="gongshangyinhang"><label for="gongshangyinhang-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/gongshangyinhang.png" alt="gongshangyinhang"></label><input id="nongye-bank" type="radio" name="bank" value="nongye"><label for="nongye-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/nongye.png" alt="nongye"></label><input id="zhaoshang-bank" type="radio" name="bank" value="zhaoshang"><label for="zhaoshang-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/zhaoshang.png" alt=""></label><input id="jiaotong-bank" type="radio" name="bank" value="jiaotong"><label for="jiaotong-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/jiaotong.png" alt=""></label><input id="youzheng-bank" type="radio" name="bank" value="youzheng"><label for="youzheng-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/youzheng.png" alt=""></label><input id="guangfa-bank" type="radio" name="bank" value="guangfa"><label for="guangfa-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/guangfa.png" alt=""></label><input id="xingye-bank" type="radio" name="bank" value="xingye"><label for="xingye-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/xingye.png" alt=""></label><input id="jianshe-bank" type="radio" name="bank" value="jianshe"><label for="jianshe-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/jianshe.png" alt=""></label><input id="zhongguo-bank" type="radio" name="bank" value="zhongguo"><label for="zhongguo-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/zhongguo.png" alt=""></label><input id="pufa-bank" type="radio" name="bank" value="pufa"><label for="pufa-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/pufa.png" alt=""></label><input id="minsheng-bank" type="radio" name="bank" value="minsheng"><label for="minsheng-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/minsheng.png" alt=""></label><input id="guangda-bank" type="radio" name="bank" value="guangda"><label for="guangda-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/guangda.png" alt=""></label><input id="zhongxin-bank" type="radio" name="bank" value="zhongxin"><label for="zhongxin-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/zhongxin.png" alt=""></label><input id="pingan-bank" type="radio" name="bank" value="pingan"><label for="pingan-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/pingan.png" alt=""></label><input id="huaxia-bank" type="radio" name="bank" value="huaxia"><label for="huaxia-bank"><img src="${ctx }/crowdfunding/Skin/Default/images/huaxia.png" alt=""></label></dd>
          <div style="margin-top:20px;"></div></dl></div>
          </div>
          <div class="tianxiejine">
            <div style="font-size:18px;margin-bottom:20px;">填写提现金额</div>
            <dl>
              <dt>提现金额：</dt>
              <dd><input style="width:170px;" type="text" id="drawMoney_id">元<span style="color:#999;">（限额49999元/次）</span></dd>
              <dt>支付密码：</dt>
              <dd><input style="width:170px;" type="password" id="password" name="password"></dd>
              <dt style="height:66px;line-height:66px;">体现方式：</dt>
              <dd style="height:66px;"><div style="width:180px;height:64px;line-height:64px;border:1px solid #f9d98b;background-image:url(${ctx }/crowdfunding/Skin/Default/images/gou.png);background-position:right bottom;background-repeat:no-repeat;text-align:center;color:#ff5704;">1-3个工作日到账</div></dd>
              <dt>手续费：</dt>
              <dd style="margin-bottom:10px;"><span id="chargeMoney_id">0.00</span>元
              </dd>
              <dt>实际提现金额：</dt>
              <dd><span id="actualPayMent_id">0.00</span>元</dd>
            </dl>
           <%-- <div class="tixian-tips">为避免充值还款时，因不熟悉流程而造成逾期，影响信用记录。<br>提现前请先<span style="color:#ff5704;">即时充值0.1元</span>，谢谢您的配合。</div>--%>
            <div class="tixian-btn"><a href="javascript:void(0)" onclick="drawMoney();">提 现</a> &nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="goBack();">返回</a></div>
            <div class="wenxintishi">
              <span>温馨提示：</span><br>
                1. 请设置容易记忆的安全问题，并定期重新设置，避免遗忘。<br> 
                2. 请不要向外人透露您的安全问题答案。
            </div>
          </div>
        </div>
      </div>
      <script>
  	function drawMoney(){
  		var handingRecharge =$("#chargeMoney").val();
  		var available =$("#available").val();
  		var password = $("#password").val();
  		var drawMone= $("#drawMoney_id").val();
  		var actiual_m = parseFloat(drawMone);
  		if(drawMone==''){
  			openDialog("金额不能为空!",'','','3',function(){});
  			return;
  		}
  		if(parseFloat(drawMone) <= 0){
  			openDialog("提现金额必须大于零!",'','','2',function(){
			});
  			return;
  		}
  		if((parseFloat(drawMone) - parseFloat(handingRecharge)) > 49999){
  			openDialog("限额49999元/次!",'','','3',function(){});
  			return;
  		}
  		if((parseFloat(available) - parseFloat(drawMone)) < 0){
  			openDialog("提现金额必须小于或等于可用金额!",'','','3',function(){});
  			return;
  		}
  		if(password==''){
  			openDialog("支付密码不能为空!",'','','3',function(){});
  			return;
  		}
  		$.ajax({
  			url:'${ctx}/crowdfunding/onlinePayment/drawMoneyAction.ht?token_id='+$("#token_id").val(),
  			type : 'post',
  			data :{transactionMoney:actiual_m,handingCharge:$("#chargeMoney").val(),transactionPW:password,bankCardId:$("#bankCardId").val()},
  			dataType : 'json',
  			success : function(data,textStatus) {
  				if(data=='请先绑定银行卡!'){
					art.dialog.confirm("您还未绑定银行卡,是否现在就去绑定?",function(){
						location.href='${ctx}/loan/myAccount/toBindBCPage.ht';
					});
				}else if(data.indexOf("金额必须大于零")!= -1 ){
						openDialog("提现金额必须大于零!",'','','2',function(){});
					}else if(data=='交易密码输入错误!'){
  						openDialog("交易密码输入错误!",'','','2',function(){});
  					}else if(data=='重复提交!'){
  						openDialog("重复提交!",'','','2',function(){});
  					}else{
  						openDialog("提现成功!",'','','2',function(){});
  						setTimeout(toForwordZijl,2000);
	  					//$.ligerDialog.success(data);
  					}
  			},
  			error : function(jqXHR, textStatus) {
  				openDialog("提现失败!",'','','2',function(){});
  			}
  		});
  		
  	}
  	/**
  	*跳转到资金记录界面
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
  	$(function(){
  		$("#drawMoney_id").val("");
    	$("#drawMoney_id").bind("change",function(){
    	  	  $('#drawMoney_id').formatCurrency();
    	  	  $('#drawMoney_id').toNumber();
    	  	  $('#handingCharge').toNumber();
    	  	    var setting = $("#handingCharge").val();
    	  		var rechargeMoney_id=$("#drawMoney_id").val();
    	  		var chargeMoney= moneyFormatMUL(rechargeMoney_id,setting/100);
    	  		$("#chargeMoney_id").text((chargeMoney.toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,'));
    	  		$("#chargeMoney").val(chargeMoney);//手续费
    	  		var actualPayMent=moneySub(rechargeMoney_id,chargeMoney);
    	  		$("#actualPayMent_id").text((actualPayMent.toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,'));
    	});
    	keydown();
  });
  function keydown(){
		$("input[id^='drawMoney_id']").keydown(function () {  
		    var e = $(this).event || window.event;  
		    var code = parseInt(e.keyCode);  
		    if (code >= 96 &&code <= 105 || code >= 48 && code <= 57 || code == 8||code == 110||code == 190) {  
		        return true;  
		    } else {  
		        return false;  
		    }  
		});
	}
  	function goBack(){
  		 window.location = "${ctx}/crowdfunding/memberCenter/toRechargePage.ht";
  	}
  </script>
</body>
</html>