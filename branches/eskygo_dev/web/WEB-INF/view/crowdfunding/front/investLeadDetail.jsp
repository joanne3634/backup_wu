<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>投后查看</title>
	<meta name="renderer" content="webkit"/>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
  	<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.2.min.js"></script>
  	<script type="text/javascript" src="${ctx }/crowdfunding/artDialog/jquery.artDialog.js?skin=default"></script>
	<script type="text/javascript" src="${ctx }/crowdfunding/artDialog/iframeTools.js"></script>
  	<script type="text/javascript">
    function approveProjectApply(projectId,investId,processType){
    	var denyReaSon = $("#denyReaSon").val();
    	if(processType==1){
    		denyReaSon="";
    	};
		jQuery.ajax({
			url : "${ctx}/crowdfunding/projectApply/approveCheckTheLead.ht?time="+new Date(),
			type : "post",
			data: "projectId="+projectId+"&investId="+investId+"&processType="+processType+"&denyReaSon="+denyReaSon,
			success : function(data) {
				art.dialog({
					content:data,
					ok:function(){
						art.dialog.close();
						art.dialog.open.origin.location.reload(true);	
					}});
			}
		});	
}
    
  	
  	</script>
</head>
<body>
	<div class="ItemSeDe">
		<div>
			<div class="ItemSeDeImg f_l">
			<c:if test="${not empty tcprojectInvest.myPhoto }">
				<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${tcprojectInvest.myPhoto}">
			</c:if>
			<c:if test="${empty tcprojectInvest.myPhoto }">
				<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
			</c:if>
			</div>
			<div class="ItemSeDeMessage f_l">
				<p>${tcprojectInvest.realName }</p>
				<div>领投金额：<span>
				<c:choose>  
				 <c:when test="${fn:contains(tcprojectInvest.piinvest/10000,'.')}">
				 ${fn:substringBefore(tcprojectInvest.piinvest/10000,".")}万
				 </c:when>  
				 <c:otherwise>${tcprojectInvest.piinvest/10000}万</c:otherwise>
				</c:choose>
				
				</span>估值金额：<span>
				<c:choose>  
				 <c:when test="${fn:contains(tcprojectInvest.pivaluation/10000,'.')}">
				 ${fn:substringBefore(tcprojectInvest.pivaluation/10000,".")}万
				 </c:when>  
				 <c:otherwise>${tcprojectInvest.pivaluation/10000}万</c:otherwise>
				</c:choose>
				</span>领投时间：<span>
				<fmt:formatDate value="${tcprojectInvest.piinvestTime}" pattern="yyy-MM-dd HH:mm"/>
				</span></div>
				<div>是否付款：<span>
				<c:if test="${tcprojectInvest.piisPay==0}">否</c:if>
				<c:if test="${tcprojectInvest.piisPay==1}">是</c:if>
				
				</span>是否反悔：<span>
				<c:if test="${tcprojectInvest.piisCancel==0}">否</c:if>
				<c:if test="${tcprojectInvest.piisCancel==1}">是</c:if>
				</span>是否询价：<span>
				<c:if test="${tcprojectInvest.piisAskPrice==0}">否</c:if>
				<c:if test="${tcprojectInvest.piisAskPrice==1}">是</c:if>
				</span>是否愿意担任有限合伙企业普通合伙人：<span>
				<c:if test="${tcprojectInvest.piisGeneralPartner==0}">否</c:if>
				<c:if test="${tcprojectInvest.piisGeneralPartner==1}">是</c:if>
				</span></div>
			</div>
			<div class="clear ItemSeDetextarea">
				<div>投资理由：<span>${tcprojectInvest.pireasons }</span></div>
				<div>我能为项目方提供帮助：<span>${tcprojectInvest.pimyHelp }</span></div>
				<%--<div>我能为项目方提供非资金帮助：<span>项目的调查研究！<span></div>
				--%><div>拒绝理由：<div><textarea id="denyReaSon" cols="90" rows="5">${tcprojectInvest.pidenyReason }</textarea></div></div>
			</div>
		</div>
	<div class="faqbutton">
	    <div class="submit" onclick="approveProjectApply(${tcprojectInvest.projectId},${tcprojectInvest.investId },1)">同意</div> 
	    <div class="submit" onclick="approveProjectApply(${tcprojectInvest.projectId},${tcprojectInvest.investId },2)">拒绝</div>
	</div>
	</div>
</body>
<script type="text/javascript">

</script>
</html>