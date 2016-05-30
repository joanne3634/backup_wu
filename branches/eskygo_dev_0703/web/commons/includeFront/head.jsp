<%@page import="com.deelon.loan.model.front.TUser"%>
<%@page import="com.deelon.loan.util.TUserUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<%@ taglib prefix="pageTag" tagdir="/WEB-INF/tags/pageTag"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<%
TUser  u=TUserUtil.getLogUser( request );
%>
<div class="header-w">
    <div class="header container">
    <pageTag:toptel menupath=""/> 
     	 
       <%if(u==null){ %>   
        <a class="color-s" href="${ctx}/user/registerInit.ht">免费注册</a>
      	<a class="color-main" href="${ctx }/loginWeb.ht">立即登录</a>
        <%}else{ %>
        <a class="color-main" href="${ctx }/user/logout.ht">退出</a>
        <a class="gray" href="${ctx }/loan/myAccount/myaccountPage.ht">欢迎您:<%=u.getLoginName(  ) %></a>
      	<img src="${ctx }/styles/p2p/Skin/Default/images/zhzx.png" alt="pic">
        <%} %>
    </div>
  </div>
 <div class="nav-w">
	  <div class="nav container">
	    <a href="${ctx }/index-web.jsp"><img src="${ctx }<%=application.getAttribute("PLATFORM_LOGO")%>" alt="LOGO" ></a>
	      <ul>
	        <li><a class="nav-left-a" href="${ctx }/index-web.jsp">首 页</a></li>
	            
	        	<li class="nav-right-li"><a class="nav-right-a" href="${ctx }/tenderProjects/getTenderProjects.ht">我要理财</a></li>	
	      		<li class="nav-right-li"><a class="nav-right-a" href="${ctx}/loan/productsloan/productsLoanList.ht">我要借款</a></li>
	      		<li class="nav-right-li"><a class="nav-right-a" href="${ctx}/myAccount/transfer.ht">债权转让</a></li>	    
	        	<li><a class="nav-left-a" href="${ctx}/loan/myAccount/myaccountPage.ht">我的账户</a></li>
	         	<li><a class="nav-left-a" href="${ctx}/site/AboutUs/AboutUsList.ht">关于我们</a></li>        
	      </ul>
	  </div> 
  </div>