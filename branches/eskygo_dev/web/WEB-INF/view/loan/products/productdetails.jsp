<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta charset="UTF-8">
  <title> <%=application.getAttribute("PLATFORM_NAME")%> - ${product.pName}</title>
  <%@ include file="/commons/includeFront/javascripts.jsp"%> 
</head>
<body>
  <%@ include file="/commons/includeFront/head.jsp"%>
  <div class="container">
    <div class="weizhi-lianjie">
      <a href="${ctx }/index-web.jsp">首页</a> > <a href="${ctx}/loan/productsloan/productsLoanList.ht">我要借款</a> > <span>${product.pName}</span>
    </div>
   
    <div class="pujkb-body">
      <div class="pujkb-banner"><img src="${ctx}/images/putongjiekuanbiao_pic.png" alt=""></div>
      <dl class="pujkb-tab">
        <dt class="bd-color-main bg-color-s"><div class="shuxian bd-color-shuxian"></div>${product.pName}<a class="bg-color-l bd-color-main-l" href="${ctx}/loan/productsloan/project.ht?productId=${product.productsLoanId}">我要发布此借款</a></dt>
        <dd class="bd-l-color-main bd-r-color-main bd-b-color-main">
          <div class="bd-b-color-main">亮点：${product.pGood}。</div>
          <div class="no-border-b">推荐人群：${product.pRecommend}。</div>
        </dd>
        <dt class="bd-color-main bg-color-s"><div class="shuxian bd-color-shuxian"></div>产品描述</dt>
        <dd class="chanpinmiaoshu bd-l-color-main bd-r-color-main bd-b-color-main">
          <div class="cpms-ite-tit bd-color-main">额度</div>
          <div class="cpms-ite-con bd-color-main">${product.pAmountMin}元~${product.pAmountMax}元</div>
          <div class="cpms-ite-tit bd-color-main">贷款利率</div>
          <div class="cpms-ite-con bd-color-main no-border-r">${product.pRateMin}%~${product.pRateMax}%（即月利率：${product.pRateMin/12}%~${product.pRateMax/12}%）</div>
          <div class="cpms-ite-tit bd-color-main">贷款期限</div>
          <div class="cpms-ite-con bd-color-main">${product.pDeadlineMin}~${product.pDeadlineMax}个月</div>
          <div class="cpms-ite-tit bd-color-main">投标时间</div>
          <div class="cpms-ite-con bd-color-main no-border-r">${product.pVotingDaysMin}~${product.pVotingDaysMax}天</div>
          <div class="cpms-ite-tit bd-color-main">审核时间</div>
          <div class="cpms-ite-con bd-color-main">满标后${product.pAuditDaysMin}~${product.pAuditDaysMax}个工作日</div>
          <div class="cpms-ite-tit bd-color-main">还款方式</div>
          <div class="cpms-ite-con bd-color-main no-border-r"><c:choose>
						<c:when test="${product.pRepayWay==1}">
							<span class="green">一次性还本付息</span>
						</c:when>
					   	<c:when test="${product.pRepayWay==2}">
						   	<span class="green">按月付息,到期还本</span>
					   	</c:when>
					   	<c:when test="${product.pRepayWay==3}">
						   	<span class="green">等额本息,每月还款</span>
					   	</c:when>
					   	<c:when test="${product.pRepayWay==4}">
						   	<span class="green">等额本金,每月还款</span>
					   	</c:when>
				       	<c:otherwise>
				       		<span class="red">自定义</span>
					   	</c:otherwise>
				  </c:choose></div>
          <div class="cpms-ite-tit bd-color-main no-border-b">手续费</div>
          <div class="cpms-ite-con no-border-b no-border-r" style="width:88%">${product.pFee}</div>
        </dd>
        <dt class="bd-color-main bg-color-s"><div class="shuxian bd-color-shuxian"></div>申请指南</dt>
        <dd class="shenqingzhinan bd-l-color-main bd-r-color-main bd-b-color-main">
        <c:forEach var="appGuide" items="${product.appGuides}">
          <div class="no-border-b">${appGuide.agDesc}</div>
        </c:forEach>
        </dd>
        <dt class="bd-color-main bg-color-s"><div class="shuxian bd-color-shuxian"></div>准备资料</dt>
        <dd class="bd-l-color-main bd-r-color-main bd-b-color-main">
        <c:forEach var="preDatas" items="${product.prepareDatas}">
           <div class="no-border-b">${preDatas.pdDesc}</div>
        </c:forEach>
        </dd>
        <dt class="bd-color-main bg-color-s"><div class="shuxian bd-color-shuxian"></div>还款指南</dt>
        <dd class="bd-l-color-main bd-r-color-main bd-b-color-main">
          <div class="no-border-b">${product.pRepayGuide}</div>
        </dd>
      </dl>
      <div class="fabujiekuan-btn"><a class="bg-color-l bd-color-main-l" href="${ctx}/loan/productsloan/project.ht?productId=${product.productsLoanId}">我要发布此借款</a></div>
    </div>
  </div>
  <div style="border-top:1px solid #dcdcdc;min-width:1000px;"></div>
  <%@ include file="/commons/includeFront/footer.jsp"%>
  <script>
  $(function(){
    $("#sidebar>ul>li:not(:first)>a").hover(function(){
      $(this).css("background-color","#fd8f59");
      var background_position_y = $(this).children("div").css("background-position").split(" ")[1];
      $(this).children("div").css("background-position","-20px " + background_position_y);
    },function(){
      var background_position_y = $(this).children("div").css("background-position").split(" ")[1];
      $(this).css("background-color","#fff9d9");
      $(this).children("div").css("background-position","0px " + background_position_y);
    }).bind("click",function(){
      $(".subsidebar").hide();
      if ($(this).next().css("display")=="none") {
        $(this).next().show();
      }else{
        $(this).next().hide();
      };
    });
  })
  </script>
</body>
</html>