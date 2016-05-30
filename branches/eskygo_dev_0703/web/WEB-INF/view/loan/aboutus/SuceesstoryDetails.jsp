<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="f" uri="http://www.deelon.com/functions"%>
<%@ taglib prefix="pageTag" tagdir="/WEB-INF/tags/pageTag"%>
<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>  
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
      <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/Successtory.css"> 
 
      <div id="bodyright" class="datums">
        <h1>${TUserSuccessstory.subject }</h1>
        <div class="datum background1 radiu">
          <div class="datumer text-orange2" style="width: 70px;">分享人资料</div>
          <div class="datumright">
          <div id="name">用户名：<span><f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${TUserSuccessstory.userId }"/></span></div>
          <div id="age">年龄：<span><f:description modelCode="t_user"  modelPropertyName="age" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${TUserSuccessstory.userId }"/> </div>
          <div id="time">所在单位：<span><pageTag:SuccessStory menupath="${TUserSuccessstory.userId }" />  </span></div>
          <div id="name">所在部门：<span><pageTag:SuccesStoryDetails menupath="${TUserSuccessstory.userId }" /> </span></div>
           <div id="time">发布时间：<span><fmt:formatDate value="${TUserSuccessstory.createTime}" pattern="yyyy-MM-dd"/></span></div> 
          </div>
        </div> 
      <p>${TUserSuccessstory.shareContent} </p>     </div>
    </div>
  