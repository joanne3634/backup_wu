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
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/LinksList.css">
    <script type="text/javascript" src="${ctx}/js/javascripts/jquery-1.11.1.min.js"></script>
 
        <div class="con">
           <c:forEach items="${cms}" var="cms">
            <c:if test="${cms.contentUrl==null||cms.contentUrl==''}">
            <a href="javascript:void(0)"><pageTag:TraversalFileId menupath="${cms.contentFileIds}"/><div class="cooperatingAgency-tit">${cms.contentTitle }</div></a>
            </c:if>
           <c:if test="${cms.contentUrl!=null&&cms.contentUrl!=''}">
          <a href="${cms.contentUrl}" target="_top"> 
          <pageTag:TraversalFileId menupath="${cms.contentFileIds}"/><div class="cooperatingAgency-tit">${cms.contentTitle }</div></a>
          </c:if>
        </c:forEach>
        </div>
           <form action="" name="pageForm" id="pageForm">
<pageTag:paging form="pageForm"/>
</form>