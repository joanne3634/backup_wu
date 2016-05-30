<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html lang="en">
<head>


<title>资源下载</title>
	<meta charset="UTF-8">
	<%@include file="/commons/include/form.jsp" %>
<%@ include file="/crowdfunding/cssorjs.jsp"%>

<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/public1.css">  
<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/crowdfunding/js/jquery.attach.HelpCenter.js"></script>

</head>
<script type="text/javascript">


</script>
<style>
<!--
.attach-del {
	background:  0px 0px no-repeat !important;
	text-decoration: none;
	cursor: pointer;
	padding: 0 0 0 20px;
}
-->
      #hyht-bodyright {
        float: right;
        width: 1080px;
        color: #555;
      }
      .bodyRightBorder {
        border: 1px solid #f9d682;
      }
      .tit {
        height: 38px;
        line-height: 38px;
        font-size: 16px;
        border-bottom: 1px solid #f9d682;
        background-color: #fef9e1;
      }
      .con {
        padding: 20px 25px;
      }
      .shuxian {
        display: inline-block;
        float: left;
        position: relative;
        top: 9px;
        height: 20px;
        width: 0;
        border-left: 3px solid #ff5704;
        margin-left: 11px;
        margin-right: 11px;
      }
      .P2Pdai-con {
        margin-top: 0px;
        margin-bottom: 20px;
      }
      .P2Pdai-con li {
        padding-left: 10px;
        line-height: 64px;
        font-size: 16px;
        border-bottom: 1px solid #ccc;
        cursor: pointer;
      }
      .P2Pdai-con dd {
        padding-top: 10px;
        padding-bottom: 10px;
        padding-left: 22px;
        display: none;
      }
      .dian {
        display: inline-block;
        position: relative;
        top: -2px;
        height: 6px;
        width: 6px;
        margin-right: 8px;
        border-radius: 3px;
        background-color: #333;
        vertical-align: middle;
      }
       #sidebar ul li a.hover{
        background-color:#fd8f59;
        color: #fff;
      }
</style>
<body>	
<!-- <div style="height:191px;overflow: hidden;">
</div> -->
	<%@ include file="/crowdfunding/head.jsp"%>
<div class="container">
	<div class="hyht-body">
      <div id="hyht-bodyright" class="bodyRightBorder">
        <div class="tit"><span class="shuxian"></span><em>资源下载</em></div>
        <div class="con">
          <dl class="P2Pdai-con">
          <ul>
          <c:forEach items="${resourceDownloadList }" var="res">
          <li>
            	<a href="javascript:download('${res.filesIds }')">${res.fileNames }</a>
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
 <div class="clear" style="height:130px;overflow: hidden;">
	<%@ include file="/crowdfunding/foot.jsp"%>
</div>
</body>
</html>