<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<footer class="main-footer">
  <div class="ink-grid push-center all-90">
    <div class="container column-group">
      <div class="qrcode all-25"><img src="<h:static type="img" src="/crowdfunding/resources/img/qrcode.jpg"/>"></div>
      <div class="content all-55">
        <div class="links">
          <ul>
            <li><a href="${ctx}/site/AboutUs/AboutUsList.ht?srcurl='site/AboutUs/AboutUs.ht'&urlname=1">关于无忧筹</a></li>
            <li><a href="${ctx}/site/AboutUs/AboutUsList.ht?srcurl='site/ContactUs/ContactUsList.ht'&urlname=5">联系我们</a></li>
            <li><a href="${ctx}/site/AboutUs/AboutUsList.ht?srcurl='site/JoinUs/JoinUsList.ht'&urlname=4">招贤纳士</a></li>
            <li><a href="${ctx }/loan/aboutus/ZYXZDetails.ht"  target="_blank">资源下载</a></li>
            <li><a href="${ctx }/site/CopyrightStatement/CopyrightStatement.ht" target="_blank">法律服务</a></li>
          </ul>
        </div>
        <div class="contact">
          <p>客服电话：<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %>（工作时间：周一至周五 早09：30--17：30）</p>
          <p>公司邮箱：<%=application.getAttribute("EMAIL") %></p>
          <p>公司地址：深圳市福田区金中环商务大厦36楼</p>
          <%--<%=application.getAttribute("TECH_SUPPORT") %>--%>
        </div>
      </div>
      <div class="buttom-logo align-right">
        <img src="${ctx}<%=application.getAttribute("PLATFORM_LOGO") %>">
        <p><%=application.getAttribute("ALL-RIGHT-RESERVED") %> 版权所有<a href="#"> <%=application.getAttribute("PLATFORM_RECORD") %></a></p>
      </div>
    </div>
  </div>
</footer>