<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta charset="UTF-8">
<title><%=application.getAttribute("PLATFORM_NAME")%> - 产品申请</title>
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
   <script type="text/javascript" src="${ctx}/js/p2p/applyLimit.js"></script>
</head>
<body>
  <%@ include file="/commons/includeFront/head.jsp"%>
  <div class="container">
    <div class="weizhi-lianjie">
      <a href="${ctx }/index-web.jsp">首页</a> > <span>我要借款</span>
    </div>
   
    <ul class="hyht-body woyaojiekuan-body">
    <c:forEach var="product" items="${productsloan}">
    <li>
      <div style="background-color:${product.styleStr};" class="jiekuanzhonglei-tit">${product.pName}</div>
      <div class="jiekuanzhonglei-ite-con bg-color-xs">
        <div class="shiyongrenqun">适用${product.pRecommend}</div>
        <ul class="shenqingtiaojian">申请条件
        <c:forEach var="appGuide" items="${product.appGuides}">
          <c:if test="${appGuide.agOrder==1 or appGuide.agOrder==2 or appGuide.agOrder==3}">
          <li><div class="dian bg-color-l"></div>${appGuide.agDesc}</li>
          </c:if>
        </c:forEach>
        </ul>
        <div style="margin-top:30px;"><a class="color-main" href="${ctx}/loan/productsloan/productDetails.ht?productId=${product.productsLoanId}">查看该产品的详细说明</a><br>
        <a class="lijishenqing-btn" href="${ctx}/loan/productsloan/project.ht?productId=${product.productsLoanId}">立即申请</a><br/>
        <a class="lijishenqing-btn" href="javascript:applyLoan('${ctx}','${sessionScope.user}',0);">额度申请</a></div>
        
      </div>
    </li>
    </c:forEach>
    </ul>
  </div>
   
   <div id="applayDialog" class="login_nav body" style="display:none">
      
       	 <div class="login_nav_con jiekuan-con">
       	 	<div style="text-align:right;"><span class="cancel_btn"></span></div>
          <dl>
            <dt>申请额度：</dt>
            <dd class="login_nav_con">
              <input id="applyInMax" type="text" name="applyInMax" onkeyup="num(this)"/>元
            </dd>
            <dt>已有额度：</dt>
             <dd class="login_nav_con">
              <span id="cando">3000</span>元(最大可借款金额)
            </dd>
             <dt></dt>
             <dd class="login_nav_con">
              <span id="nowcando"></span>元(当前可用)
             </dd>
          </dl>
          <a href="javascript:submitLoan('${ctx}','${sessionScope.user}');">快速申请</a>
      	</div>
      </div>
  <div style="border-top:1px solid #dcdcdc;min-width:1000px;"></div>
  <%@ include file="/commons/includeFront/footer.jsp"%>
  
  <script>
  $(function(){
	  $(".cancel_btn").click(function(){
	      $("#applayDialog").css("display","none");
	    });
  })
  </script>
</body>
</html>