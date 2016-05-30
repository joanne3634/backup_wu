<%@page import="com.deelon.loan.model.front.TUser"%>
<%@page import="com.deelon.loan.util.TUserUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<%
TUser  u=TUserUtil.getLogUser( request );
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>我的账号</title>
  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
  	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
	<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
</head>

<body>
	<div class="top text-white text-center">我的账户
	<span onclick="wxloginout();">退出登录</span></div>
	
	<div class="payment">
		<div class="payusername text-gray">
			<div class="payimg"></div>
			<div onclick="viewMyData();">
				<%if(u==null){ %>   
		        <a class="payname text-black2" href="${ctx}/weixin/wxuser/registerInit.ht">免费注册</a>
		      	<a class="payname text-black2" href="${ctx }/loginWeixin.jsp">立即登录</a>
		        <%}else{ %>
				<p ><span class="payname text-black2"><%=u.getLoginName() %></span>
				安全等级：<span class="text-orange2">${level }</span></p>
				<p >用户名：<%=u.getRealName() %></p>
				<%} %>
			</div>
			<span class="payicont">〉</span>
		</div>
		<div class="payList">
			<ul class="text-center">
				<li class="radiu background7 " onclick="getProjectInvest(0);">
					<div class="payListicont payListicont3"></div>
					<div class="text-white">申请中</div>
				</li>
				<li class="radiu background7 " onclick="getProjectInvest(1);">
					<div class="payListicont payListicont1"></div>
					<div class="text-white">持有中</div>
				</li>
				<li class="radiu background7 " onclick="getProjectInvest(2);">
					<div class="payListicont payListicont2"></div>
					<div class="text-white">已转让</div>
				</li>
				<li class="radiu background7 " onclick="getProjectInvest(3);">
					<div class="payListicont payListicont4"></div>
					<div class="text-white">已结束</div>
				</li>
			</ul>
		</div>
		<div class="payListli text-gray">
			<ul>
				<li class="boderbottom text-left" onclick="myFundsMsg();"><div class="payListliicont payListliicont1"></div><span class="payListspan">我的资产</span><span class="payicont">〉</span></li>
				<li class="boderbottom text-left"><div class="payListliicont payListliicont2"></div><span class="payListspan">可用余额</span><span class="leftspan"><span class="">${TUserFunds.available}</span>元</span></li>
				<li class="boderbottom text-left" onclick="fundsHistory();"><div class="payListliicont payListliicont3"></div><span class="payListspan">资金记录</span><span class="payicont">〉</span></li>
				<div class="clear"></div>
			</ul>
		</div>
	</div>
	
</body>

<script type="text/javascript">
	function wxloginout(){
		window.location.href = "${ctx}/weixin/wxuser/loginout.ht";
	}
	
	//项目状态相应列表
	function getProjectInvest(projectStatus){
		var platform = "";
		var havedPay = "";
		var isPayOff = "";
		var transferStateID = "";
		if(0 == projectStatus){
			platform = "1";//0=未审核，1=已审核
			havedPay = "0";//0=未放款，1=已放款
		}else if(1 == projectStatus){
			havedPay = "1";//0=未放款，1=已放款
			isPayOff = "0";//0=未还清，1=已还清
		}else if(2 == projectStatus){
			transferStateID = "2";//转让状态，0未转让 1转让中 2成功 3失败
		}else if(3 == projectStatus){
			isPayOff = "1";//0=未还清，1=已还清
		}
		var url = "${ctx}/weixin/wxmyaccount/getTProjectInvestByUserIdAndWhere.ht" +
					"?projectStatus=" + projectStatus + "&platform=" + platform + "&havedPay=" + havedPay
					+ "&isPayOff=" + isPayOff + "&transferStateID=" + transferStateID;
		window.location.href = url;
	}
	
	//查看我的资料
	function viewMyData(){
		window.location.href = "${ctx}/weixin/wxmyaccount/wxmyaccountPage.ht?dataMsg=1";
	}
	
	function myFundsMsg(){
		window.location.href = "${ctx}/weixin/wxmyaccount/wxMyFunds.ht";
	}
	
	//资金记录
	function fundsHistory(){
		window.location.href = "${ctx}/weixin/wxmyaccount/myFundsRecord.ht";
	}
</script>
</html>