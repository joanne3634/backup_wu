<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<head>
	<meta charset="UTF-8">
	<title>提现</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
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
        background-image: url(${ctx }/crowdfunding/Skin/default/images/dengpao.png);
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
    <h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">账号充值</h2>
        <div class="tixian-contain">
          <div class="xuanzeyinhangka">
            <div style="font-size:18px;margin-bottom:20px;">选择体现银行卡</div>
          <div class="con-box"><dl>
          <dd><input id="gongshangyinhang-bank" type="radio" name="bank" value="gongshangyinhang"><label for="gongshangyinhang-bank"><img src="${ctx }/crowdfunding/Skin/default/images/gongshangyinhang.png" alt="gongshangyinhang"></label><input id="nongye-bank" type="radio" name="bank" value="nongye"><label for="nongye-bank"><img src="${ctx }/crowdfunding/Skin/default/images/nongye.png" alt="nongye"></label><input id="zhaoshang-bank" type="radio" name="bank" value="zhaoshang"><label for="zhaoshang-bank"><img src="${ctx }/crowdfunding/Skin/default/images/zhaoshang.png" alt=""></label><input id="jiaotong-bank" type="radio" name="bank" value="jiaotong"><label for="jiaotong-bank"><img src="${ctx }/crowdfunding/Skin/default/images/jiaotong.png" alt=""></label><input id="youzheng-bank" type="radio" name="bank" value="youzheng"><label for="youzheng-bank"><img src="${ctx }/crowdfunding/Skin/default/images/youzheng.png" alt=""></label><input id="guangfa-bank" type="radio" name="bank" value="guangfa"><label for="guangfa-bank"><img src="${ctx }/crowdfunding/Skin/default/images/guangfa.png" alt=""></label><input id="xingye-bank" type="radio" name="bank" value="xingye"><label for="xingye-bank"><img src="${ctx }/crowdfunding/Skin/default/images/xingye.png" alt=""></label><input id="jianshe-bank" type="radio" name="bank" value="jianshe"><label for="jianshe-bank"><img src="${ctx }/crowdfunding/Skin/default/images/jianshe.png" alt=""></label><input id="zhongguo-bank" type="radio" name="bank" value="zhongguo"><label for="zhongguo-bank"><img src="${ctx }/crowdfunding/Skin/default/images/zhongguo.png" alt=""></label><input id="pufa-bank" type="radio" name="bank" value="pufa"><label for="pufa-bank"><img src="${ctx }/crowdfunding/Skin/default/images/pufa.png" alt=""></label><input id="minsheng-bank" type="radio" name="bank" value="minsheng"><label for="minsheng-bank"><img src="${ctx }/crowdfunding/Skin/default/images/minsheng.png" alt=""></label><input id="guangda-bank" type="radio" name="bank" value="guangda"><label for="guangda-bank"><img src="${ctx }/crowdfunding/Skin/default/images/guangda.png" alt=""></label><input id="zhongxin-bank" type="radio" name="bank" value="zhongxin"><label for="zhongxin-bank"><img src="${ctx }/crowdfunding/Skin/default/images/zhongxin.png" alt=""></label><input id="pingan-bank" type="radio" name="bank" value="pingan"><label for="pingan-bank"><img src="${ctx }/crowdfunding/Skin/default/images/pingan.png" alt=""></label><input id="huaxia-bank" type="radio" name="bank" value="huaxia"><label for="huaxia-bank"><img src="${ctx }/crowdfunding/Skin/default/images/huaxia.png" alt=""></label></dd>
          <div style="margin-top:20px;"></div></dl></div>
          </div>
          <div class="tianxiejine">
            <div style="font-size:18px;margin-bottom:20px;">填写提现金额</div>
            <dl>
              <dt>提现金额：</dt>
              <dd><input style="width:170px;" type="text">元<span style="color:#999;">（限额49999元/次）</span></dd>
              <dt>支付密码：</dt>
              <dd><input style="width:170px;" type="text"></dd>
              <dt style="height:66px;line-height:66px;">体现方式：</dt>
              <dd style="height:66px;"><div style="width:180px;height:64px;line-height:64px;border:1px solid #f9d98b;background-image:url(${ctx }/crowdfunding/Skin/default/images/gou.png);background-position:right bottom;background-repeat:no-repeat;text-align:center;color:#ff5704;">1-3个工作日到账</div></dd>
              <dt>手续费：</dt>
              <dd style="margin-bottom:10px;">3元/笔（<span style="color:#ff5704;">收费规则</span>）</dd>
            </dl>
            <div class="tixian-tips">为避免充值还款时，因不熟悉流程而造成逾期，影响信用记录。<br>提现前请先<span style="color:#ff5704;">即时充值0.1元</span>，谢谢您的配合。</div>
            <div class="tixian-btn"><a href="#">提 现</a></div>
            <div class="wenxintishi">
              <span>温馨提示：</span><br>
                1. 请设置容易记忆的安全问题，并定期重新设置，避免遗忘。<br> 
                2. 请不要向外人透露您的安全问题答案。
            </div>
          </div>
        </div>
      </div>
</body>
</html>