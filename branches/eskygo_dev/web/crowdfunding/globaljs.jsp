<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@page import="com.deelon.loan.model.front.TUser" %>
<%@page import="com.deelon.loan.util.TUserUtil" %>
<%
  TUser tuser = TUserUtil.getLogUser(request);
%>
<script>
  var _ctx="${ctx}";
  var isLogin = <%=tuser!=null%>;
</script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/ink/3.1.9/js/ink-all.min.js"></script>
<script src="<h:static type="js" src="/crowdfunding/resources/js/esg-jqplugin.dialog.js" />"></script>
<script src="<h:static type="js" src="/crowdfunding/resources/js/global.js" />"></script>
