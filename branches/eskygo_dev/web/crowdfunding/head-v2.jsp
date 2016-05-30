<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@page import="com.deelon.loan.model.front.TUser" %>
<%@page import="com.deelon.loan.util.TUserUtil" %>
<%
  TUser user = TUserUtil.getLogUser(request);
%>
<script>
  var _ctx="${ctx}";
  var __ctx='<%=request.getContextPath()%>';
  var __jsessionId='<%=session.getId() %>';
  var isLogin = <%=user!=null%>;
</script>
<!--[if lte IE 9 ]>
<div id="browser-alert" class="ink-alert basic" role="alert">
<button class="ink-dismiss" onclick="document.getElementById('browser-alert').style.display='none'">&times;</button>
<p>
<strong>You are using an outdated Internet Explorer version.</strong>
Please <a href="http://browsehappy.com/">upgrade to a modern browser</a> to improve your web experience.
</p>
</div>
<![endif]-->
<header class="navigation">
  <div class="ink-navigation ink-grid push-center">
    <div class="all-90 push-center">
      <ul class="menu horizontal push-left">
        <li class="logo"><a href="${ctx}/index-web.jsp" target="_top"><img src="${ctx}<%=application.getAttribute("PLATFORM_LOGO") %>"></a></li>
      </ul>
      <ul id="nav-menu" class="menu horizontal push-left">
        <li>
          <a href="${ctx}/index-web.jsp" target="_top" title="无忧筹首页">首页</a>
        </li>
        <li>
          <a href="${ctx }/crowdfunding/front/tofinancingPro.ht" target="_top" title="项目浏览">项目浏览</a>
        </li>
        <li>
          <a href="${ctx }/crowdfunding/tcuserInvestor/tcuserInvestorPage.ht" target="_top" title="投资人">投资人</a>
        </li>
        <li>
          <a href="${ctx }/tcproject/ProjectDynamic/ProjectDynamicList.ht" target="_top" title="项目动态">项目动态</a>
        </li>
        <li class="search">
          <form id="header-search" class="ink-form" method="post" action="${ctx }/crowdfunding/tcproject/querywebinfos.ht">
            <div class="prepend-symbol">
              <input type="search" name="paramValue" value="${paramNow}" placeholder="找项目、找投资人">
              <i class="fa fa-search"></i>
            </div>
          </form>
        </li>
      </ul>
      <ul id="nav-session" class="push-right">
        <%if(user==null){%>
        <li>
          <a class="ink-button white" href="${ctx }/user/registerInit.ht">注册</a>
        </li>
        <li>
          <a class="ink-button white" href="${ctx }/loginWeb.jsp">登录</a>
        </li>
        <%}else{ %>
        <li>
          <div class="ink-dropdown" data-target="#user-logined-dropdown" id="userlogined">
            <button class="ink-button white user">
              <i class="fa fa-user fa-fw"></i>
              <span><%=user.getLoginName(  ) %></span>
            </button>
            <ul id="user-logined-dropdown" class="dropdown menu">
              <li><a href="${ctx }/loan/myAccount/myaccountPage.ht">会员中心</a></li>
              <li><a href="${ctx}/loan/myAccount/myaccountPage.ht?flag=/loan/tuserMsgRemind/myInbox.ht'">未读消息<span id="num-box" class="ink-badge red" title="未读信息">0</span></a></li>
              <li class="separator-above"><a href="${ctx}/user/logout.ht">退出</a></li>
            </ul>
          </div>
        </li>
        <%}%>
      </ul>
    </div>
  </div>
</header>