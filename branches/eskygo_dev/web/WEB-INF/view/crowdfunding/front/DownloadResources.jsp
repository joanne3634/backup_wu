<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html lang="en">
<head>


<title>资源下载</title>
	<meta charset="UTF-8">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/public1.css">  
<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />


</head>
<script type="text/javascript">


</script>
<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/DownloadResources.css" />" type="text/css">
<style>

</style>
<body>	
<!-- <div style="height:191px;overflow: hidden;">
</div> -->
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="DownloadResources" class="container">
	<div class="hyht-body">
      <div id="hyht-bodyright" class="">
        <div class="tit"><span class="shuxian"></span><em>资源下载</em></div>
        <div class="con">
          <dl class="P2Pdai-con">
          <ul>
          <c:forEach items="${resourceDownloadList }" var="res">
          <li>
            	<a href="javascript:download('${res.filesIds }')"><i class="fa fa-caret-right" style="margin-left:3em;margin-right:1em;"></i>${res.fileNames }</a>
           </li>
            </c:forEach>
            </ul>
          </dl>
        </div>
      </div>
    </div>
  </div>
<!-- 	<dl class="P2Pdai-con" style="height: 550px;"> -->
<%-- 		<c:forEach items="${Details }" var="details"> --%>
<!-- 			<dt> -->
<%-- 				<span class="dian"></span>${details.contentTitle } --%>
<!-- 			</dt> -->
<!-- 				<dd style="display: block;"> -->
<!-- 					<div> -->
<!-- 						<input type="text" name="contentFileIds" id="contentFileIds" class="attach" -->
<%-- 							attachType="2" value="${details.contentFileIds}" /> --%>
<!-- 					</div> -->
<!-- 					<div class="clear"></div> -->
<!-- 				</dd> -->
<%-- 		</c:forEach> --%>
<!-- 	</dl> -->
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/DownloadResources.js" />"></script>
</body>
</html>