<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
  <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/public1.css"> 
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
	</head>
	<body>
      <ul class="search-index">   
          <c:forEach items="${list }" var="list">
           <li>
                 <div class="search-index-tit">
	                 	${list.menuName}
                 </div>
                 <pageTag:HelpCenterListcenten menupath="${list.menuPath }"/>
             </li>
          </c:forEach> 
          
          </ul>
          <div class="clear"></div>
     </body>
     </html>   