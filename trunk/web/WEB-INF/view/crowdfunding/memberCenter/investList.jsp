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
	<title>资金明细查询</title>
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
            width: 120px;
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
    <h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">资金记录</h2>
        <div class="hy-info" style="padding: 20px 20px 0px 20px;">
          <form id="pageForm" name="pageForm" action="${ctx }/crowdfunding/memberCenter/toinvestList.ht">
          <div id="condition" style="color:#ff6012;">资金类型：
            <div class="select-box">
	             <select id="zijinleixing" name="typeId" class="select" onchange="">
						<option value="" >所有类型</option>
						<c:forEach items="${zjldlist}" var="item" varStatus="status">
							<option value="${item.itemValue}" <c:if test="${item.itemValue eq  typeId}">selected</c:if>>
							       ${item.itemName}
							</option>
						</c:forEach>							
	            </select>
            </div>时间：
            <div class="select-box">
            <select name="timeBucket" id="createTime_id">
                <option value="" <c:if test="${selectEd eq '' }">selected</c:if>>所有</option>
                <option value="1" <c:if test="${selectEd eq '1' }">selected</c:if>>一周以内</option>
                <option value="2" <c:if test="${selectEd eq '2' }">selected</c:if>>半月以内</option>
                
                <option value="3" <c:if test="${selectEd eq '3' }">selected</c:if>>一月以内</option>
                <option value="4" <c:if test="${selectEd eq '4' }">selected</c:if>>二月以内</option>
                <option value="5" <c:if test="${selectEd eq '5' }">selected</c:if>>三月以内</option>
                <option value="6" <c:if test="${selectEd eq '6' }">selected</c:if>>半年以内</option>
                <option value="7" <c:if test="${selectEd eq '7' }">selected</c:if>>一年以内</option>
            </select>
            </div>
             <a href="javascript:search();">查 询</a>
          </div>
          <ul>
            <li class="zijinjilu-ite strong">
              <span>日期</span>
              <span>类型</span>
              <span>存入/支出</span>
              <span>余额</span>
              <span>说明</span>
              </li>
            <c:forEach items="${listVo}" var="item" varStatus="status">
				  <li class="zijinjilu-ite">
	              <span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
	              <span><f:description nodeKey="zjld" itemValue="${item.typeId}"></f:description></span>
	              <span><fmt:formatNumber value="${item.moneyInOut}" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber></span>
	              <span><fmt:formatNumber value="${item.moneyCurrent}" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber></span>
	              <span>${item.remark}</span>
            </li>
		    </c:forEach>
          </ul>
           <pageTag:pagingInvest form="pageForm"/>
          </form>
        </div>
      </div>
    </div>
</body>
</html>