<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>wangjimima2-mobile</title>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
  <link rel="stylesheet" href="${ctx}/styles/p2p/reset.css">
  <link rel="stylesheet" href="${ctx}/styles/p2p/public.css">
  
  <script type="text/javascript">
  	function submitVliCode(){
  		var m_vli_code=$("#m_vli_code").val();
  		m_vli_code=$.trim(m_vli_code);
  		if(m_vli_code==""){
  			var url="${ctx}/images/error.jpg";
			document.getElementById("err_id").src=url;
			return;
  		}
  		
  		document.getElementById('mobileValiCode_form_2').submit();
  	}
  </script>
</head>
<body>
  <div class="head-w">
    <div class="head container">
      服务电话：<span>4000-000-000</span><a class="green" href="#">免费注册</a><a class="orange" href="#">立即登录</a><a class="gray" href="#">账户中心</a><img src="${ctx}/images/zhzx.png" alt="pic">
    </div>
  </div>
  <div class="nav-w">
    <div class="nav container">
      <a href="#"><img src="${ctx}/images/logo.png" alt=""></a>
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
    #sj-zhmm {
      height: 34px;
      margin-bottom: 15px;
      text-align: center;
    }
    #sj-zhmm input {
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
  <div class="container">
    <div class="weizhi-lianjie"><a href="#">首页</a> > <span>忘记密码</span></div>
    <div id="wangjimima-box">
      <div class="zhmm-inputlist yxzh-btn">
        <div class="zhmm-buzhouzhiyin">
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>1</div>
            填写绑定手机
          </div>
          <div class="zhmm-fengexian" style="border-top-color:#ff5200;"></div>
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>2</div>
            验证手机
          </div>
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>3</div>
            重置密码
          </div>
        </div>
      	<div style="margin-bottom:20px;text-align:center;font-size:14px;color:#666;">“P2P贷手机验证短信” 已发送至您的手机 <span>${mobileNum }</span></div>
      	 <form id="mobileValiCode_form_2" action="${ctx }/p2p/front/valiFromMobileCode.ht" method="post">
        <div id="sj-zhmm">
        
          <span>*</span>收到的验证码：<input type="text" id="m_vli_code" name="moValiCode"><img src="${Err_ }" id="err_id" alt="">
        </div>
         <input type="hidden" name="mobileNum" value="${mobileNum }">
      	<div style="margin-bottom:20px;text-align:center;font-size:14px;color:#999;">没收到短信？请联系客服400-888-8888</div>
        <div class="sub-btn"><a href="javascript:void(0);" onclick="submitVliCode();">提 交</a></div>
        </form>
      </div>
    </div>
  </div>
  <div style="border-top:1px solid #dcdcdc;min-width:1000px;"></div>
  <div class="footer-w">
    <div class="footer container">
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
          <li><img src="${ctx}/images/erweima.png" alt=""></li>
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