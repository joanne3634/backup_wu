<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 上传资料</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
<link rel="stylesheet" href="${ctx }/crowdfunding/resources/css/personalInfo.css">
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/anquanzhongxin.css">
</head>
<body class="iframe centralized">
  <div class="container">
  <div class="addyourproject f_l">
  	<header>
      <h2>安全中心
      
      </h2>
      <div class="tips">建议您启动全部安全设置，以保障账户和资金安全。</div>
    </header>
        <div class="con-box">
          <ul>
            <a href="${ctx }/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht">
            <li>
              <span class="icon-wrap"><i class="icon fa fa-key active"></i></span>
              <span class="anquan-ite-tit">
              	<header>登录密码</header>
              	<span>定期更换密码让您的账户更安全。</span>
              </span>
              <span class="right-action">
              	<i class="fa fa-pencil"></i>
              </span>
            </li>
            </a>
             	<%-- <li>
             	 <div class="anquan-ite-bg"></div>
              	<span class="anquan-ite-tit">交易密码</span>
              	<span>定期更换密码让你的资金更安全。</span>
              	<a href="${ctx }/crowdfunding/tcuserPersonalData/changeAccountTradingPwdPage.ht">修改</a>
            	</li> --%>
            <!--<c:if test="${userSafe.bindIdNo eq 1 }">
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
             </c:if>  -->
             
            <a href="${ctx}/safe/bindPhone.ht">
           	<li>
           		<span class="icon-wrap"><i class="icon fa fa-mobile"></i></span>
           		<span class="anquan-ite-tit">
           			<header>手机绑定<c:if test="${userSafe.bindMobile eq 0 }"><em class="warn">(未开启)</em></c:if></header>
           			<span>用于实时了解账户变动，享受众筹手机服务。</span>
           		</span>
	              <span class="right-action">
	              	<i class="fa fa-pencil"></i>
	              </span>
           	</li>
           	</a>
			<a href="${ctx}/safe/bindEmail.ht">
			<li>
				<span class="icon-wrap"><i class="icon fa fa-envelope-o"></i></span>
				<span class="anquan-ite-tit">
					<header>邮箱绑定<c:if test="${userSafe.bindEmail eq 0 }"><em class="warn">(未开启)</em></c:if></header>
					<span>享受众筹邮箱服务，<!-- 接收账单信息， -->保障账号安全。</span>
				</span> 
	              <span class="right-action">
	              	<i class="fa fa-pencil"></i>
	              </span>
			</li>
			</a>
			<a href="${ctx}/safe/safeQuestionInit.ht">
			<li>
				<span class="icon-wrap"><i class="icon fa fa-exclamation"></i></span>
				<span class="anquan-ite-tit">
					<header>安全问题<c:if test="${ empty userSafe.q1}"><em class="warn">(未开启)</em></c:if></header>
					<span>作为基础安全工具，验证账户信息，保障账户安全。</span>
				</span>
	              <span class="right-action">
	              	<i class="fa fa-pencil"></i>
	              </span>
			</li>
			</a>
          </ul>
        </div>
  </div>
</div>
  <%@ include file="/crowdfunding/globaljs.jsp"%>
</body>
</html>