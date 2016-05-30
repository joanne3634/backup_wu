<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>投资人列表</title>
	<meta name="renderer" content="webkit"/>
  	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/ProjectDynamic.css">
  <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/projectInvest.css">
   
   <script type="text/javascript">
   //私信详情显示层
function loadPagesSendMsgremind(p){
	valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
	if(p ==""){
		return;
	}	
	$.dialog.open('${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+p, {
		title: '发私信',lock:true});
}
   </script>
</head>
<body>
	
	<div class="window">
	 
		<div class="ProjectDynamicLeft f_l">
			<h3 class="clear"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">投资人列表</h3>
			<form action="" name="pageForm" id="pageForm">
			<div class="project_search">
			 用户名称：<input type="text" id="realName" name="realName" value="${realName}" /> 学校：<input type="text" id="school" name="school" value="${school}" />
	        <a href="javascript:clearForm()">&nbsp;清空&nbsp;</a>&nbsp;<a href="javascript:submitForm()">&nbsp;查询&nbsp;</a>
			</div>
			<ul>
			
			<c:if test="${!empty investorList}">
			<c:forEach items="${investorList}" var="ap">
            	<li>
						<table align="center" border="0" width="98%">
						<tr align="left">
						<td rowspan="5" width="100px">
						<div><img  width="100px" height="100px" src="${ctx }/file_upload/${ap.fileId}" 
						onerror="this.src='${ctx }/crowdfunding/resources/img/head_blank.png'" /></div>
						<div class="send_own_message"><a id="sendMsg" href="javascript:loadPagesSendMsgremind('${ap.userId}')">+发私信</a></div>
						</td>
						<td width="20px"></td>
						<td class="investor_name" ><a href="javascript:investorDetail('${ap.userId}')" >${ap.realName}</a></td>
						</tr>
						<tr align="left">
						<td width="20px"></td>
						<td><a href="javascript:investorDetail('${ap.userId}')" >>>详细资料</a></td>
						</tr>
						<tr align="left">
						<td width="20px"></td>
						<td >投资类型：<c:if test="${ap.piTypeID==1}">领投</c:if><c:if test="${ap.piTypeID==2}">领投</c:if>
						<c:if test="${ap.piTypeID==3}">跟投</c:if>
						</td>
						</tr>
						<tr align="left">
						<td width="20px"></td>
						<td >认投金额：<span style="color:#f00">

						<c:choose>  
						 <c:when test="${fn:contains(ap.piInvest,'.')}">
						 ${fn:substringBefore(ap.piInvest,".")}万
						 </c:when>  
						 <c:otherwise>${ap.piInvest}万</c:otherwise>
						</c:choose>

						</span>
						</td>
						</tr>
						<tr align="left">
						<td width="20px">&nbsp;</td>
						<td>
						认投时间：<fmt:formatDate value="${ap.piInvestTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						</tr>
						</table>
				</li>
				</c:forEach>
				</c:if>
            <c:if test="${empty investorList}">
         		<div class="queryResult">
            	找不到投资人
            	</div>
            </c:if>
			</ul>
			<pageTag:paging form="pageForm"/> 
		</div>

	</div>
</body>
</html>
	<script type="text/javascript">

function sendMsg(userId){
$.dialog.open('${ctx }/crowdfunding/tuser/sendMsgDialog.ht?userId='+userId,
	{title:'发送信息',width:600,height:400,lock:true});
}

function investorDetail(userId){
	
	$.dialog.open('${ctx }/crowdfunding/tuser/investorDetail.ht?userId='+userId,  
    {title: '用户信息', width: 700, height:500,lock:true});
	
	//$("#idt").click(function(){
	//	art.dialog.open('//www.baidu.com',
	//{title:'baidu',width:320,height:400});
	//}); 
}
function clearForm(userId){
	$("#realName").val("");
	$("#school").val("");
}
function submitForm(userId){
	$("#pageForm").submit();
}

	</script>
