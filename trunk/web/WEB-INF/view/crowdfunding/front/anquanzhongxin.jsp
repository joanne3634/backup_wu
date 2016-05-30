<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>安全中心</title>
		<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
  	  <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/anquanzhongxin.css">
</head>
<body>
  <div class="container">
  <div class="addyourproject f_l">
      <h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">安全中心</h2>
    <div class="hyht-body">
      <div id="hyht-bodyright">
       
        <div class="con-box">
          <div class="tips">>>建议您启动全部安全设置，以保障账户和资金安全。</div>
          <ul>
            <li>
              <div class="anquan-ite-bg"></div>
              <span class="anquan-ite-tit">登录密码</span>
              <span>定期更换密码让您的账户更安全。</span>
              <a href="${ctx }/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht">修改</a>
            </li>
             	<%-- <li>
             	 <div class="anquan-ite-bg"></div>
              	<span class="anquan-ite-tit">交易密码</span>
              	<span>定期更换密码让你的资金更安全。</span>
              	<a href="${ctx }/crowdfunding/tcuserPersonalData/changeAccountTradingPwdPage.ht">修改</a>
            	</li> --%>
            <c:if test="${userSafe.bindIdNo eq 1 }">
           		 <li>
              		<div class="anquan-ite-bg" style="background-position:0 -36px;"></div>
              		<span class="anquan-ite-tit">银行卡绑定</span>
              		<span>用于提升安全性和信用分。</span>
              		<a href="${ctx}/loan/myAccount/toBindBCPage.ht">修改</a>
           	 	</li>
            </c:if>
            <c:if test="${userSafe.bindIdNo eq 0 }">
           		<li>
             		 <div class="anquan-ite-bg" style="background-position:-33px -36px;"></div>
             		 <span class="anquan-ite-tit">银行卡绑定</span>
             	 	<span>用于提升安全性和信用分。</span>
              		<a href="${ctx}/loan/myAccount/toBindBCPage.ht">立即绑定</a>
            	</li>
             </c:if>
             <c:if test="${userSafe.bindMobile eq 1 }">
            	<li>
              		<div class="anquan-ite-bg" style="background-position:0 -72px;"></div>
              		<span class="anquan-ite-tit">手机绑定</span>
              		<span>用于实时了解账户变动，享受众筹手机服务。</span>
              		<a href="${ctx}/safe/bindPhone.ht">修改</a>
            	</li>
			</c:if>
			<c:if test="${userSafe.bindMobile eq 0 }">
            	<li>
              		<div class="anquan-ite-bg" style="background-position:-33px -72px;"></div>
              		<span class="anquan-ite-tit">手机绑定</span>
              		<span>用于实时了解账户变动，享受众筹手机服务。</span>
              		<a href="${ctx}/safe/bindPhone.ht">立即绑定</a>
            	</li>
            </c:if>
            <c:if test="${userSafe.bindEmail eq 1 }">
            	<li>
              		<div class="anquan-ite-bg" style="background-position:0 -108px;"></div>
              		<span class="anquan-ite-tit">邮箱绑定</span>
              		<span>享受众筹邮箱服务，<!-- 接收账单信息， -->保障账号安全。</span>
              		<a href="${ctx}/safe/bindEmail.ht">修改</a>
            	</li>
            </c:if>
            <c:if test="${userSafe.bindEmail eq 0 }">
             	<li>
              		<div class="anquan-ite-bg" style="background-position:-33px -108px;"></div>
              		<span class="anquan-ite-tit">邮箱绑定</span>
              		<span>享受众筹邮箱服务，<!-- 接收账单信息， -->保障账号安全。</span>
              		<a href="${ctx}/safe/bindEmail.ht">立即绑定</a>
            	</li>
            </c:if>
            <c:if test="${not empty userSafe.q1}">
            	<li>
              		<div class="anquan-ite-bg" style="background-position:0 -144px;"></div>
              		<span class="anquan-ite-tit">安全问题</span>
              		<span>作为基础安全工具，验证账户信息，保障账户安全。</span>
              		<a href="${ctx}/safe/safeQuestionInit.ht">修改</a>
            	</li>
            </c:if>
            <c:if test="${empty userSafe.q1}">
             	<li>
             		<div class="anquan-ite-bg" style="background-position:-33px -144px;"></div>
              		<span class="anquan-ite-tit">安全问题</span>
              		<span>作为基础安全工具，验证账户信息，保障账户安全。</span>
              		<a href="${ctx}/safe/safeQuestionInit.ht">立即设置</a>
            	</li>
            </c:if>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
  
</body>
</html>