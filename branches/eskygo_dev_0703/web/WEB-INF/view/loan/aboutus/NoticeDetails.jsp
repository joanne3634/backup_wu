<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html> 
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
   <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/NoticeDetails.css">
    <script type="text/javascript" src="${ctx}/js/javascripts/jquery-1.11.1.min.js"></script>
	 <style type="text/css">
	#bodyright{
	 width:831.5px;
	} 
</style>
      <div id="bodyright" class="bodyRightBorder">
        <h1>${cms.contentTitle }</h1>
        <div>发布时间：<div> <fmt:formatDate value="${cms.contentUpdateDate }" pattern="yyyy-MM-dd HH:mm"/></div>来源：<div>${cms.contentAuthor}</div></div>
      ${cms.contentText}      </div>
    </div>  