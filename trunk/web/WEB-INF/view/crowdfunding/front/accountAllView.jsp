<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
	<meta charset="UTF-8">
	<title>资金概览</title>
	<meta name="renderer" content="webkit"/>
	<f:link href="${ctx}/js/lg/skins/Aqua/css/ligerui-all.css"></f:link>
	<f:link href="${ctx}/js/jquery/plugins/rowOps.css"></f:link>
 <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<style>
     body{
    text-align: left;
     color: #333;
  }
      .hyht-body {
        margin-bottom: 30px;
        overflow: hidden;
      }
      .hy-info {
        width: 810px;
        margin-bottom: 20px;
        padding: 20px 20px 32px 20px;
        border: 1px solid #f9d785;
        font-size: 14px;
      }
       #hy-jilu-tit {
            height: 46px;
            line-height: 46px;
            padding-left: 15px;
            border-top: 1px solid #f9d682;
            border-left: 1px solid #f9d682;
            border-right: 1px solid #f9d682;
            color: #ff5704;
            background-color: #fffbe9;
            font-size: 22px;
          }
          .hy-info select {
            width: 150px;
            border: none;
          }
          .select-box {
            height: 24px;
            display: inline-block;
            margin-right: 10px;
            border: 1px solid #faa980;
            line-height: 24px;
          }
          #condition {
            height: 26px;
            padding-bottom: 20px;
            border-bottom: 1px dashed #feb28c;
            line-height: 26px;
          }
          #condition a {
            display: inline-block;
            height: 26px;
            line-height: 26px;
            padding-left: 15px;
            padding-right: 15px;
            color: #fff;
            font-size: 14px;
            background-color: #ff6012;
            border-radius: 2px;
          }
          #condition a:hover {
            text-decoration: none;
          }
          .zijinjilu-ite {
            margin-top: 10px;
            margin-bottom: 10px;
          }
          .zijinjilu-ite span {
            display: inline-block;
            width: 220px;
            text-align: center;
          }
          .strong {
            font-size: 16px;
          }
    </style>
</head>
<body>
<script>
     function search(){
    	 document.getElementById('pageForm').submit();
     }
</script>
    <div class="hyht-body">
    <div class="PrDyBack f_l">
    <h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">资金概览</h2>
        <div class="hy-info" style="padding: 20px 20px 0px 20px;">
          <form id="_pageForm1" name="pageForm" action="${ctx }/crowdfunding/memberCenter/getUserInverstList.ht">
          <div id="condition" style="color:#ff6012;">总资产：
	             ${tcprojectInvest.piinvestTotal+askPricesincerity } 
	             
         <span style="color: black;font-size: 17px;" > &nbsp;&nbsp;&nbsp;= &nbsp;&nbsp;&nbsp;</span>   投资金额：
           	 ${tcprojectInvest.piinvestTotal } <span style="color: black;font-size: 17px;" > &nbsp;&nbsp;&nbsp;+ &nbsp;&nbsp;&nbsp;</span>
            	意向金：
            ${askPricesincerity }
            
          </div>
          <ul>
            <li class="zijinjilu-ite strong">
              <span>项目</span>
              <span>投资金额</span>
              <span>投资时间</span>
               <!--  <span>众筹结束时间</span> -->
              </li>
            <c:forEach items="${list}" var="item" varStatus="status">
				  <li class="zijinjilu-ite">
	             
	              <span>
				 
				   <c:choose>
	              	<c:when test="${ not empty item.pname}">${fn:substring(item.pname,0,14)}...</c:when>
	              	<c:otherwise> ${item.pname}</c:otherwise>
	              </c:choose>
				  </span>
	              <span><fmt:formatNumber value="${item.piinvest}" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber></span>
	               <span><fmt:formatDate value="${item.piinvestTime}" pattern="yyyy-MM-dd HH:mm"/></span>
	               <%-- <span><fmt:formatDate value="${item.pcloseDate}" pattern="yyyy-MM-dd"/></span> --%>
            </li>
		    </c:forEach>
			<c:if test="${empty list}"><li class="zijinjilu-ite"> 您还没有投资记录! </li></c:if>
          </ul>
           <pageTag:pagingInvest form="_pageForm1"/>
          </form>
        </div>
      </div>
    </div>
</body>
</html>