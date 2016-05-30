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
		<title><%=application.getAttribute("PLATFORM_NAME")%> - 本金保障</title>
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">  
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/LegaPolicyList.css"> 
 
</head>
<body   > 
  <%@ include file="/commons/includeFront/head.jsp"%>
  <div class="container">
    <div class="weizhi-lianjie">
     <a href="${ctx }/index-web.jsp">首页</a> > <span>本金保障</span>
    </div> 
   
     <div id="body"> 
      <div id="legalpolicy-body">
        <div class="tit-box element-box bg-color-s bd-color-main"><span class="shuxian bd-color-shuxian"></span><span class="tit-xl color-main" id="title">本金保障</span></div>
       
    <div class="aboutus-con mb15 bd-b-color-main bd-r-color-main bd-l-color-main">
          <ul> 
             <c:forEach items="${cms}" var="cms">
            <li>
                <h2 class="text-orange2">${cms.contentTitle }</h2> 
                <div>${cms.contentText }</div> 
            </li>
            </c:forEach> 
          </ul>
        </div>
      </div>
    </div>
  </div> 
    <%@ include file="/commons/includeFront/footer.jsp"%>  
</body>
</html>