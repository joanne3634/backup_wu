<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>项目管理</title>
	<meta name="renderer" content="webkit"/>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
    <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   	<script type="text/javascript" src="${ctx }/crowdfunding/artDialog/jquery.artDialog.js?skin=default"></script>
   	<script type="text/javascript" src="${ctx }/crowdfunding/artDialog/iframeTools.js"></script>
   	<script>
function iFrameHeight() {
    var ifm= document.getElementById("iframepage");
    var frames = document.frames;
    var subWeb = (frames=null && typeof(frames) != 'undefined')? document.frames["iframepage"].document :
			ifm.contentDocument;
        if(ifm != null && subWeb != null) {
            ifm.height = subWeb.body.scrollHeight;
        }
    window.parent.iFrameHeight();   
}
</script>
</head>
<body>
	<div class="PrDyBack f_l">
		<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">项目管理</h2>
		<div class="patternPaymentNav">
			<ul>
				<li class="PaPaNavChecked" onclick="loadDates1('${ctx}/crowdfunding/front/tcprojectinvest/collectProj.ht');">收藏的项目</li>
				<li onclick="loadDates1('${ctx}/crowdfunding/front/tcprojectinvest/aboutProj.ht');">约谈的项目</li>
				<li onclick="loadDates1('${ctx}/crowdfunding/front/tcprojectinvest/leadProj.ht');">领投的项目</li>
				<li onclick="loadDates1('${ctx}/crowdfunding/front/tcprojectinvest/voteProj.ht');">跟投的项目</li>
				<li onclick="loadDates1('${ctx}/crowdfunding/front/tcprojectinvest/finishProj.ht');">完成的项目</li>
				<li onclick="loadDates1('${ctx}/crowdfunding/front/tcprojectinvest/refuseProj.ht');">拒绝的认投</li>
			</ul>
		</div>
		<div class="PrManaContentTag">
		  <c:if test="${flag=='voteTou'}">
		  <div class="qiehuan">
			       <iframe src="${ctx}/crowdfunding/front/tcprojectinvest/voteProj.ht" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
		      </div>
		  </c:if>
		  <c:if test="${empty flag}">
		  <div class="qiehuan">
			       <iframe src="${ctx}/crowdfunding/front/tcprojectinvest/collectProj.ht" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
		      </div>
		  </c:if>
		</div>
	</div>
	<script type="text/javascript">
	 function loadDates1(url){
			  $("#iframepage").attr("src", url);
		  }
	$(function(){
		$(".PrManaContentTag .qiehuan").eq(0).css("display","block").siblings().css("display","none");
		$(".patternPaymentNav li").click(function(){
			  $(this).addClass('PaPaNavChecked').siblings().removeClass('PaPaNavChecked');
			  var _index= $(this).index();
			  $(".PrManaContentTag .qiehuan").eq(_index).css("display","block").siblings().css("display","none");
		});
	})
	</script>
</body>
</html>
