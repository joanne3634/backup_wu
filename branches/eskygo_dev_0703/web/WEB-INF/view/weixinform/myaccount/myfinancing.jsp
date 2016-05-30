<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.deelon.core.util.AppUtil" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>我的理财</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	  	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>

	<body onload="viewStatus();">
		<div class="top">
		<div class="fintop"></div>
		</div>

		<div class="textdiv bodersolid2 ">
			<ul class="ulbutton text-center">
				<li class="text-white background1 radiusleft" id="dsk" onclick="getProjectInvest(0);">代收款</li>
				<li class="text-black2" id="zzskz" onclick="getProjectInvest(1);">正在收款中</li>
				<li class="text-black2 radiusright" id="yhq" onclick="getProjectInvest(2);">已还清</li>
			</ul>
		</div>

		<div class="content text-center text-black2">
			<c:forEach var="projectInvest" items="${tpojectInvestList }">
			<div class="contentList">
				<ul>
					<li class="boderright">
						<div class="text-gray">借入者</div>
						<div>${projectInvest.loginName }</div>
					</li>
					<li>
						<div>期数/总期数</div>
						<div>${projectInvest.prCurrent }/${projectInvest.pDeadline}</div>
					</li>
					<li class="boderright">
						<div>还款日</div>
						<div><fmt:formatDate value="${projectInvest.paPayBackTime }" pattern="yyyy-MM-dd"/></div>
					</li>
					<li>
						<div>本金/利息</div>
						<div>${projectInvest.piBeGetPrincipalSum }元/${projectInvest.piBeGetRateSum }元</div>
					</li>
				</ul>
				<div class="clear"></div>
			</div>
			</c:forEach>
		</div>
		
	</body>
	<script type="text/javascript">
	//初始进入该页面时onload，指定栏目
	function viewStatus(){
		var projectStatus = "${projectStatus}";
		$(".ulbutton li").removeClass("text-white background1");
		$(".ulbutton li").addClass("text-black2");
		if("0" == projectStatus){
			$("#dsk").addClass("text-white background1");
			$("#dsk").removeClass("text-black2");
		}else if("1" == projectStatus){
			$("#zzskz").addClass("text-white background1");
			$("#zzskz").removeClass("text-black2");
		}else if("2" == projectStatus){
			$("#yhq").addClass("text-white background1");
			$("#yhq").removeClass("text-black2");
		} 
	}
	$(function(){
		$(".ulbutton li").click(function(){
			$(".ulbutton li").removeClass("text-white background1");
			$(".ulbutton li").addClass("text-black2");
			$(this).addClass("text-white background1");
			$(this).removeClass("text-black2");
		});
	});
	
	//项目状态相应列表
	function getProjectInvest(projectStatus){
		var piHavedPay = "";
		var piIsPayOff = "";
		var piTransferStateId = "";
		if(0 == projectStatus){
			piHavedPay = "1";//已完成打款
			piTransferStateId = "0";//未转让
		}else if(1 == projectStatus){
			piHavedPay = "1";
			piTransferStateId = "0";
		}else if(2 == projectStatus){
			piIsPayOff = "1";//0=未还清，1=已还清
		}
		var url = "${ctx}/weixin/wxmyfinancing/myFinancingPage.ht" +
					"?projectStatus=" + projectStatus + "&piHavedPay=" + piHavedPay
					+ "&piIsPayOff=" + piIsPayOff + "&piTransferStateId=" + piTransferStateId;
		window.location.href = url;
	}
	</script>
</html>