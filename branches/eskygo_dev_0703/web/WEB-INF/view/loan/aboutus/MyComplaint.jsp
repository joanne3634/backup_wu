<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commons/includeFront/taglibs.jsp"%>
	<%@include file="/commons/include/html_doctype.html" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8"> 
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
	<%@include file="/commons/include/get.jsp" %>
    <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/style.css"> 
</head>

<body>
<div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">我的投诉</span></div>
    <div class="leaveList text-center con-box bd-b-color-main bd-l-color-main bd-r-color-main">
      <ul>
        <li style="padding-left:15px;">
          <div class="leaceType">举报项目</div>
          <div class="leaceCont">举报原因</div>
          <div class="leaceTime">备注说明</div>
          <div class="leaceOper">操作</div>
        </li>
        <c:forEach items="${ list}" var="TuserReport">
      <li>
          <div class="leaceType"><pageTag:TprojectDetails menupath=" ${TuserReport.projectId}"/> </div>
          <div class="leaceCont">${TuserReport.reportReason}</div>
          <div class="leaceTime"> ${TuserReport.remarks}  </div>
          <a href="${ctx }/loan/sysManager/usersToReport/MyComplaintDetails.ht?userid=${TuserReport.reportId}"><div class="leaceOper recharge">查看跟进记录</div></a>
     </li>
        </c:forEach> 
      </ul>
    </div>
     <form action="" name="pageForm" id="pageForm">
<pageTag:paging form="pageForm"/>
</form>
</body>
</html>