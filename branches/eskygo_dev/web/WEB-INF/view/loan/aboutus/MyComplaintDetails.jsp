<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="/commons/include/get.jsp" %>
	<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>我的投诉</title> 
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
    <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/style.css"> 
</head>

<body>
<div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">我的投诉</span></div>
    <div class="ldetailList text-left bd-b-color-main bd-r-color-main bd-l-color-main">
      <ul>
        <li class="borderdashed">
        <h3 class="text-center">我的投诉</h3>
        <div>管理员跟进状态：<span> <f:description itemValue="${list.stateId }" nodeKey="TSZT" /></span>  <span class="ldetailListTime"> 投诉的项目：<pageTag:TprojectDetails menupath=" ${list.projectId}"/></span></div>
        </li>
        <li class="borderdashed">
        <h3 >举报原因：</h3>
          ${list.reportReason}
        </li>
        <li >
        <h3 >备注说明：</h3>
           ${list.remarks}
        </li>
      </ul>
    </div>
</body>
</html>