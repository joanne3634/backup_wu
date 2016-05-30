<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 新手入门</title>
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/HouseholdFinanceGuideList.css"> 
  <script type="text/javascript" src="${ctx}/js/javascripts/jquery-1.11.1.min.js"></script>
</head>
<body> 
  <%@ include file="/commons/includeFront/head.jsp"%>
  <div class="container">
    <div class="weizhi-lianjie">
      <a href="index.html">首页</a> > <span>新手入门</span> > <span id="toptitle">我要理财</span>
     </div>  
      <div id="body">
      <div id="bodyleft">
        <div id="CorInf-sidebar">
          <ul>
            <li><a style="background-color:#ff5704;color:#fff;font-size:18px;">新手指引</a></li>
               <c:forEach items="${list }" var="list" varStatus="status">
               <li><a href="#" <c:if test="${status.first==true}"> class="hover" </c:if> >${list.menuName }</a>  
                  </li>
              </c:forEach> 
          </ul>
        </div>
        <div style="height:293px;margin-top:20px;"><img src="${ctx }/images/hyht_pic.png" alt=""></div>
      </div>
      <div id="bodyright" class="bodyRightBorder">
      <div id="Li" >
        <div class="tit"><span class="shuxian"></span><div id="title">我要理财</div></div>
        <div class="con">
        <pageTag:HouseholdFinanceGuideList menupath="WYLC"/>
        </div>
      </div>
         <div id="JIE" style="display: none;">
        <div class="tit"><span class="shuxian"></span><div id="title">我要借款</div></div>
        <div class="con">
       <pageTag:WantBorrowGuide menupath="WYJK2"/>
        </div>
      </div>
        <div id="AN" style="display: none;">
        <div class="tit"><span class="shuxian"></span><div id="title">安全问题</div></div>
        <div class="con">
       <pageTag:SafetGuaranteeGuide menupath="AQBZ"/>
        </div>
      </div> 
      </div>
    </div>
  </div>
  <div style="border-top:1px solid #dcdcdc;min-width:1000px;"></div> 
  <script>
  $(function(){
    $("#CorInf-sidebar>ul>li:not(:first)>a").click(function(){
      $("#CorInf-sidebar>ul>li:not(:first)>a").removeClass("hover");
      $(this).addClass("hover");   
      $("#toptitle").html($(this).html());  
      if($(this).html()=='我要借款'){
      $("#Li").hide(); 
      $("#AN").hide(); 
      $("#JIE").show(); 
      }else { 
    	  if($(this).html()=='我要理财'){ 
    	  $("#Li").show(); 
          $("#JIE").hide();   
          $("#AN").hide(); 
      }else{
    	  $("#AN").show(); 
          $("#JIE").hide();   
          $("#Li").hide();  
      }}
      });
   
  })
  </script> 
    <%@ include file="/commons/includeFront/footer.jsp"%>  
</body>
</html>