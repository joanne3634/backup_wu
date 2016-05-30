<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>认投资格</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
      <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  	<script type="text/javascript" src="${ctx }/crowdfunding/js/ckeditor/ckeditor.js"></script>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
			<div class="addyourproject f_l">
			<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">认投资格</h2>
			<c:if test="${isAskPrice==0}">
		         <div class="hint hintInquiry"><div>您暂时还没有认投资格！</div><h5>缴纳<%=application.getAttribute("ASK_PRICE_SINCERITY") %>元认筹诚意金，即可获得对每个项目${askPriceMaxTimes }次认筹的机会</h5>
		         <a href="javascript:void(0);" onclick="toApplyEnqPage('${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht')">立即获取资格</a></div>
			</c:if>
			<c:if test="${isAskPrice==1}">
			     <div class="hint hintP"><p>温馨提示：</p><p>① 您已获得认筹资格，现在拥有对每个项目${askPriceMaxTimes }次的机会！<c:if test="${isAskPrice==1}"> <a href="${ctx}/index-web.jsp">>>现在去认筹</a></c:if></p><p>② 温馨提示：每反悔一次，您需要重新缴纳诚意金才可以获得认投的机会！ </p></div>
			</c:if>
			<div class="TagContent">
				<div class="patternPaymentNav">
				<ul>
					<li class="PaPaNavChecked">诚意金缴纳记录</li>
					<li>我的反悔记录</li>
				</ul>
				</div>
				<div class="TagContentList">
					<iframe src="${ctx }/crowdfunding/memberCenter/toEnquiryRecords.ht" style="min-height: 500px;" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
				</div>
				<div class="TagContentList">
					<iframe src="${ctx }/crowdfunding/memberCenter/toPullBackRecords.ht" style="min-height: 500px;" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" id="iframepage1" name="iframepage1" onLoad="iFrameHeight1()" ></iframe>
				</div>
			</div>
			</div>
		<script type="text/javascript">
			$(function(){
				$(".TagContent .TagContentList").eq(0).css("display","block");
					$(".patternPaymentNav li").click(function(){
			  			$(this).addClass('PaPaNavChecked').siblings().removeClass('PaPaNavChecked');
						   var _index=$(this).index();
						  $(".TagContent .TagContentList").css("display","none");
						  $(".TagContent .TagContentList").eq(_index).css("display","block");
				});
			});
			
			function toApplyEnqPage(url){
				//var parent = window.parent;
				//parent.window.location = url;
				$.dialog.open(url, {
					title: '申请认筹资格',lock:true,width:'950px',height:'700px',close:function(){
						//window.location.reload(false);
					}
				});
			}
			
			function iFrameHeight() {
				
			    var ifm= document.getElementById("iframepage");
		
			    var subWeb = document.frames ? document.frames["iframepage"].document :
		
					ifm.contentDocument;
		
			        if(ifm != null && subWeb != null) {
		
			        ifm.height = subWeb.body.scrollHeight;
		
			        }
		
			}
			
			function iFrameHeight1() {
				
			    var ifm= document.getElementById("iframepage1");
		
			    var subWeb = document.frames ? document.frames["iframepage1"].document :
		
					ifm.contentDocument;
		
			        if(ifm != null && subWeb != null) {
		
			        ifm.height = subWeb.body.scrollHeight;
		
			        }
		
			}
		</script>
</body>
</html>
