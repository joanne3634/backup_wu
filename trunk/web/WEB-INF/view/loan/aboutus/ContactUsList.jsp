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
   <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/ContactUsList.css"> 
    <script type="text/javascript" src="${ctx}/js/javascripts/jquery-1.11.1.min.js"></script>
 
        <div class="con">
          <dl>
            <dt>&nbsp;&nbsp;<%=application.getAttribute("PLATFORM_NAME")%></dt> 
            <pageTag:ContactUs menupath="众筹"/>
          </dl>
          <dl>
            <dt>&nbsp;&nbsp;公司网址</dt>
            <pageTag:ContactUs menupath="公司网址"/>
          </dl>
          <dl>
            <dt>&nbsp;&nbsp;客服电话</dt>
           <pageTag:ContactUs menupath="客服电话"/>
          </dl>
          <dl>
            <dt>&nbsp;&nbsp;其他联系方式</dt>
            <pageTag:ContactUs menupath="其他联系方式"/>
          </dl>
        </div>
