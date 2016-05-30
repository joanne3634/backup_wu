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
		<title>我的借款</title>
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
				<li class="text-white background1 radiusleft" id="all" onclick="getBorrowProject(0);">全部</li>
				<li class="text-black2 bodersolid ulbuttonli" id="thirty" onclick="getBorrowProject(30);">最近30天</li>
				<li class="text-black2 radiusright" id="ninety" onclick="getBorrowProject(90);">最近90天</li>
			</ul>
		</div>

		<div class="content text-center text-black2">
		<c:forEach var="bproject" items="${borrowProject }">
			<div class="contentList">
				<ul>
					<li class="boderright">
						<div class="text-gray">借款项目名称</div>
						<div>${bproject.pname }</div>
					</li>
					<li>
						<div>借款金额</div>
						<div>${bproject.ploan }元</div>
					</li>
					<li class="boderright">
						<div>年利率</div>
						<div>${bproject.prateIn }%</div>
					</li>
					<li>
						<div>投资到期日</div>
						<div><fmt:formatDate value="${bproject.pcloseDate }" pattern="yyyy-MM-dd"/></div>
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
		var recentDays = "${recentDays}";
		$(".ulbutton li").removeClass("text-white background1");
		$(".ulbutton li").addClass("text-black2");
		if("0" == recentDays){
			$("#all").addClass("text-white background1");
			$("#all").removeClass("text-black2");
		}else if("30" == recentDays){
			$("#thirty").addClass("text-white background1");
			$("#thirty").removeClass("text-black2");
		}else if("90" == recentDays){
			$("#ninety").addClass("text-white background1");
			$("#ninety").removeClass("text-black2");
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
	function getBorrowProject(recentDays){
		var days = 0;
		if(0 == recentDays){
			days = 0;
		}else if(30 == recentDays){
			days = 30;
		}else if(90 == recentDays){
			days = 90;
		}
		var url = "${ctx}/weixin/wxmyborrow/myborrowPage.ht?recentDays="+days;
		window.location.href = url;
	}
	</script>
</html>