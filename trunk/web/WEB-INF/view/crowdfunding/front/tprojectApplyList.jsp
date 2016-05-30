<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fnd" uri="http://www.deelon.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>项目设置列表</title>
	<meta name="renderer" content="webkit"/>
  	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
	<div class="PrDyBack f_l">
		<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">项目设置</h2>
		
		<div class="itemSetting">
			<ul>
			<c:forEach items="${tcprojectApplyList}" var="pr">
				<li>
					<div class="f_l" style="cursor: pointer;" onclick="window.open('${ctx}/crowdfunding/front/toProDetails.ht?projectId=${pr.projectId }')">
					<c:choose>
						<c:when test="${empty pr.ppic}">
							<img src="${ctx }/crowdfunding/Skin/Default/images/case3.png" class="innovationimg">
						</c:when>
						<c:otherwise>
							<pageTag:projectPic menupath="${pr.projectId }"/>
						</c:otherwise>
					</c:choose>				
					</div>
					<div class="itemSettingcontent f_l">
						<h4 style="cursor: pointer;" onclick="window.open('${ctx}/crowdfunding/front/toProDetails.ht?projectId=${pr.projectId }')">${pr.pname }</h4>
						<div class="itemSettingMoeny"><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">&nbsp;&nbsp;
						融资金额：<fmt:formatNumber value="${pr.pfinancingAmount / 10000}" pattern="###,###"  minFractionDigits="0"  ></fmt:formatNumber>万&nbsp;&nbsp;&nbsp;&nbsp;
						认投金额：<fmt:formatNumber value="${pr.pinvestAmount / 10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>万&nbsp;&nbsp;&nbsp;&nbsp;认投完成率： ${pr.pcomplete }% </div>
						<div class="itemSettingNO">接受领投：<span>${pr.agreeLead }/${pr.allLead }</span>个&nbsp;&nbsp;&nbsp;&nbsp;接受跟投：<span>${pr.agreeFollow }/${pr.allFollow }</span>个&nbsp;&nbsp;&nbsp;&nbsp;
						申请查看：<span>${pr.agreeView }/${pr.allView }</span>个</div>
						<div id="${pr.projectId }"  class="itemSettingButton"><span>查看领投</span><span>查看跟投</span><span>查看申请</span></div>
					</div>
					<div class="clear"></div>
				</li>
				</c:forEach>
				
			</ul>
		</div>
		<form action=""   name="pageForm" id="pageForm" method="post">
		<pageTag:paging form="pageForm"/>
	</div>
	
</body>
</html>
<script type="text/javascript">
$(function(){
	$(".itemSettingButton span").click(function(){
		var projectId=$(this).parent().attr("id");
		if($(this).index()==0){
			$.dialog.open('${ctx}/crowdfunding/projectApply/checkTheLeadList.ht?projectId='+projectId, {
			title: '查看领投',lock:true,width:'880px',close : function () {
	             art.dialog.open.origin.location.reload(true);}});
		}else if($(this).index()==1){
			$.dialog.open('${ctx}/crowdfunding/projectApply/checkTheFollowList.ht?projectId='+projectId, {
			title: '查看跟投',lock:true,width:'880px',close : function () {
	             art.dialog.open.origin.location.reload(true);
	        }});
		}else if($(this).index()==2){
			$.dialog.open('${ctx}/crowdfunding/projectApply/checkTheViewList.ht?projectId='+projectId, {
			title: '查看申请',lock:true,width:'880px',close : function () {
	             art.dialog.open.origin.location.reload(true);}});
		}
	}); 
});


function clearForm(userId){
	$("#pname").val("");
	$("#ptypeId").val("");
}
function submitForm(userId){
	$("#pageForm").submit();
}
</script>
