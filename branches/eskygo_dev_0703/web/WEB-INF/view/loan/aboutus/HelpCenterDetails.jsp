<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html lang="en">
<head>


<title>安全中心</title>
	<meta charset="UTF-8">

<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@include file="/commons/include/form.jsp" %>
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/public1.css">
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/crowdfunding/js/jquery.attach.HelpCenter.js" ></script>
</head>
<style>
<!--
.attach-del {
	background:  0px 0px no-repeat !important;
	text-decoration: none;
	cursor: pointer;
	padding: 0 0 0 20px;
}
-->
</style>
<body>	
<input type="hidden" name="menupath" value="${menu_path}"/>
<dl class="P2Pdai-con">
	<c:forEach items="${Details }" var="details">
		<dt>
			<span class="dian"></span>${details.contentTitle }
		</dt>
		<c:if test="${details.siteMenuId == 10000014870012}">
			<dd>
				<div>
					<input type="text" name="contentFileIds" id="contentFileIds" class="attach"
						attachType="2" value="${details.contentFileIds}" />
				</div>
				<div class="clear"></div>
			</dd>
		</c:if>
		<c:if test="${details.siteMenuId != 10000014870012}">
			<dd>${details.contentText }</dd>
		</c:if>
	</c:forEach>
</dl>
<script>
$(function(){
    $("#sidebar>ul>li:not(:first)>a").bind("click",function(){
      $("#sidebar>ul>li:not(:first)>a").removeClass("hover");
      $(this).addClass("hover");
      $(".tit em").text($(this).text());
    });

    $(".P2Pdai-con dt").mouseover(function(){
      $(this).css("background-color","#fef9e1");
    }).mouseout(function(){
      $(this).css("background-color","#fff");
    }).click(function(){
    	
      $(".P2Pdai-con dt").css("color","#555").css("font-size","16px").css("border-bottom","1px solid #ccc").find("span").css("background-color","#333");
      $(".P2Pdai-con dd").hide();
      $(this).css("color","#ff5200").css("font-size","18px").find("span").css("background-color","#ff5200");
      $(this).css("border-bottom","none").next().show().css("border-bottom","1px solid #ccc").css("padding-top","0");

      parent.iFrameHeightSub($("dl.P2Pdai-con").height());
    })
  })
</script></body></html>