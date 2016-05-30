<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>投后管理-投资者</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<%@include file="/commons/include/form.jsp" %>
    <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/investmessage.css">	
  	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/crowdfunding/js/jquery.attach.HelpCenter.js" ></script>
   	<style type="text/css">
   	     .AfinIframe .dian {
        display: inline-block;
        position: relative;
        top: -2px;
        height: 6px;
        width: 6px;
        margin-right: 8px;
        border-radius: 3px;
        background-color: #333;
        vertical-align: middle;
        padding:0px;
      }
            body{
      	max-height:850px;
      	overflow-y:scroll;
      }
         	</style>
</head>
<body>
	<div class="InMeDeLeft f_l">
			<h2>
			${tcprojectAfter.paTitle }
			</h2>
			<div class="AfinIframe">附件下载：
<!-- 			<c:if test="${!empty dataList }">
			<c:forEach items="${dataList }" var ="pr">
			${pr[1]}</em><span onclick="downloadFile(${pr[0]})">下载
			</c:forEach>
			</c:if> -->
			
			
            <input type="text" name="fileId" id="fileId" class="attach" attachType="2" value="${tcprojectAfter.fileId}" />
			
			
			
			</div><%--
			<img src="./Skin/Default/images/detailsImg.png">
			--%>
			<p>${tcprojectAfter.paContent }</p>
		</div>



</body>
</html>
