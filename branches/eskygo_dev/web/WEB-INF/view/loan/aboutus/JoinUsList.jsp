<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html> 
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
    <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/JoinUsList.css"> 
 
        <div class="con">
          <ul>
          <c:forEach items="${cms}" var="cms">
            <li>
                <h2>${cms.contentTitle }</h2>
                ${cms.contentText}
                 </li>
            </c:forEach>
          </ul>
        </div>
       