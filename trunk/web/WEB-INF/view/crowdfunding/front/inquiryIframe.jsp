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
	<title>询价认筹</title>
	<meta name="renderer" content="webkit"/>
  	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
  	<%-- <script type="text/javascript" src="${ctx }/crowdfunding/js/jquery-1.8.3.js"></script> --%>
    <script type="text/javascript" src="${ctx }/crowdfunding/artDialog/jquery.artDialog.js?skin=default"></script>
    <script type="text/javascript" src="${ctx }/crowdfunding/artDialog/iframeTools.js"></script>
    <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
<div id="InquiryWindow"> 
	<div>
		<div id="content_hi">
	<%-- 	<c:if test="${alreadyInveLeader eq '' }"> --%>
			<div class="InquiryIframeLeft f_l">
				<p>温馨提示：每个项目有${askPriceMaxTimes }次询价的机会,被创业者拒绝${askPriceMaxTimes }次后，您将不能再询价，只能以最终估值认筹该项目，请慎重填写您能接受的项目估值！</p>
				<div>
				
			<c:if test="${askPriceNum >0 }">
				<input type="radio" onchange="changevalue()"  checked="checked" id="yesAsk_id" name="yesAsk" value="1" />询价
			</c:if>
				<input type="radio" onchange="changevalue1()" id="noAsk_id" name="yesAsk" value="0"/>不参与询价无条件接受项目最终估值</div>
			</div>
			<div class="InquiryIframeRight f_r">该项目剩余询价机会<div>
			<c:choose>
				<c:when test="${askPriceNum >0 }">${askPriceNum }</c:when>
				<c:otherwise>0</c:otherwise>
			</c:choose>
			次</div></div>
		<%-- </c:if> --%>
		<%-- <c:if test="${alreadyInveLeader ne '' }">
			<div id="waning_hi" style="font-size: 16px;color: #666;text-align: center;">您已经领投过该项目  或领投申请正在审核中,一个项目只能领投一次!</div>
		</c:if> --%>
		</div>
		<input type="hidden" id="askPriceNum" value="${askPriceNum }"/>
		<input type="hidden" id="piisLeader" value="${piisLeader }"/>
		<input type="hidden" id="projectId" value="${projectId }"/>
	</div>
	<div id="waning_hi" style="font-size: 16px;color: #666;text-align: center;display:none;">该项目您的询价机会已经用完!</div>
	<div class="clear"></div>
	
	<div class="faqbutton">
	<%-- <c:if test="${alreadyInveLeader eq '' }"> --%>
	    <div class="submit" id="next_hi" onclick="next_win();">下一步</div>
	 <%-- </c:if> --%>
	    <div class="cancel" onclick="closediv()">取消</div>
	</div>
	
</div>
	<script type="text/javascript">
		function closediv(){
			var list = window.parent.art.dialog.list;
			for (var i in list) {
			    list[i].close();
			};
		}
		  /* $(function(){
			
			
		});   */
		  
		  function next_win(){
			  var yesorno=$('input:radio[name="yesAsk"]:checked').val();
				var askPriceNum=$("#askPriceNum").val();
				var piisLeader=$("#piisLeader").val();
				var projectId=$("#projectId").val();
				if(askPriceNum=='0'||askPriceNum<=0){//如果没有询价机会则提示
					$("#content_hi").hide();
					$("#waning_hi").show();
					$("#next_hi").hide();
				}else{
					var url='${ctx }/crowdfunding/front/openinquiryIframeNext.ht?yesAsk='+yesorno+"&askPriceNum="+askPriceNum+"&piisLeader="+piisLeader+"&projectId="+projectId;
					//	$(".submit").click(function(){
					$.dialog.open(url, {
			    	title: '询价认筹',lock:true});	
				}
				if(yesorno==0){
					var url='${ctx }/crowdfunding/front/openinquiryIframeNext.ht?yesAsk='+yesorno+"&askPriceNum="+askPriceNum+"&piisLeader="+piisLeader+"&projectId="+projectId;
					//	$(".submit").click(function(){
					$.dialog.open(url, {
			    	title: '询价认筹',lock:true});	
				}
				
		//	});
		  }
		
		function changevalue(){
			$("#yesAsk_id").val("1");
			$("#noAsk_id").val("");
		}
		function changevalue1(){
			$("#yesAsk_id").val("");
			$("#noAsk_id").val("0");
		}
	</script>
</body>
</html>
