<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<body>

<script type="text/javascript" src="${ctx}/js/p2p/jquery.formatCurrency-1.4.0.js"></script>
	<div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">提现</span></div>
        <div class="con-box bd-l-color-main bd-b-color-main bd-r-color-main tixian-box">
          <div class="xuanzeyinhangka bd-color-main">
            <div style="font-size:18px;margin-bottom:20px;">选择提现银行卡</div>
            <div style="border:1px solid #e9e9e9;width:227px;margin-bottom:20px;margin-left:30px;">                           
              <a href="#lightbox1" rel="lightbox1" class="tianjiayinhangka-gg imgstyles_ bg-color-s" ></a>
              <a href="#lightbox1" rel="lightbox1" class="tianjiayinhangka-gg color-main" style="height:40px;line-height:40px;text-align:center;">添加银行卡</a>
            </div>
            <div style="color:#999;margin-bottom:20px;margin-left:30px;">添加银行卡银行卡必须为“张三”的借记卡，否则无法体现</div>
          </div>
          <div class="tianxiejine">
            <div style="font-size:18px;margin-bottom:20px;">填写提现金额</div>
            <dl>
              <dt>提现金额：</dt>
              <dd><input class="inputText Wdate input-text" type="text">元<span style="color:#999;">（限额49999元/次）</span></dd>
              <dt style="height:66px;line-height:66px;">提现方式：</dt>
              <dd style="height:66px;"><div class="drawmos_ color-main" >1-3个工作日到账</div></dd>
              <dt>手续费：</dt>
              <dd style="margin-bottom:10px;">3元/笔（<span class="color-main">收费规则</span>）</dd>
            </dl>
            <div class="tixian-tips">为避免充值还款时，因不熟悉流程而造成逾期，影响信用记录。<br>提现前请先<span style="color:#ff5704;">即时充值0.1元</span>，谢谢您的配合。</div>
            <div class="tixian-btn"><a class="bg-color-l" href="#">提 现</a></div><!--?ModelName=1&ActionName=2  -->
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