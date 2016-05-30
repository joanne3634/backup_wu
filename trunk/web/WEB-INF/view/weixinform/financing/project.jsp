<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.deelon.core.util.AppUtil" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>投资项目</title>
  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
  	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
	<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
</head>

<body onload="sortSpan();">
	<div class="top">
	<div class="fintop"></div>
	</div>

	<div class="textdiv2 bodersolid2 ">
		<ul class="ulbutton text-center">
			<li class="text-white background1 radiusleft">默认</li>
			<li class="text-black2 bodersolid ulbuttonli" id="sortQx" sort="asc" onclick="orderBy('sortQx','${ctx}/weixin/wxfinancing/wxfinancingPage.ht','qixian');">期限<span id="qixian">↑</span></li>
			<li class="text-black2 radiusright" id="sortJe" sort="asc" onclick="orderBy('sortJe','${ctx}/weixin/wxfinancing/wxfinancingPage.ht','qtje');">起投金额<span id="qtje">↑</span></li>
		</ul>
	</div>

	<div class="content">
	<c:forEach var="project" items="${projects}">
		<div class="contentList">
			<p class="pname textoverflow text-black" 
			onclick="locationPage('${ctx}/weixin/wxfinancing/showProjectDetail.ht?projectId=${project.projectId}&applicationId=${project.papplicant}');">
			${project.pname}</p>
			<div class="pclleft"></div>
			<div class="pclright text-left">
				<div class="pclright1 text-gray">借款金额</div>
					<div class="pclright2 text-gray">年化收益率</div>
					<div class="pclright3 text-gray">借款时间</div>
					<div class="pclright4 text-orange2">${project.ploan}元</div>
					<div class="pclright5 text-green">${project.prateOut}%</div>
					<div class="pclright6 text-black">${project.pdeadline}个月</div>
				<div class="clear"></div>
				<div class="progdiv">
					<div class="progname text-gray">进度</div>
					<div class="progwidth progressbar"><div class="progwidth2 progressbar2" style="width: ${project.pcomplete}%;"></div></div>
					<div class="prog text-green">${project.pcomplete}%</div>
					<div class="biding radiu background4 text-white text-center" onclick="locationPage('${ctx}/weixin/wxfinancing/showProjectDetail.ht?projectId=${project.projectId}&applicationId=${project.papplicant}');">
						投标中
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		</c:forEach>
		
	</div>
</body>

<script type="text/javascript">
	
	function sortSpan(){
		var sort = '${sort}';
		var typeId = '${typeId}';
		if(typeId != null && typeId == "qixian" && sort == "asc"){
			$("#"+typeId).html("↑");
			$("#"+typeId).attr('sort','asc') ;
		}else if(typeId != null && typeId == "qixian" && sort == "desc"){
			$("#"+typeId).html("↓");
			$("#"+typeId).attr('sort','desc') ;
		}
		
		if(typeId != null && typeId == "qtje" && sort == "asc"){
			$("#"+typeId).html("↑");
			$("#"+typeId).attr('sort','asc') ;
		}else if(typeId != null && typeId == "qtje" && sort == "desc"){
			$("#"+typeId).html("↓");
			$("#"+typeId).attr('sort','desc') ;
		}
		
	}
	
	function locationPage(p){
		var parent = window.parent;
		parent.window.location = p;
	}
	
	function orderBy(obj, url, spanid){
		//var sortType =  $("#"+obj).attr('sort') ;
		var sortType = "${sort}";
		if(sortType){
			if(sortType=='asc'){
				$("#"+obj).attr('sort','desc') ;
			}else{
				$("#"+obj).attr('sort','asc') ;
			}
		}else{
			$("#"+obj).attr('sort','asc') ;//默认升序 asc  
		}
		sortType=$("#"+obj).attr('sort') ;
		
		if(sortType=='asc'){
			$("#"+spanid).html("↑");
		}else{
			$("#"+spanid).html("↓");
		}
		window.location.href = url + "?sort=" + sortType + "&typeId=" + spanid;
	}
</script>
</html>