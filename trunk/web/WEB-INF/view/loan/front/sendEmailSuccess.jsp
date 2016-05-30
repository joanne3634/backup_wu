<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>邮件发送成功</title>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
  <link rel="stylesheet" href="${ctx}/styles/p2p/reset.css">
  <link rel="stylesheet" href="${ctx}/styles/p2p/public.css">
	<style>
	    /*----public样式Start----*/
    body {
      font-family: 'microsoft yaHei','微软雅黑',arial;
    }
    .container {
      margin-left: auto;
      margin-right: auto;
      width: 970px;
      padding-left: 15px;
      padding-right: 15px;
    }
    /*----public样式End----*/
    /*----头部样式Start----*/
    .head-w {
	  min-width: 1000px;
      height: 44px;
      background-color: #323232;
    }
    .head {
      font-size: 14px;
      line-height: 44px;
      font-family: SimHei;
      color: #aaa;
    }
    .head span {
      font-size: 24px;
      font-weight: bold;
      font-family: 'microsoft yaHei','微软雅黑',arial;
      color: #ee5407;
    }
    .head a {
      float: right;
      padding-left: 10px;
      padding-right: 10px;
    }
    .head img {
      padding-top: 6px;
      float: right;
    }
    .gray {
      color: #aaa;
    }
    .orange {
      color: #ff5703;
    }
    .green {
      color: #339900;
    }
    .yellow {
      color: #ffff00;
    }
    /*----头部样式End----*/
    /*----导航样式Start----*/
    .nav-w {
	  min-width: 1000px;
      padding-bottom: 10px;
      background-repeat: repeat-x;
      background-position: left bottom;
      background-image: url(/images/nav_bottom_bg.png);
    }
    .nav {
      height: 47px;
      padding-top: 24px;
      padding-bottom: 24px;
    }
    .nav ul {
      float: right;
      padding-top: 6px;
      padding-bottom: 6px;
    }
    .nav ul li {
      margin-left: 8px;
      margin-right: 8px;
      float: left;
    }
    .nav ul li a{
      display: inline-block;
      line-height: 35px;
      font-size: 16px;
      color: #454545;
    }
    .nav-left-a {
      margin-left: 8px; 
      margin-right: 8px; 
      padding-left: 5px;
      padding-right: 5px;
      border-bottom: 2px solid #fff;
    }
    .nav-left-a:hover {
      color: #ff5704;
      border-bottom: 2px solid #ff5704;
      text-decoration: none;
    }
    .nav .nav-right-a {
      padding-left: 12px;
      padding-right: 12px;
      color: #fff;
    }
    .nav-right-li {
      background-color: #fd671d;
      border-radius: 4px;
    }
    /*----导航样式End----*/
    /*----主体样式Start----*/
    .body {
      width: 1000px;
      margin-left: auto;
      margin-right: auto;
      overflow: hidden;
    }
    /*----主体样式End----*/
    /*----脚部样式Start----*/
    .footer-w {
      height: 225px;
      min-width: 1000px;
      padding-top: 30px;
      background-color: #f4f4f4;
      border-top: 1px solid #fff;
    }
    .footer {
      width: 960px;
      margin-left: auto;
      margin-right: auto;
      padding-left: 20px;
      padding-right: 20px;
      font-size: 14px;
      color: #666;
    }
    .footer p{
      padding-top: 5px;
    }
    .center {
      text-align: center;
    }
    .footer>div {
      overflow: hidden;
      padding-bottom: 20px;
    }
    .footer>div ul {
      width: 95px;
      float: left;
    }
    .footer>div ul li {
      padding-top: 2px;
      padding-bottom: 1px;
      padding-left: 15px;
      border-left: 1px solid #ccc;
    }
    .footer>div ul .firstli {
      padding-bottom: 8px;
      border-left: 3px solid #94c851;
      font-size: 15px;
      font-weight: bold;
      color: #ff5400;
    }
    .footer>div ul li a {
      color: #666;
    }
    .footer .mobile-nav {
      float: right;
    }
    .footer .mobile-nav {
      width: 255px;
      background-image: url(/images/dianhua-pic.png);
      background-repeat: no-repeat;
      background-position: 0 30px;
    }
    .footer .mobile-nav li {
      padding-left: 52px;
      border: none;
      font-size: 16px;
      color: #666;
    }
    .footer .mobile-nav .li2 {
      font-size: 25px;
      color: #555;
    }
    .footer .mobile-nav .li3 {
      padding-top: 20px;
    }
    /*----脚部样式End----*/
	</style>
</head>
<body>
  <div class="head-w">
    <div class="head container">
      服务电话：<span>4000-000-000</span><a class="green" href="#">免费注册</a><a class="orange" href="#">立即登录</a><a class="gray" href="#">账户中心</a><img src="/images/zhzx.png" alt="pic">
    </div>
  </div>
  <div class="nav-w">
    <div class="nav container">
      <a href="#"><img src="/images/logo.png" alt=""></a>
      <ul>
        <li><a class="nav-left-a" href="#">首 页</a></li>
        <li><a class="nav-left-a" href="#">关于我们</a></li>
        <li><a class="nav-left-a" href="#">我的账户</a></li>
        <li class="nav-right-li"><a class="nav-right-a" href="#">我要理财</a></li>
        <li class="nav-right-li"><a class="nav-right-a" href="#">我要借款</a></li>
      </ul>
    </div>
  </div>
  <style>
    .weizhi-lianjie {
      height: 21px;
      margin-top: 20px;
      margin-bottom: 15px;
      padding-left: 31px;
      background-image: url(/images/weizhi_lianjie_bg.png);
      background-repeat: no-repeat;
      line-height: 21px;
      color: #ccc;
      font-size: 14px;
    }
    .weizhi-lianjie a {
      color: #5a5a5a;
    }
    .weizhi-lianjie span {
      color: #5a5a5a;
      font-weight: bold;
    }
    #wangjimima-box {
      margin-left: 30px;
      margin-right: 30px;
      margin-bottom: 30px;
      border: 1px solid #ccc;
      color: #666;
    }
    .zhmm-inputlist {
      width: 600px;
      margin-bottom: 20px;
      overflow: hidden;
      margin-left: auto;
      margin-right: auto;
      line-height: 34px;
      font-size: 14px;
    }
    .zhmm-inputlist span {
      color: red;
    }
    #yx-zhmm {
      height: 34px;
      margin-bottom: 15px;
      text-align: center;
    }
    #yx-zhmm input {
      width: 150px;
      height: 20px;
      padding: 6px 5px;
      line-height: 20px;
      font-size: 14px;
      border: 1px solid #ccc;
    }
    .zhmm-inputlist .sub-btn {
      margin-bottom: 15px;
      text-align: center;
    }
    .sub-btn a {
      display: inline-block;
      height: 34px;
      padding-left: 40px;
      padding-right: 40px;
      line-height: 34px;
      font-size: 16px;
      color: #fff;
      border-radius: 6px;
      background-color:#ff5200;
    }
    .sub-btn a:hover {
      text-decoration: none;
      background-color: #ffa87f;
    }
    .zhmm-buzhouzhiyin {
      height: 64px;
      margin-top: 30px;
      margin-bottom: 30px;
      text-align: center;
    }
    .zhmm-buzhouzhiyin>div {
      display: inline-block;
    }
    .zhmm-buzhouzhiyin .zhmm-buzounum {
      width: 100px;
      line-height: 14px;
      font-size: 14px;
      text-align: center;
      color: #bcbcbc;
    }
    .zhmm-buzhouzhiyin .zhmm-buzounum>div {
      height: 50px;
      line-height: 50px;
      font-size: 40px;
    }
    .zhmm-buzhouzhiyin .zhmm-fengexian {
      width: 80px;
      height: 29px;
      margin-top: auto;
      margin-bottom: auto;
      border-top: 6px solid #dcdcdc;
    }
  </style>
  <div class="body">
    <div class="weizhi-lianjie"><a href="#">首页</a> > <span>忘记密码</span></div>
    <div id="wangjimima-box">
      <div class="zhmm-inputlist yxzh-btn">
        <div class="zhmm-buzhouzhiyin">
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>1</div>
            填写绑定邮箱
          </div>
          <div class="zhmm-fengexian" style="border-top-color:#ff5200;"></div>
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>2</div>
            验证邮箱
          </div>
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>3</div>
            重置密码
          </div>
        </div>
      	<div style="margin-bottom:20px;text-align:center;font-size:14px;color:#666;"><SPAN>验证邮件已发送至 ${email_addr}，若收件箱没有邮件，请尝试在垃圾邮件夹找回。</SPAN></div>
        <%--div id="yx-zhmm">
          <span>*</span>收到的验证码：<input type="text">
        </div>
        <div class="sub-btn"><a href="#">提 交</a></div--%>
      	<div style="margin-bottom:20px;text-align:center;font-size:14px;color:#999;">没收到邮件？请联系客服400-888-8888</div>
      </div>
    </div>
  </div>
  <div style="border-top:1px solid #dcdcdc;min-width:1000px;"></div>
  <div class="footer-w">
    <div class="footer">
      <div>
        <ul>
          <li class="firstli">新手入门</li>
          <li><a href="#">免费注册</a></li>
          <li><a href="#">我的网贷</a></li>
          <li><a href="#">如何借入</a></li>
        </ul>
        <ul>
          <li class="firstli">我要借出</li>
          <li><a href="#">浏览借款</a></li>
          <li><a href="#">自动投标</a></li>
          <li><a href="#">成为VIP</a></li>
        </ul>
        <ul>
          <li class="firstli">我要借入</li>
          <li><a href="#">发布借款</a></li>
          <li><a href="#">优先计划</a></li>
          <li><a href="#">诚信认证</a></li>
        </ul>
        <ul>
          <li class="firstli">诚信保障</li>
          <li><a href="#">本金保障</a></li>
          <li><a href="#">法律政策</a></li>
        </ul>
        <ul>
          <li class="firstli">关于帝隆</li>
          <li><a href="#">帝隆团队</a></li>
          <li><a href="#">帝隆论坛</a></li>
          <li><a href="#">媒体报道</a></li>
          <li><a href="#">招贤纳士</a></li>
        </ul>
        <ul>
          <li class="firstli">关于我们</li>
          <li><a href="#">新浪微博</a></li>
          <li><a href="#">腾讯微博</a></li>
          <li><a href="#">联系我们</a></li>
        </ul>
        <ul>
          <li class="firstli">微信二维码</li>
          <li><img src="Skin/default/images/erweima.png" alt=""></li>
        </ul>
        <ul class="mobile-nav">
          <li class="li1">客服电话</li>
          <li class="li2">4000-000-000</li>
          <li class="li3">工作日：9:00-18:00</li>
        </ul>
      </div>
      <p class="center">帝隆科技有限公司 版权所有 2013-2014</p>
      <p class="center">Copyright Reserved 2013-2014©P2P贷（www.p2p.com） | 粤ICP备00000000号</p>
    </div>
  </div>
</body>
</html>