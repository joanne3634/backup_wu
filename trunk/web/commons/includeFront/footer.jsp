<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<%@ taglib prefix="pageTag" tagdir="/WEB-INF/tags/pageTag"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<div style="border-top: 1px solid #dcdcdc; min-width: 1000px;"></div> 
 
 <div class="footer-w">
    <div class="footer container">
      <div>
        <ul>
          <li class="firstli">新手入门</li>   
            <li><a href="${ctx }/loan/aboutus/HouseholdFinanceGuideList.ht"  >新手指引</a></li>
            <li><a href="${ctx }/user/registerInit.ht"  >免费注册</a></li>
          <li><a href="${ctx }/loginWeb.ht"  >快速登录</a></li>
          <li><a href="${ctx }/loan/myAccount/myaccountPage.ht" >我的账户</a></li> 
        </ul>
        <ul>
          <li class="firstli">我要理财</li>
          <li><a href="${ctx }/tenderProjects/getTenderProjects.ht">浏览借款</a></li>
<%--           <li><a href="${ctx }/loan/myAccount/toAutoBidding.ht">自动投标</a></li> --%>
          <li><a href="${ctx }/loan/aboutus/HelpCenterList.ht?srcurl='CZLC'">投资流程</a></li>
          <li><a href="${ctx }/loan/myAccount/transfer.ht">债权转让</a></li>
        </ul>
        <ul>
          <li class="firstli">我要借款</li>
          <li><a href="${ctx }/loan/productsloan/productsLoanList.ht">发布借款</a></li>
          <li><a href="${ctx }/loan/aboutus/HelpCenterList.ht?srcurl='FBJK'">借款流程</a></li>
          <li><a href="${ctx }/loan/productsloan/projectincomelist.ht">收益计算器</a></li>
        </ul>
         <ul>
          <li class="firstli">安全保障</li>
          <li><a href="${ctx }/loan/ThePrincipalProtection/ThePrincipalProtection.ht">本金保障</a></li>
          <li><a href="${ctx }/loan/LegalPolicy/LegalPolicyList.ht">法律政策</a></li>
        </ul>
        <ul>
          <li class="firstli">帮助中心</li>
          <li><a href="${ctx }/loan/aboutus/HelpCenterList.ht?srcurl='LJP2PD'">常见问题</a></li>
          <li><a href="${ctx }/loan/aboutus/HelpCenterList.ht?srcurl='XSJX'">会员须知</a></li> 
          <li><a href="${ctx }/loan/aboutus/HelpCenterList.ht?srcurl='XSBD'">项目介绍</a></li> 
          <li><a href="${ctx }/loan/aboutus/HelpCenterList.ht?srcurl='ZRLC'">转让流程</a></li> 
        </ul>
        <ul>
          <li class="firstli">关于我们</li>
          <li><a href="${ctx}/site/AboutUs/AboutUsList.ht?">公司简介</a></li>
          <li><a href="${ctx}/site/AboutUs/AboutUsList.ht?srcurl='site/TeamIntroduction/TeamIntroductionList.ht'&&urlname=2">团队介绍</a></li>
          <li><a href="${ctx}/site/AboutUs/AboutUsList.ht?srcurl='site/MediaReport/MediaReportList.ht'&&urlname=3">媒体报道</a></li> 
          <li><a href="${ctx}/site/AboutUs/AboutUsList.ht?srcurl='site/JoinUs/JoinUsList.ht'&&urlname=4">诚聘英才</a></li>
          <li><a href="${ctx}/site/AboutUs/AboutUsList.ht?srcurl='site/ContactUs/ContactUsList.ht'&&urlname=5">联系我们</a></li>
        </ul>
        <ul>
          <li class="firstli">微信二维码</li>
          <li><img src="${ctx }<%=application.getAttribute("WEIXIN-LOGO")%>" alt=""></li>
        </ul>
        <pageTag:bottomTel menupath=""/>
      </div>
      <p class="center"><%=application.getAttribute("WEB_VERSION") %></p>
      <p class="center">Copyright Reserved 2013-2014©P2P贷（<%=application.getAttribute("WEB_SITE") %>） | <%=application.getAttribute("PLATFORM_RECORD") %></p>
    </div>
  </div> 